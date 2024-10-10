from fastapi import APIRouter, Depends, HTTPException, UploadFile, File, Form
from sqlalchemy.orm import Session
from app.database import SessionLocal
from .. import models, schemas # Assuming models.py and schemas.py are in the same app directory
from ..utils import save_image  # Ensure this function is defined properly
from ..schemas import ProductCreate, ProductUpdate
from ..models import Category, Brand

router = APIRouter()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.post("/", response_model=schemas.Product)
async def create_product(
    name: str = Form(...),
    description: str = Form(...),
    price: float = Form(...),
    category_name: str = Form(...),
    brand_name: str = Form(...),  # Add brand_name
    file: UploadFile = File(...),
    db: Session = Depends(get_db),
):
    image_url = save_image(file)

    # Check if the category already exists
    db_category = db.query(models.Category).filter(models.Category.name == category_name).first()
    if db_category is None:
        db_category = models.Category(name=category_name)
        db.add(db_category)
        db.commit()
        db.refresh(db_category)

    # Check if the brand already exists
    db_brand = db.query(models.Brand).filter(models.Brand.name == brand_name).first()
    if db_brand is None:
        db_brand = models.Brand(name=brand_name)
        db.add(db_brand)
        db.commit()
        db.refresh(db_brand)

    # Create the product with category and brand IDs
    db_product = models.Product(
        name=name,
        description=description,
        price=price,
        image_url=image_url,
        category_id=db_category.id,
        brand_id=db_brand.id  # Use the ID of the existing or newly created brand
    )
    db.add(db_product)
    db.commit()
    db.refresh(db_product)
    return db_product


@router.get("/", response_model=list[schemas.Product])
def read_products(page: int = 1, page_size: int = 10, category_id: int = None, brand_id: int = None, db: Session = Depends(get_db)):
    skip = (page - 1) * page_size
    query = db.query(models.Product)

    if category_id:
        query = query.filter(models.Product.category_id == category_id)  # Filter by category ID
    
    if brand_id:
        query = query.filter(models.Product.brand_id == brand_id)  # Filter by brand ID

    products = query.offset(skip).limit(page_size).all()
    return products


@router.get("/count")
def count_products(db: Session = Depends(get_db)):
    total_count = db.query(models.Product).count()
    return {"total_count": total_count}

@router.get("/{product_id}", response_model=schemas.Product)
def read_product(product_id: int, db: Session = Depends(get_db)):
    product = db.query(models.Product).filter(models.Product.id == product_id).first()
    if product is None:
        raise HTTPException(status_code=404, detail="Product not found")
    return product

@router.put("/{product_id}", response_model=schemas.Product)
def update_product(product_id: int, product: ProductUpdate, db: Session = Depends(get_db)):
    db_product = db.query(models.Product).filter(models.Product.id == product_id).first()
    if db_product is None:
        raise HTTPException(status_code=404, detail="Product not found")

    # Update only the fields that are provided
    if product.name is not None:
        db_product.name = product.name
    if product.description is not None:
        db_product.description = product.description
    if product.price is not None:
        db_product.price = product.price

    db.commit()
    db.refresh(db_product)
    return db_product

@router.delete("/{product_id}")
def delete_product(product_id: int, db: Session = Depends(get_db)):
    db_product = db.query(models.Product).filter(models.Product.id == product_id).first()
    if db_product is None:
        raise HTTPException(status_code=404, detail="Product not found")
    
    db.delete(db_product)
    db.commit()
    return {"detail": "Product deleted"}