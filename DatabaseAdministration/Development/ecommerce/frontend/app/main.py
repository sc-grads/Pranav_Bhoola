from fastapi import FastAPI, Form, HTTPException, Depends
from fastapi.staticfiles import StaticFiles
from fastapi.responses import HTMLResponse, RedirectResponse
from fastapi.templating import Jinja2Templates
from starlette.middleware.sessions import SessionMiddleware
from starlette.requests import Request
import httpx

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

@app.post("/login")
async def login(request: Request):
    form = await request.form()
    email = form.get("email")
    password = form.get("password")

    # Request login from user_service
    async with httpx.AsyncClient() as client:
        response = await client.post("http://user_service:8000/api/users/login", json={"email": email, "password": password})

    if response.status_code == 200:
        data = response.json()
        access_token = data["access_token"]
        role = data["role"]
        
        # Store access token and role in the session
        request.session["access_token"] = access_token
        request.session["role"] = role

        # Redirect based on role
        if role == "admin":
            return RedirectResponse(url="/products", status_code=303)
        else:
            return RedirectResponse(url="/customer", status_code=303)
    else:
        return templates.TemplateResponse("login.html", {"request": request, "error": "Invalid credentials"})

@app.get("/register", response_class=HTMLResponse)
async def read_register(request: Request):
    return templates.TemplateResponse("register.html", {"request": request})

@app.post("/add-to-cart")
async def add_to_cart(request: Request, product_id: int = Form(...), quantity: int = Form(...)):
    access_token = request.headers.get("Authorization")
    if not access_token:
        return RedirectResponse(url="/login", status_code=303)

    async with httpx.AsyncClient() as client:
        response = await client.post(
            "http://cart_service:8003/add-to-cart",
            headers={"Authorization": access_token},
            json={"product_id": product_id, "quantity": quantity, "price": 100}  # Adjust price as needed
        )
    if response.status_code == 200:
        return RedirectResponse(url="/cart", status_code=303)
    else:
        raise HTTPException(status_code=response.status_code, detail="Failed to add item to cart")

@app.get("/api/cart", response_class=HTMLResponse)
async def get_cart(request: Request):
    access_token = request.headers.get("Authorization")
    if not access_token:
        return RedirectResponse(url="/login", status_code=303)

    async with httpx.AsyncClient() as client:
        response = await client.get(
            "http://cart_service:8003/api/cart/cart",
            headers={"Authorization": access_token}
        )
    
    if response.status_code == 200:
        return response.json()  # Return the cart items to the frontend
    else:
        raise HTTPException(status_code=response.status_code, detail="Failed to fetch cart")
    
@app.get("/cart.html", response_class=HTMLResponse)
async def read_cart_page(request: Request):
    return templates.TemplateResponse("cart.html", {"request": request})

@app.delete("/cart-item/{item_id}")
async def delete_cart_item(request: Request, item_id: int):
    access_token = request.headers.get("Authorization")
    if not access_token:
        return RedirectResponse(url="/login", status_code=303)

    async with httpx.AsyncClient() as client:
        response = await client.delete(
            f"http://cart_service:8003/cart-item/{item_id}",
            headers={"Authorization": access_token}
        )
    
    if response.status_code == 200:
        return RedirectResponse(url="/cart", status_code=303)
    else:
        raise HTTPException(status_code=response.status_code, detail="Failed to delete cart item")

@app.get("/update_profile", response_class=HTMLResponse)
async def update_profile(request: Request):
    return templates.TemplateResponse("update_profile.html", {"request": request})


@app.get("/products", response_class=HTMLResponse)
async def read_products(request: Request):
    return templates.TemplateResponse("products.html", {"request": request})

@app.get("/customer", response_class=HTMLResponse)
async def read_customer_page(request: Request):
    return templates.TemplateResponse("customer.html", {"request": request})

@app.get("/product/{product_id}", response_class=HTMLResponse)
async def read_product_detail(request: Request, product_id: int):
    return templates.TemplateResponse("products.html", {"request": request, "product_id": product_id})

# Logout route
@app.get("/logout")
async def logout(request: Request):
    request.session.clear()  # Clear the session data
    return RedirectResponse(url="/login")
