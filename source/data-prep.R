args <- commandArgs(TRUE)

# Combine input data
data <- lapply(
  args[1:(length(args) - 1)],
  \(path) {
    read.csv(path) |>
      transform(diabetes = factor(diabetes, levels = c("neg", "pos")))
  }
)
data <- do.call(rbind, data)

# Output data
write.csv(data, args[[length(args)]], row.names = FALSE)