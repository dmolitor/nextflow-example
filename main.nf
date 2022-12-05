/*
 * Script parameters
 */
params.data_dir = "$projectDir/data/"
params.scratch_dir = "$projectDir/scratch/"
params.src_dir = "$projectDir/src/"

/*
 * Prep modeling data
 */
ch_rawData_forCleanData = Channel.fromPath("$params.data_dir/diabetes*.csv")
                                 .buffer(size: 6)
process CleanData {
  publishDir params.scratch_dir
  
  input:
  path 'data_in'
  
  output:
  path 'clean_data.csv'
  
  """
  Rscript $params.src_dir/data-prep.R data_in* clean_data.csv
  """
}

workflow {
  CleanData(ch_rawData_forCleanData)
}
