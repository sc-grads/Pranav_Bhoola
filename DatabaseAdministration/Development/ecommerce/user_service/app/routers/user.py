# user_service/app/routers/user.py
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from fastapi.security import OAuth2PasswordBearer
from app.database import SessionLocal
from .. import models, schemas, utils  # Import the utils for token handling
import bcrypt

router = APIRouter()
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="api/users/login")

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.post("/register", response_model=schemas.User)
def create_user(user: schemas.UserCreate, db: Session = Depends(get_db)):
    existing_user = db.query(models.User).filter(models.User.email == user.email).first()
    if existing_user:
        raise HTTPException(status_code=400, detail="Email already registered")

    hashed_password = bcrypt.hashpw(user.password.encode('utf-8'), bcrypt.gensalt())
    db_user = models.User(
        name=user.name,
        email=user.email,
        hashed_password=hashed_password.decode('utf-8'),
        role=user.role  # Assign role from input
    )
    db.add(db_user)
    db.commit()
    db.refresh(db_user)

    return db_user

@router.post("/login")
def login(form_data: schemas.UserLogin, db: Session = Depends(get_db)):
    db_user = db.query(models.User).filter(models.User.email == form_data.email).first()
    if not db_user or not bcrypt.checkpw(form_data.password.encode('utf-8'), db_user.hashed_password.encode('utf-8')):
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid credentials")
    
    access_token = utils.create_access_token(data={"sub": db_user.email, "role": db_user.role})  # Include role in token
    return {"access_token": access_token, "token_type": "bearer", "role": db_user.role}  # Return role with response


@router.get("/users/me", response_model=schemas.User)  # New endpoint for current user
def read_users_me(token: str = Depends(oauth2_scheme), db: Session = Depends(get_db)):
    user = utils.verify_token(token, db)
    return user
