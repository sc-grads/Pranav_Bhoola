from fastapi import FastAPI
from .database import Base, engine
from .routers import cart

Base.metadata.create_all(bind=engine)

app = FastAPI()

app.include_router(cart.router, prefix="/api/cart", tags=["cart"])
