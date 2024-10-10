from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from dotenv import load_dotenv
import os
from .routers import user
from .database import Base, engine

# Load environment variables from .env
load_dotenv()

# Create all tables in the database
Base.metadata.create_all(bind=engine)

app = FastAPI()

# Enable CORS for all origins (adjust as needed)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Change this to your frontend URL if necessary
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include the user router for user-related endpoints
app.include_router(user.router, prefix="/api/users", tags=["users"])
