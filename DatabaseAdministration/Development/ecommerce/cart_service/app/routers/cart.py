from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from ..database import SessionLocal
from .. import models, schemas

router = APIRouter()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.post("/", response_model=schemas.Cart)
def create_cart(cart: schemas.CartCreate, db: Session = Depends(get_db)):
    db_cart = models.Cart(user_id=cart.user_id)
    db.add(db_cart)
    db.commit()
    db.refresh(db_cart)
    
    for item in cart.items:
        db_cart_item = models.CartItem(
            product_id=item.product_id,
            quantity=item.quantity,
            price=item.price,
            cart_id=db_cart.id
        )
        db.add(db_cart_item)
    
    db.commit()
    return db_cart

@router.get("/{cart_id}", response_model=schemas.Cart)
def get_cart(cart_id: int, db: Session = Depends(get_db)):
    db_cart = db.query(models.Cart).filter(models.Cart.id == cart_id).first()
    if not db_cart:
        raise HTTPException(status_code=404, detail="Cart not found")
    return db_cart

@router.post("/{cart_id}/checkout")
def checkout(cart_id: int, db: Session = Depends(get_db)):
    db_cart = db.query(models.Cart).filter(models.Cart.id == cart_id).first()
    if not db_cart:
        raise HTTPException(status_code=404, detail="Cart not found")
    
    # Interact with product_service to remove or update product quantities
    for item in db_cart.items:
        # Pseudo-code to call product_service
        # product_service.remove_product(item.product_id, item.quantity)

        # Here you would send a request to the product_service API
        # to decrement or remove the products from the stock.

        pass  # Placeholder to prevent indentation error

    db.delete(db_cart)
    db.commit()
    return {"message": "Checkout successful"}

