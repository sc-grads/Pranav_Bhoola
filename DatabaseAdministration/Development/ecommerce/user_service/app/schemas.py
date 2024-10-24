# user_service/app/schemas.py
from pydantic import BaseModel
from enum import Enum

class Role(str, Enum):
    admin = "admin"
    customer = "customer"

class UserCreate(BaseModel):
    name: str
    email: str
    password: str
    role: Role = Role.customer  # Default to customer

class UserLogin(BaseModel):
    email: str
    password: str

class User(BaseModel):
    id: int
    name: str
    email: str
    role: Role  # Include role

    class Config:
        orm_mode = True
