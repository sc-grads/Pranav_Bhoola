# cart_service/app/models.py
from sqlalchemy import Column, Integer, ForeignKey, Float
from sqlalchemy.orm import relationship
from .database import Base

class Cart(Base):
    __tablename__ = "cart"
    
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, index=True)  # Link to user
    
    # Define relationship with CartItem
    items = relationship("CartItem", back_populates="cart")

class CartItem(Base):
    __tablename__ = "cart_item"

    id = Column(Integer, primary_key=True, index=True)
    cart_id = Column(Integer, ForeignKey("cart.id"))
    product_id = Column(Integer, index=True)
    quantity = Column(Integer, nullable=False, default=1)
    price = Column(Float, nullable=False)
    
    cart = relationship("Cart", back_populates="items")
