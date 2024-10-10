from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
from fastapi.responses import HTMLResponse
from fastapi.templating import Jinja2Templates
from starlette.middleware.sessions import SessionMiddleware
from starlette.requests import Request

app = FastAPI()

# Configure session middleware
app.add_middleware(SessionMiddleware, secret_key="12345678910111213")

# Mount static files and configure template directory
app.mount("/static", StaticFiles(directory="app/static"), name="static")  # Ensure this path is correct
templates = Jinja2Templates(directory="app/templates")  # Ensure this path is correct

@app.get("/", response_class=HTMLResponse)
async def read_index(request: Request):
    return templates.TemplateResponse("index.html", {"request": request})

@app.get("/login", response_class=HTMLResponse)
async def read_login(request: Request):
    return templates.TemplateResponse("login.html", {"request": request})

@app.get("/register", response_class=HTMLResponse)
async def read_register(request: Request):
    return templates.TemplateResponse("register.html", {"request": request})

@app.get("/products", response_class=HTMLResponse)
async def read_products(request: Request):
    return templates.TemplateResponse("products.html", {"request": request})

@app.get("/cart", response_class=HTMLResponse)
async def read_cart(request: Request):
    return templates.TemplateResponse("cart.html", {"request": request})