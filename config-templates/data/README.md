# Data Science / ML Project Configuration

This directory contains AI coding assistant configurations optimized for data science and machine learning projects in Python.

## What's Included

| File | For | Description |
|------|-----|-------------|
| `.cursorrules` | Cursor IDE | Data science development rules |
| `CLAUDE.md` | Claude Code CLI | Comprehensive ML project instructions |
| `.windsurfrules` | Windsurf IDE | Windsurf AI configuration |
| `.github/copilot-instructions.md` | GitHub Copilot | ML-specific Copilot instructions |

## What This Configuration Covers

### Data Science Workflow
- Exploratory Data Analysis (EDA)
- Data preprocessing and cleaning
- Feature engineering
- Model training and evaluation
- Hyperparameter tuning
- Model deployment

### Best Practices
- Reproducibility (random seeds, version control)
- Train/validation/test splits
- Baseline model comparisons
- Proper metrics for classification and regression
- Data leakage prevention
- Experiment tracking

### Code Organization
- Notebooks for exploration
- Python modules for production code
- Proper project structure
- Version control for data and models

## Key Principles

### 1. Reproducibility
```python
# Always set random seeds
import numpy as np
np.random.seed(42)

# In sklearn
model = RandomForestClassifier(random_state=42)

# In train_test_split
train_test_split(X, y, random_state=42)
```

### 2. Never Train on Test Data
```python
# ✅ Correct: Split first, then transform
X_train, X_test, y_train, y_test = train_test_split(X, y)
scaler.fit(X_train)
X_train_scaled = scaler.transform(X_train)
X_test_scaled = scaler.transform(X_test)

# ❌ Wrong: Transform before split
X_scaled = scaler.fit_transform(X)
X_train, X_test = train_test_split(X_scaled)
```

### 3. Always Use Baseline
```python
# Simple baseline (most frequent class)
baseline = DummyClassifier(strategy='most_frequent')
baseline.fit(X_train, y_train)
baseline_acc = baseline.score(X_test, y_test)

# Your model must beat this
model.fit(X_train, y_train)
model_acc = model.score(X_test, y_test)

assert model_acc > baseline_acc, "Model doesn't beat baseline!"
```

### 4. Appropriate Metrics
```python
# For imbalanced classification: use F1, not accuracy
from sklearn.metrics import f1_score, precision_score, recall_score

# For regression: MAE, RMSE, R²
from sklearn.metrics import mean_absolute_error, mean_squared_error, r2_score
```

## Project Structure
```
ml-project/
  ├── data/
  │   ├── raw/           # Original data (never modify)
  │   └── processed/     # Cleaned data
  ├── notebooks/         # Jupyter notebooks
  │   ├── 01_eda.ipynb
  │   ├── 02_modeling.ipynb
  │   └── 03_evaluation.ipynb
  ├── src/               # Production code
  │   ├── data/
  │   ├── features/
  │   ├── models/
  │   └── utils/
  ├── models/            # Saved models
  ├── reports/           # Figures and reports
  ├── tests/             # Unit tests
  ├── requirements.txt   # Dependencies
  └── README.md          # Project documentation
```

## Common Workflows

### Classification
1. Load data and EDA
2. Handle missing values
3. Train/val/test split (stratified)
4. Feature engineering
5. Baseline model (DummyClassifier)
6. Train model (start simple: LogisticRegression)
7. Evaluate: accuracy, precision, recall, F1
8. Hyperparameter tuning
9. Final evaluation on test set

### Regression
1. Load data and EDA
2. Handle missing values and outliers
3. Train/val/test split
4. Feature engineering and scaling
5. Baseline model (mean/median)
6. Train model (start simple: LinearRegression)
7. Evaluate: MAE, RMSE, R²
8. Residual analysis
9. Hyperparameter tuning
10. Final evaluation on test set

## Customization

Add your project specifics:
```markdown
## Our Project
- Problem: Predict customer churn
- Data: CRM database (100K rows, 50 features)
- Target: Binary classification (churn yes/no)
- Metric: F1 score (imbalanced dataset)
- Baseline: 82% accuracy (always predict no churn)
- Goal: Beat baseline with >0.6 F1 score
```

## Common Issues

### Overfitting
```markdown
Symptoms:
- High train accuracy, low validation accuracy
- Large gap between train and validation metrics

Solutions:
- Reduce model complexity
- Add regularization (L1, L2)
- Get more training data
- Use cross-validation
- Early stopping (for neural networks)
```

### Data Leakage
```markdown
Common causes:
- Fitting scaler on full dataset (including test)
- Features that include target information
- Time series: using future information
- Duplicates in train and test sets

Prevention:
- Always split data FIRST
- Understand feature creation logic
- Use temporal validation for time series
```

### Imbalanced Data
```markdown
Solutions:
- Use stratified splitting
- Class weights in model
- Resampling (SMOTE, undersampling)
- Use appropriate metrics (F1, not accuracy)
```

## Tools & Libraries

### Core Stack
- **pandas**: Data manipulation
- **numpy**: Numerical computing
- **scikit-learn**: ML algorithms
- **matplotlib/seaborn**: Visualization

### Deep Learning
- **PyTorch**: Deep learning
- **TensorFlow/Keras**: Deep learning
- **transformers**: NLP models

### Experiment Tracking
- **MLflow**: Experiment tracking
- **Weights & Biases**: Experiment tracking
- **TensorBoard**: Visualization

### Deployment
- **FastAPI**: API for model serving
- **Streamlit**: Interactive dashboards
- **Docker**: Containerization

## Examples
- [Kaggle Competitions](https://www.kaggle.com/competitions)
- [Scikit-learn Examples](https://scikit-learn.org/stable/auto_examples/)
- [MLflow Examples](https://github.com/mlflow/mlflow/tree/master/examples)

---

**Built for data scientists who want reproducible, production-ready ML pipelines.**
