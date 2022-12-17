/*
 * Script parameters
 */
params.data_dir = "$projectDir/data/"
params.scratch_dir = "$projectDir/scratch/"
params.src_dir = "$projectDir/source/"

/*
 * Prep modeling data
 */
Channel.fromPath("$params.data_dir/diabetes*.csv")
    .buffer(size: 6)
    .set { ch_rawData_forCleanData }

process CleanData {
    input:
        path 'data_in'
    
    output:
        path 'clean_data.csv'
    
    """
    Rscript $params.src_dir/data-prep.R data_in* clean_data.csv
    """
}

/*
 * Tune model hyper-parameters with Grid Search
 */
Channel.of( 10, 15, 20, 25, 30 ).set { ch_minSplit_forModelEst }
Channel.of( 18, 21, 24, 27, 30 ).set { ch_maxDepth_forModelEst }

process ModelEst {
    input:
        path clean_data
        each min_split
        each max_depth
    
    output:
        tuple path('oos_path.txt'), path('model_path.Rds')
    
    """
    Rscript $params.src_dir/tree.R \\
      $clean_data \\
      $min_split \\
      $max_depth \\
      model_path.Rds \\
      oos_path.txt
    """
}

/*
 * Generate report using our data, and optimal Decision Tree model
 */
process GenerateReport {
    publishDir params.src_dir, mode: 'move', overwrite: true

    input:
        tuple path(oos_error), path(model)
        path clean_data
    
    output:
        path 'analysis-report.html'

    """
    Rscript "$params.src_dir/generate-report.R" \\
      $clean_data \\
      $oos_error \\
      $model \\
      "$params.src_dir/analysis-report.qmd" \\
      analysis-report.html
    """
}

/*
 * Execute workflow
 */
workflow {
    CleanData(ch_rawData_forCleanData)
    ModelEst(CleanData.out, ch_minSplit_forModelEst, ch_maxDepth_forModelEst)
        | max { it[0].text }
    GenerateReport(ModelEst.out, CleanData.out)
}
