library(rpart)

args <- commandArgs(TRUE)

input_data <- args[[1]]
min_split <- as.integer(args[[2]])
max_depth <- as.integer(args[[3]])
model_path <- args[[4]]
oos_path <- args[[5]]

input_data <- read.csv(input_data) |>
  transform(diabetes = factor(diabetes, levels = c("neg", "pos")))

# Split data into train/test split
set.seed(123)
idx <- sort(sample(1:nrow(input_data), round(0.8*nrow(input_data))))
train <- input_data[idx, ]
test <- input_data[-idx, ]

# Train decision tree model
tree <- rpart(
  formula = diabetes ~ .,
  data = train,
  method = "class",
  control = list(
    minsplit = min_split,
    maxdepth = max_depth
  )
)
saveRDS(tree, file = model_path)

# Calculate OOS Accuracy
predictions <- as.character(predict(tree, test, type = "class"))
truth <- as.character(test$diabetes)
accuracy <- sum(predictions == truth)/length(predictions)
writeLines(as.character(round(accuracy, 5)), oos_path)