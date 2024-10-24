# schemas.py
from pydantic import BaseModel
from typing import List

class CartItemBase(BaseModel):
    product_id: int
    quantity: int
    price: float

class CartItemCreate(CartItemBase):
    pass

class CartItem(CartItemBase):
    id: int
    cart_id: int

    class Config:
        orm_mode = True

class CartBase(BaseModel):
    user_id: int

class CartCreate(CartBase):
    items: List[CartItemCreate]

class Cart(CartBase):
    id: int
    total: float  # Add total here
    items: List[CartItem]

    class Config:
        orm_mode = True
