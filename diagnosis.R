
# Function to read and preprocess health data from a CSV file
read_health_data <- function(filepath) {
  data <- read.csv(filepath)# Read the CSV file
  data$bmi <- data$weight / (data$height / 100)^2 # Calculate BMI and add it as a new column
  return(data)
}


# Function to generate diagnosis and comments for each individual
generate_reports <- function(data) {
  library(dplyr) # Load necessary library
  data <- data %>%
  # Classify BMI into health categories
    mutate(
      diagnosis = case_when(
        bmi < 18.5 ~ "Underweight",
        bmi >= 18.5 & bmi < 25 ~ "Normal",
        bmi >= 25 & bmi < 30 ~ "Slight obesity",
        bmi >= 30 ~ "Severe obesity"
      ),
      comment = ifelse(smoker == TRUE, "Concerns are raised about the smoking.", "Non-smoker.")
    )
  return(data) # Return the updated dataframe with BMI, diagnosis, and comments
}

# Function to print individual health reports
print_reports <- function(data) {
  for (i in 1:nrow(data)) {
    cat("----Name: ", data$name[i], "----\n")
    cat("Age:", data$age[i], "\n")
    cat("BMI:", round(data$bmi[i], 1), "\n")
    cat("Diagnosis:", data$diagnosis[i], "\n")
    cat(data$comment[i], "\n\n")
  }
}
