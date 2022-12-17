library(quarto)

args <- commandArgs(TRUE)

clean_data <- args[[1]]
oos_error <- args[[2]]
model <- args[[3]]
input_path <- args[[4]]
output_path <- args[[5]]

quarto_render(
  input = input_path,
  output_file = output_path,
  execute_params = list(
    data_path = clean_data,
    oos_error_path = oos_error,
    model_path = model
  ),
  execute_dir = getwd()
)