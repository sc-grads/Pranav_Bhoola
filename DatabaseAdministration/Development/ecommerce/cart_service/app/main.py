from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from dotenv import load_dotenv
import os
from .routers import cart
from .database import Base, engine

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

app.include_router(cart.router, prefix="/api/carts", tags=["carts"])
