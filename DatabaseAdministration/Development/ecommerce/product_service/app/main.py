from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware  # Import CORS middleware
from dotenv import load_dotenv
import os
from .routers import product, categories, brands
from .database import Base, engine
from fastapi.staticfiles import StaticFiles

# Load environment variables from .env
load_dotenv()

# Create all tables in the database
Base.metadata.create_all(bind=engine)

app = FastAPI()

# Add CORS middleware to handle cross-origin requests
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Adjust this to restrict allowed origins as needed
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include product, categories, and brands router
app.include_router(product.router, prefix="/api/products", tags=["products"])
app.include_router(categories.router, prefix="/api/categories", tags=["categories"])
app.include_router(brands.router, prefix="/api/brands", tags=["brands"])  # Include brands router

app.mount("/static", StaticFiles(directory="app/static"), name="static")