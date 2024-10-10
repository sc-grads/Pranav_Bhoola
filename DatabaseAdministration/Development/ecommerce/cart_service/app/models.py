from sqlalchemy import Column, Integer, ForeignKey, Float
from sqlalchemy.orm import relationship
from .database import Base

class Cart(Base):
    __tablename__ = "carts"
    
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, index=True)  # Foreign key to user, assumed to be passed
    items = relationship("CartItem", back_populates="cart")

class CartItem(Base):
    __tablename__ = "cart_items"
    
    id = Column(Integer, primary_key=True, index=True)
    product_id = Column(Integer, index=True)  # Foreign key to product
    cart_id = Column(Integer, ForeignKey("carts.id"))
    quantity = Column(Integer, nullable=False)
    price = Column(Float, nullable=False)  # Price at the time of adding to cart
    
    cart = relationship("Cart", back_populates="items")
