
# Load other script files
source("diagnosis.R")
source("visualization.R")

# Main Process
# Load CSV health data and calculate BMI
data <- read_health_data("health_check.csv")
# Generate diagnosis and comments based on BMI
results <- generate_reports(data)
# Print detailed individual reports
print_reports(results)
# Generate two graphs and save as images
generate_graphs(results)