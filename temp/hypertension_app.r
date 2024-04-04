library(shiny)
library(caret)
library(e1071)
library(randomForest)
library(kernlab)
library(naivebayes)

# Load your dataset
hypertension <- read.csv("D:/Ilu/VIT 2nd year/Data Science/DS Lab/hypertension_data - Copy.csv")

# Convert the "target" variable to a factor
hypertension$target <- as.factor(hypertension$target)

# Handle missing values by removing rows with missing data
hypertension <- na.omit(hypertension)

# Define the Shiny app
ui <- fluidPage(
  tags$head(
    # Add your custom CSS styles here
    tags$style(HTML("
      .sidebar-panel {
        background-color: #f3f3f3;
        padding: 15px;
        border-radius: 10px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      }
      body {
        background-color: #ecf0f5;
      }
    "))
  ),
  titlePanel("Hypertension Prediction", windowTitle = "Hypertension Predictor"),
  sidebarLayout(
    sidebarPanel(
      h3("Patient Information", style = "color: #3498db;"),
      div(class = "sidebar-panel",
          sliderInput("age", "Age:", min = 18, max = 100, value = 50),
          selectInput("sex", "Sex:", choices = c("Male", "Female")),
          selectInput("cp", "Chest Pain Type:", choices = c(1, 2, 3, 4)),
          sliderInput("trestbps", "Resting Blood Pressure:", min = 90, max = 200, value = 120),
          sliderInput("chol", "Cholesterol:", min = 100, max = 400, value = 200),
          selectInput("fbs", "Fasting Blood Sugar:", choices = c(0, 1)),
          selectInput("restecg", "Resting ECG Results:", choices = c(0, 1, 2)),
          sliderInput("thalach", "Maximum Heart Rate:", min = 70, max = 200, value = 150),
          selectInput("exang", "Exercise Induced Angina:", choices = c(0, 1)),
          sliderInput("oldpeak", "ST Depression:", min = 0, max = 6, value = 1),
          selectInput("slope", "Slope of ST Segment:", choices = c(0, 1, 2)),
          selectInput("ca", "Number of Major Vessels:", choices = c(0, 1, 2, 3)),
          selectInput("thal", "Thalassemia:", choices = c(0, 1, 2, 3)),
          br(),
          actionButton("predict_logistic", "Predict (Logistic Regression)"),
          actionButton("predict_svm", "Predict (SVM)"),
          actionButton("predict_rf", "Predict (Random Forest)"),
          actionButton("predict_nb", "Predict (Naive Bayes)")
      )
    ),
    mainPanel(
      h3("Hypertension Prediction Result:"),
      verbatimTextOutput("prediction_result"),
      verbatimTextOutput("accuracy_result")
    )
  )
)

server <- function(input, output) {
  user_data <- reactive({
    data.frame(
      age = input$age,
      sex = as.numeric(input$sex == "Female"),
      cp = as.integer(input$cp),
      trestbps = input$trestbps,
      chol = input$chol,
      fbs = as.integer(input$fbs),
      restecg = as.integer(input$restecg),
      thalach = input$thalach,
      exang = as.integer(input$exang),
      oldpeak = input$oldpeak,
      slope = as.integer(input$slope),
      ca = as.integer(input$ca),
      thal = as.integer(input$thal)
    )
  })
  
  observeEvent(input$predict_logistic, {
    # Logistic Regression
    model_logistic <- glm(target ~ ., data = hypertension, family = binomial)
    prediction_logistic <- ifelse(predict(model_logistic, newdata = user_data(), type = "response") > 0.5, "Hypertension detected.", "No hypertension detected.")
    
    accuracy_logistic <- sum(!is.na(predict(model_logistic, newdata = hypertension, type = "response") > 0.5)) / nrow(hypertension)
    
    output$prediction_result <- renderPrint({
      paste("Prediction (Logistic Regression):", prediction_logistic)
    })
    
    output$accuracy_result <- renderPrint({
      paste("Accuracy (Logistic Regression):", round(accuracy_logistic * 100, 2), "%")
    })
  })
  
  observeEvent(input$predict_svm, {
    # Support Vector Machine (SVM)
    model_svm <- svm(target ~ ., data = hypertension, kernel = "radial")
    prediction_svm <- ifelse(predict(model_svm, newdata = user_data()) == 1, "Hypertension detected.", "No hypertension detected.")
    
    accuracy_svm <- sum(predict(model_svm, newdata = hypertension) == hypertension$target) / nrow(hypertension)
    
    output$prediction_result <- renderPrint({
      paste("Prediction (SVM):", prediction_svm)
    })
    
    output$accuracy_result <- renderPrint({
      paste("Accuracy (SVM):", round(accuracy_svm * 100, 2), "%")
    })
  })
  
  observeEvent(input$predict_rf, {
    # Random Forest
    model_rf <- randomForest(target ~ ., data = hypertension)
    prediction_rf <- ifelse(predict(model_rf, newdata = user_data()) == 1, "Hypertension detected.", "No hypertension detected.")
    
    accuracy_rf <- sum(predict(model_rf, newdata = hypertension) == hypertension$target) / nrow(hypertension)
    
    output$prediction_result <- renderPrint({
      paste("Prediction (Random Forest):", prediction_rf)
    })
    
    output$accuracy_result <- renderPrint({
      paste("Accuracy (Random Forest):", round(accuracy_rf * 100, 2), "%")
    })
  })
  
  
  observeEvent(input$predict_nb, {
    # Naive Bayes
    model_nb <- naive_bayes(target ~ ., data = hypertension)
    prediction_nb <- ifelse(predict(model_nb, newdata = user_data()) == 1, "Hypertension detected.", "No hypertension detected.")
    
    accuracy_nb <- sum(predict(model_nb, newdata = hypertension) == hypertension$target) / nrow(hypertension)
    
    output$prediction_result <- renderPrint({
      paste("Prediction (Naive Bayes):", prediction_nb)
    })
    
    output$accuracy_result <- renderPrint({
      paste("Accuracy (Naive Bayes):", round(accuracy_nb * 100, 2), "%")
    })
  })
}

shinyApp(ui = ui, server = server)
