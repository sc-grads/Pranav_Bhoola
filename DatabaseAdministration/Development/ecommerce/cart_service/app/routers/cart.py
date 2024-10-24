# routers/cart.py
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
    total = 0.0

    try:
        db.add(db_cart)
        for item in cart.items:
            db_cart_item = models.CartItem(
                product_id=item.product_id,
                quantity=item.quantity,
                price=item.price,
                cart_id=db_cart.id
            )
            total += item.quantity * item.price
            db.add(db_cart_item)

        db_cart.total = total
        db.commit()
        db.refresh(db_cart)
        return db_cart
    except Exception as e:
        db.rollback()  # Roll back if there's any error
        raise HTTPException(status_code=400, detail=str(e))  # Provide error details


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
    
    # Example logic for handling product stock updates would go here
    for item in db_cart.items:
        # Call to product service to update stock goes here
        pass  # Placeholder

    db.delete(db_cart)
    db.commit()
    return {"message": "Checkout successful", "total": db_cart.total}

