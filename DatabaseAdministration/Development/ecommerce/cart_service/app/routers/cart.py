# cart_service/app/routers/cart.py
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.database import SessionLocal
from app import models, schemas
from typing import List
from fastapi.security import OAuth2PasswordBearer
from jose import jwt
from datetime import datetime, timedelta
import os

router = APIRouter()
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="api/users/login")
SECRET_KEY = os.getenv("SECRET_KEY")
ALGORITHM = "HS256"

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

def verify_token(token: str, db: Session):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        user_id: int = payload.get("user_id")  # Change from "sub" to "user_id"
        if user_id is None:
            raise HTTPException(status_code=403, detail="Invalid token")
        return user_id
    except jwt.JWTError:
        raise HTTPException(status_code=403, detail="Invalid token")

@router.post("/add-to-cart", response_model=schemas.CartItem)
def add_to_cart(item: schemas.CartItemCreate, token: str = Depends(oauth2_scheme), db: Session = Depends(get_db)):
    user_id = verify_token(token, db)
    cart = db.query(models.Cart).filter(models.Cart.user_id == user_id).first()
    if not cart:
        cart = models.Cart(user_id=user_id)
        db.add(cart)
        db.commit()
        db.refresh(cart)

    cart_item = models.CartItem(
        cart_id=cart.id,
        product_id=item.product_id,
        quantity=item.quantity,
        price=item.price,
    )
    db.add(cart_item)
    db.commit()
    db.refresh(cart_item)
    return cart_item

@router.get("/cart", response_model=schemas.Cart)
def get_cart(token: str = Depends(oauth2_scheme), db: Session = Depends(get_db)):
    user_id = verify_token(token, db)
    cart = db.query(models.Cart).filter(models.Cart.user_id == user_id).first()
    if not cart:
        raise HTTPException(status_code=404, detail="Cart not found")
    return cart

@router.delete("/cart-item/{item_id}", response_model=schemas.CartItem)
def delete_cart_item(item_id: int, token: str = Depends(oauth2_scheme), db: Session = Depends(get_db)):
    user_id = verify_token(token, db)
    
    # Retrieve the cart item
    cart_item = db.query(models.CartItem).filter(models.CartItem.id == item_id).first()
    if not cart_item:
        raise HTTPException(status_code=404, detail="Cart item not found")
    
    # Ensure the cart item belongs to the user's cart
    cart = db.query(models.Cart).filter(models.Cart.id == cart_item.cart_id, models.Cart.user_id == user_id).first()
    if not cart:
        raise HTTPException(status_code=403, detail="Unauthorized to delete this cart item")

    # Delete the cart item
    db.delete(cart_item)
    db.commit()
    
    return cart_item
