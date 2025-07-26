from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field, validator
import joblib
import pandas as pd
import os
import uvicorn

# Create FastAPI app
app = FastAPI(
    title="Health Cost Prediction API",
    description="API for predicting health insurance costs based on personal factors",
    version="1.0.0"
)

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allows all origins
    allow_credentials=True,
    allow_methods=["*"],  # Allows all methods
    allow_headers=["*"],  # Allows all headers
)

# Define input data model with validation
class HealthData(BaseModel):
    age: int = Field(..., ge=18, le=100, description="Age of the person (18-100)")
    sex: str = Field(..., description="Sex of the person (male/female)")
    bmi: float = Field(..., ge=15, le=50, description="Body Mass Index (15-50)")
    children: int = Field(..., ge=0, le=10, description="Number of children/dependents (0-10)")
    smoker: str = Field(..., description="Smoking status (yes/no)")
    region: str = Field(..., description="Region (northeast/northwest/southeast/southwest)")

    # Validators
    @validator('sex')
    def validate_sex(cls, v):
        if v.lower() not in ['male', 'female']:
            raise ValueError('Sex must be either "male" or "female"')
        return v.lower()

    @validator('smoker')
    def validate_smoker(cls, v):
        if v.lower() not in ['yes', 'no']:
            raise ValueError('Smoker must be either "yes" or "no"')
        return v.lower()

    @validator('region')
    def validate_region(cls, v):
        valid_regions = ['northeast', 'northwest', 'southeast', 'southwest']
        if v.lower() not in valid_regions:
            raise ValueError(f'Region must be one of {valid_regions}')
        return v.lower()

# Load the trained model
@app.on_event("startup")
async def load_model():
    global model
    # Try multiple possible paths
    possible_paths = [
        "health_cost_model.pkl",
        os.path.join(os.path.dirname(__file__), "health_cost_model.pkl"),
        "/opt/render/project/src/summative/API/health_cost_model.pkl"
    ]
    
    model = None
    for model_path in possible_paths:
        if os.path.exists(model_path):
            try:
                model = joblib.load(model_path)
                print(f"Model loaded successfully from {model_path}")
                break
            except Exception as e:
                print(f"Error loading model from {model_path}: {e}")
                continue
    
    if model is None:
        print(f"Warning: Model file not found in any of these paths: {possible_paths}")
        print(f"Current working directory: {os.getcwd()}")
        print(f"Files in current directory: {os.listdir('.')}")

# Health cost prediction endpoint
@app.post("/predict", response_model=dict)
async def predict_health_cost(data: HealthData):
    if model is None:
        raise HTTPException(status_code=500, detail="Model not loaded")
    
    # Perform the same feature engineering as in the notebook
    input_df = pd.DataFrame([data.dict()])

    # 1. Create numeric features for sex and smoker
    input_df['sex_numeric'] = input_df['sex'].apply(lambda x: 1 if x == 'male' else 0)
    input_df['smoker_numeric'] = input_df['smoker'].apply(lambda x: 1 if x == 'yes' else 0)

    # 2. Create interaction and polynomial features
    input_df['smoker_age'] = input_df['smoker_numeric'] * input_df['age']
    input_df['smoker_bmi'] = input_df['smoker_numeric'] * input_df['bmi']
    input_df['bmi_squared'] = input_df['bmi'] ** 2

    # 3. Define the feature set the model was trained on
    # Note: We are ignoring 'region' as it wasn't used in the final model
    model_features = [
        'age',
        'bmi',
        'children',
        'smoker_numeric',
        'sex_numeric',
        'smoker_age',
        'smoker_bmi',
        'bmi_squared'
    ]
    
    final_input = input_df[model_features]

    # Make prediction
    prediction = model.predict(final_input)[0]
    
    return {
        "predicted_cost": round(float(prediction), 2),
        "input_data": data.dict()
    }

# Root endpoint
@app.get("/")
async def root():
    return {
        "message": "Health Cost Prediction API",
        "docs_url": "/docs",
        "health_check": "OK"
    }

# Run the API with uvicorn
if __name__ == "__main__":
    import os
    port = int(os.environ.get("PORT", 8000))
    uvicorn.run("prediction:app", host="0.0.0.0", port=port)