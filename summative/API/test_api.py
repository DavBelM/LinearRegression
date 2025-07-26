#!/usr/bin/env python3
"""
Test script to verify the API works locally before deployment
"""
import sys
import os
sys.path.append(os.path.dirname(__file__))

try:
    import joblib
    import pandas as pd
    from prediction import app
    
    # Test model loading
    model_path = "health_cost_model.pkl"
    if os.path.exists(model_path):
        model = joblib.load(model_path)
        print("✅ Model loaded successfully")
        
        # Test prediction
        test_data = pd.DataFrame({
            'age': [30],
            'sex': ['male'],
            'bmi': [25.0],
            'children': [1],
            'smoker': ['no'],
            'region': ['southwest']
        })
        
        prediction = model.predict(test_data)[0]
        print(f"✅ Test prediction: ${prediction:.2f}")
        
    else:
        print("❌ Model file not found")
        
    print("✅ All imports successful - API should work")
    
except Exception as e:
    print(f"❌ Error: {e}")
    print("Need to regenerate model with compatible versions")