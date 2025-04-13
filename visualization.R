
# Function to generate two types of graphs: a scatter plot and a pie chart
generate_graphs <- function(data) {
  # Load libraries for graphing and data manipulation
  library(ggplot2)
  library(dplyr)
  
  # Graph1: Age and BMI scatter
  p1 <- ggplot(data, aes(x = age, y = bmi, color = smoker)) +
    geom_point(size = 4) +
    geom_hline(yintercept = c(18.5, 25, 30), linetype = "dashed", color = "gray") +
    labs(title = "Age and BMI", x = "Age", y = "BMI") +
    scale_color_manual(values = c("TRUE" = "red", "FALSE" = "blue"), name = "Smoker") +
    theme_minimal()
  # Save the scatter plot to a PNG file
  ggsave("bmi_age_scatter.png", plot = p1, width = 8, height = 5)
  
  # Graph2: BMI category pie chart
  count_data <- data %>%
    group_by(diagnosis) %>%
    summarise(count = n())%>%
    mutate(
      label = paste0(diagnosis, "\n", count)  # Label
    )
  
  p2 <- ggplot(count_data, aes(x = "", y = count, fill = diagnosis)) +
    geom_bar(stat = "identity", width = 1) +
    coord_polar("y") +                    # Convert to pie chart
    labs(title = "Summary of BMI diagnosis") +
    theme_void()+                          # Remove axes and grid
    geom_text(aes(label = label),
              position = position_stack(vjust = 0.5),  # Place labels at the center
              size = 4, color = "white") +             # Text size, color
    theme(legend.position = "none")
  # Save the pie chart
  ggsave("bmi_piechart.png", plot = p2, width = 6, height = 6)
}
