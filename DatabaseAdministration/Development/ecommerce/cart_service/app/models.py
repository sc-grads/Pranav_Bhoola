# models.py
from sqlalchemy import Column, Integer, ForeignKey, Float
from sqlalchemy.orm import relationship
from .database import Base

class Cart(Base):
    __tablename__ = "carts"
    
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, index=True)  # Foreign key to user
    total = Column(Float, default=0.0)  # Total price of items in the cart
    items = relationship("CartItem", back_populates="cart")

class CartItem(Base):
    __tablename__ = "cart_items"
    
    id = Column(Integer, primary_key=True, index=True)
    product_id = Column(Integer, index=True)  # Foreign key to product
    cart_id = Column(Integer, ForeignKey("carts.id"))
    quantity = Column(Integer, nullable=False)
    price = Column(Float, nullable=False)  # Price at the time of adding to cart
    
    cart = relationship("Cart", back_populates="items")
