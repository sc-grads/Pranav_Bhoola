from sqlalchemy import Column, Integer, String, ForeignKey, Float
from sqlalchemy.orm import relationship
from .database import Base

class Category(Base):
    __tablename__ = "category"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, unique=True, index=True)

    product = relationship("Product", back_populates="category")

class Brand(Base):
    __tablename__ = "brand"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, unique=True, index=True)

    product = relationship("Product", back_populates="brand")

class Product(Base):
    __tablename__ = "product"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, index=True)
    description = Column(String)
    price = Column(Float)
    image_url = Column(String, default='static/default-product.jpg')
    category_id = Column(Integer, ForeignKey("category.id"))
    brand_id = Column(Integer, ForeignKey("brand.id"))

    category = relationship("Category", back_populates="product")
    brand = relationship("Brand", back_populates="product")
    
