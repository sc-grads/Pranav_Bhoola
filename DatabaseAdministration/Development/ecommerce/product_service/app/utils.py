# utils.py
import os
from fastapi import UploadFile, File
from fastapi.responses import JSONResponse

UPLOAD_DIR = "app/static/images"  # Directory to store images

def save_image(file: UploadFile) -> str:
    if not os.path.exists(UPLOAD_DIR):
        os.makedirs(UPLOAD_DIR)  # Create the directory if it doesn't exist

    file_location = os.path.join(UPLOAD_DIR, file.filename)
    with open(file_location, "wb+") as file_object:
        file_object.write(file.file.read())
    
    return f"/static/images/{file.filename}"  # Return the URL for the saved image

