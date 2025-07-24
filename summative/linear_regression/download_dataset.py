import os
import kagglehub

# Create directory if it doesn't exist
os.makedirs(os.path.dirname(os.path.abspath(__file__)), exist_ok=True)

# Download the insurance dataset
path = kagglehub.dataset_download("mirichoi0218/insurance", path=os.path.dirname(os.path.abspath(__file__)))

print("Dataset downloaded to:", path)