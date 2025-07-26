from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field, validator
import joblib
import numpy as np
import uvicorn

app = FastAPI(
    title="Health Cost Prediction API",
    description="API for predicting health insurance costs",
    version="1.0.0"
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class HealthData(BaseModel):
    age: int = Field(..., ge=18, le=100)
    sex: str = Field(...)
    bmi: float = Field(..., ge=15, le=50)
    children: int = Field(..., ge=0, le=10)
    smoker: str = Field(...)
    region: str = Field(...)

    @validator('sex')
    def validate_sex(cls, v):
        if v.lower() not in ['male', 'female']:
            raise ValueError('Sex must be "male" or "female"')
        return v.lower()

    @validator('smoker')
    def validate_smoker(cls, v):
        if v.lower() not in ['yes', 'no']:
            raise ValueError('Smoker must be "yes" or "no"')
        return v.lower()

    @validator('region')
    def validate_region(cls, v):
        valid_regions = ['northeast', 'northwest', 'southeast', 'southwest']
        if v.lower() not in valid_regions:
            raise ValueError(f'Region must be one of {valid_regions}')
        return v.lower()

# Load model on startup
model = None

@app.on_event("startup")
async def load_model():
    global model
    try:
        model = joblib.load("health_cost_model.pkl")
    except:
        model = None

def prepare_input(data: HealthData):
    """Convert input data to model format without pandas"""
    # Manual encoding based on training data
    features = []
    
    # Numerical features (standardized)
    features.extend([
        (data.age - 39.2) / 14.0,  # age standardized
        (data.bmi - 30.7) / 6.1,   # bmi standardized  
        (data.children - 1.1) / 1.2  # children standardized
    ])
    
    # Categorical features (one-hot encoded)
    # sex: male=1, female=0 (drop first)
    features.append(1 if data.sex == 'male' else 0)
    
    # smoker: yes=1, no=0 (drop first) 
    features.append(1 if data.smoker == 'yes' else 0)
    
    # region: one-hot encoded (drop first=northeast)
    region_features = [0, 0, 0]  # northwest, southeast, southwest
    if data.region == 'northwest':
        region_features[0] = 1
    elif data.region == 'southeast':
        region_features[1] = 1
    elif data.region == 'southwest':
        region_features[2] = 1
    
    features.extend(region_features)
    
    return np.array([features])

@app.post("/predict")
async def predict_health_cost(data: HealthData):
    if model is None:
        raise HTTPException(status_code=500, detail="Model not loaded")
    
    try:
        input_array = prepare_input(data)
        prediction = model.predict(input_array)[0]
        
        return {
            "predicted_cost": round(float(prediction), 2),
            "input_data": data.dict()
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Prediction error: {str(e)}")

@app.get("/")
async def root():
    return {"message": "Health Cost Prediction API", "status": "OK"}

if __name__ == "__main__":
    uvicorn.run("prediction_minimal:app", host="0.0.0.0", port=8000)