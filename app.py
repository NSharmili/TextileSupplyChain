from flask import Flask, render_template, request, jsonify, redirect, url_for,session
import pandas as pd
from sklearn.preprocessing import OneHotEncoder, StandardScaler, OrdinalEncoder
import joblib
import os
import logging
import requests
from tabpfn import TabPFNClassifier
import pickle
from sklearn.model_selection import train_test_split

app = Flask(__name__, template_folder='templates', static_folder='static')

# Directory paths
MODEL_DIR = 'Model'
scaler_path = os.path.join(MODEL_DIR, 'scaler.pkl')
ordinal_encoder_path = os.path.join(MODEL_DIR, 'ordinal_encoder.pkl')
onehot_encoder_path = os.path.join(MODEL_DIR, 'onehot_encoder.pkl')

with open(scaler_path, "rb") as f:
    loaded_scaler = pickle.load(f)
with open(ordinal_encoder_path, "rb") as f:
    loaded_ordinal_encoder = pickle.load(f)
with open(onehot_encoder_path, "rb") as f:
    loaded_onehot_encoder = pickle.load(f)

# Load dataset
file_path = "C://Users//likit//Downloads//Mock data sheet Telangana_Handloom_Textiles_1000_.xlsx"
df = pd.read_excel(file_path, sheet_name="Sheet1")

# Select relevant columns
df_selected = df[['Fabric Type', 'Fiber Blend', 'Dye Type', 'Dye Quality', 'Defects Detected']].copy()

# Convert 'Defects Detected' to binary classification
df_selected['Defects Detected'] = df_selected['Defects Detected'].apply(
    lambda x: 1 if 'color' in str(x).lower() else 0
)

# Encoding categorical features
ordinal_features = ['Dye Quality']
categorical_features = ['Fabric Type', 'Fiber Blend', 'Dye Type']

# Train and save encoders/scaler if not already saved
if not os.path.exists(scaler_path):
    ordinal_encoder = OrdinalEncoder()
    df_selected[ordinal_features] = ordinal_encoder.fit_transform(df_selected[ordinal_features])
    with open(ordinal_encoder_path, "wb") as f:
        pickle.dump(ordinal_encoder, f)

    onehot_encoder = OneHotEncoder(sparse=False, drop="first")
    X_encoded = onehot_encoder.fit_transform(df_selected[categorical_features])
    with open(onehot_encoder_path, "wb") as f:
        pickle.dump(onehot_encoder, f)

    scaler = StandardScaler()
    X_scaled = scaler.fit_transform(X_encoded)
    with open(scaler_path, "wb") as f:
        pickle.dump(scaler, f)
else:
    with open(ordinal_encoder_path, "rb") as f:
        ordinal_encoder = pickle.load(f)
    with open(onehot_encoder_path, "rb") as f:
        onehot_encoder = pickle.load(f)
    with open(scaler_path, "rb") as f:
        scaler = pickle.load(f)

# Apply transformations
df_selected[ordinal_features] = ordinal_encoder.transform(df_selected[ordinal_features])
X_encoded = onehot_encoder.transform(df_selected[categorical_features])

X = pd.DataFrame(X_encoded)
X[ordinal_features] = df_selected[ordinal_features].reset_index(drop=True)
X.columns = X.columns.astype(str)

# Scale features
X_scaled = scaler.transform(X)
y = df_selected['Defects Detected']

# Split data
X_train, X_test, y_train, y_test = train_test_split(X_scaled, y, test_size=0.3, random_state=42, stratify=y)

# Train TabPFN model
tabpfn_model = TabPFNClassifier(device='cpu')
tabpfn_model.fit(X_train, y_train)


@app.route('/')
def index():
    return render_template('index.html')

@app.route('/ContactUs')
def ContactUs():
    return render_template('ContactUs.html')

@app.route('/AboutUs')
def AboutUs():
    return render_template('About Us.html')



@app.route('/login')
def login():
    return render_template('Login.html')

@app.route('/Farmerregister')
def Farmerregister():
    return render_template('FarmerRegister.html')

@app.route('/YarnManufacturerregister')
def YarnManufacturerregister():
    return render_template('YarnManufacturerRegister.html')

@app.route('/Dyerregister')
def Dyerregister():
    return render_template('DyerRegister.html')

@app.route('/Weaverregister')
def Weaverregister():
    return render_template('WeaverRegister.html')

@app.route('/RetailerRegister')
def RetailerRegister():
    return render_template('RetailerRegister.html')

@app.route('/CustomerRegister')
def CustomerRegister():
    return render_template('CustomerRegister.html')

@app.route('/Collectrawdetails')
def Collectrawdetails():
    return render_template('CollectRawDetails.html')

@app.route('/Collectyarndetails')
def Collectyarndetails():
    return render_template('CollectYarn.html')

@app.route('/Collectdyedetails')
def Collectdyedetails():
    return render_template('CollectDye.html')

@app.route('/Collectweavedetails')
def Collectweavedetails():
    return render_template('CollectWeave.html')

@app.route('/retaildetails')
def retaildetails():
    return render_template('RetailDetails.html')

@app.route('/Customer')
def Customer():
    return render_template('customer.html')

@app.route('/redirect-to-page/<user_type>')
def redirect_to_page(user_type):
    # Define a dictionary to map user types to registration pages
    user_registration_pages = {
        'farmer': 'Farmerregister',
        'yarnManufacturer': 'YarnManufacturerregister',
        'dyer': 'Dyerregister',
        'weaver': 'Weaverregister',
        'retailer': 'RetailerRegister',
        'customer': 'CustomerRegister'
    }

    # Check if the user type is valid
    if user_type in user_registration_pages:
        # Get the corresponding registration page for the user type
        registration_page = user_registration_pages[user_type]
        # Construct the URL for the registration page
        redirect_url = url_for(registration_page)
        # Redirect the user to the registration page
        return redirect(redirect_url)
    else:
        # Handle invalid user types
        return "Invalid user type"

@app.route('/predict', methods=['POST'])
def predict():
    data = request.get_json()
    fabric_type = str(data['Fabric Type'])
    fiber_blend = str(data['Fiber Blend'])
    dye_type = str(data['Dye Type'])
    dye_quality = str(data['Dye Quality'])

    user_input = pd.DataFrame([[fabric_type, fiber_blend, dye_type, dye_quality]], 
                               columns=['Fabric Type', 'Fiber Blend', 'Dye Type', 'Dye Quality'])
    
    # Transform input data
    user_input[['Dye Quality']] = loaded_ordinal_encoder.transform(user_input[['Dye Quality']])
    user_encoded = loaded_onehot_encoder.transform(user_input[['Fabric Type', 'Fiber Blend', 'Dye Type']])
    
    user_X = pd.DataFrame(user_encoded)
    user_X[['Dye Quality']] = user_input[['Dye Quality']].reset_index(drop=True)
    user_X.columns = user_X.columns.astype(str)
    
    user_X_scaled = loaded_scaler.transform(user_X)
    
    prediction = tabpfn_model.predict(user_X_scaled)
    result = "Yes" if prediction[0] == 1 else "No"

    return jsonify({'Defect Prediction': 'No'})
if __name__ == '__main__':
    app.run(debug=True)