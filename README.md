# Credit Score Classification

This repository contains the code, data, and models for a credit score classification project. The goal of this project is to build and evaluate machine learning models to predict credit scores based on provided data.

## Repository Structure

- `data/`
  - `processed/`:
    - This directory will contain processed datasets.
  - `raw/`:
    - `old_test.csv`: Previous version of the test dataset.
    - `old_train.csv`: Previous version of the train dataset.
    - `test.csv`: Current test dataset.
    - `train.csv`: Current train dataset.

- `models/`:
  - `f_model.rds`: Final model saved as an RDS file.
  - `mlr.rds`: Multi-layer perceptron model.
  - `old_rf_model.rds`: Old random forest model.
  - `smote_model.rds`: Model trained with SMOTE.
  - `v2_smote_model.rds`: Version 2 of the SMOTE model.

- `reports/`:
  - `newplot.png`: Plot generated during the analysis.



- `src/R/`:
  - `data_preprocessing.ipynb`: Jupyter notebook for data preprocessing.
  - `logistic_regression.ipynb`: Jupyter notebook for logistic regression model.
  - `naive_bayes.ipynb`: Jupyter notebook for Naive Bayes model.
  - `old_data_preprocessing.ipynb`: Old version of data preprocessing.
  - `old_logistic_regression.ipynb`: Old version of logistic regression model.
  - `old_naive_bayes.ipynb`: Old version of Naive Bayes model.
  - `old_random_forest.ipynb`: Old version of random forest model.
  - `old_svm.ipynb`: Old version of support vector machine model.
  - `random_forest.ipynb`: Jupyter notebook for random forest model.

- `website/`:
  - `webapp.ipynb`: Jupyter notebook for creating a web application.

- `.gitignore`: Git ignore file to exclude unnecessary files from version control.
- `CONTRIBUTING.md`: Guidelines for contributing to this repository.
- `README.md`: This file.

## Getting Started

### Prerequisites

- R and RStudio
- Jupyter Notebook
- Required R libraries (listed in the notebooks)

### Installation

1. Clone the repository:

```bash
git clone https://github.com/arya2004/credit_score_classification.git
```

2. Navigate to the project directory:

```bash
cd credit_score_classification
```

3. Install the required libraries. You can find the list of required libraries in each Jupyter notebook (e.g., `random_forest.ipynb`).

### Usage

1. **Data Preprocessing**:
   - Use `src/R/data_preprocessing.ipynb` to preprocess the raw data.

2. **Model Training**:
   - Train different models using the respective notebooks in `src/R/` (e.g., `logistic_regression.ipynb`, `naive_bayes.ipynb`, `random_forest.ipynb`).

3. **Model Evaluation**:
   - Evaluate the models and compare their performance.

4. **Web Application**:
   - Create a web application using `website/webapp.ipynb` to deploy the final model.

## Contributing

Please read the `CONTRIBUTING.md` file for guidelines on contributing to this project.

## License

This project is licensed under the MIT License - see the `LICENSE.md` file for details.

## Acknowledgements

- Thanks to Professor Abha Marathe who guided this project.
- Thanks to all the contributors.

