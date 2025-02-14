from flask import Flask, request, jsonify
import torch
from PIL import Image
import io

app = Flask(__name__)

# Load YOLOv5 model
model = torch.hub.load('ultralytics/yolov5', 'custom', path='runs/train/exp3/weights/best.pt')

@app.route("/predict", methods=["POST"])
def predict():
    if "file" not in request.files:
        return jsonify({"error": "No file uploaded"}), 400

    file = request.files["file"]
    image = Image.open(io.BytesIO(file.read()))  # Read image file

    # Run inference
    results = model(image)
    predictions = results.pandas().xyxy[0].to_dict(orient="records")  # Convert results to JSON

    return jsonify(predictions)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)

from flask_cors import CORS

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes    