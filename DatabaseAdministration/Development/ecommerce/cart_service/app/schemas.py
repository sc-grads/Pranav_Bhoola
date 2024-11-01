# cart_service/app/schemas.py
from pydantic import BaseModel

class CartItemBase(BaseModel):
    product_id: int
    quantity: int = 1

class CartItemCreate(CartItemBase):
    price: float

class CartItem(CartItemCreate):
    id: int
    cart_id: int

    class Config:
        orm_mode = True

class Cart(BaseModel):
    id: int
    user_id: int
    items: list[CartItem] = []

    class Config:
        orm_mode = True
