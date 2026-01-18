# CurryFlow Backend API Documentation

## Overview
Node.js + Express REST API backend for CurryFlow Restaurant App with MongoDB database integration.

## Prerequisites
- Node.js 16+
- npm or yarn
- MongoDB Atlas account (already configured)

## Setup Instructions

### 1. Navigate to Backend Directory
```bash
cd backend
```

### 2. Install Dependencies
```bash
npm install
```

This will install:
- `express` - Web framework
- `mongoose` - MongoDB ODM
- `bcryptjs` - Password hashing
- `jsonwebtoken` - JWT authentication
- `cors` - Cross-origin requests
- `dotenv` - Environment variables

### 3. Database Seeding
Seed initial food items into MongoDB:

```bash
npm install -g nodemon  # Install nodemon globally
node seed.js
```

Expected output:
```
✅ Connected to MongoDB
🗑️  Cleared existing foods
✅ Seeded 15 food items
📂 Categories: Rice & Curry, Kottu, Hoppers, Short Eats, Seafood, Rice Specialties
✨ Database seeding complete!
```

### 4. Start Server

#### Development Mode (with auto-reload)
```bash
npm run dev
```

#### Production Mode
```bash
npm start
```

Expected output:
```
🚀 Server running on http://localhost:5000
📦 Environment: development
```

## API Endpoints

### Authentication

#### Register User
```http
POST /api/auth/register
Content-Type: application/json

{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "password123",
  "phone": "+94771234567"
}
```

**Response:**
```json
{
  "message": "User registered successfully",
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": "user_id",
    "name": "John Doe",
    "email": "john@example.com",
    "phone": "+94771234567"
  }
}
```

#### Login User
```http
POST /api/auth/login
Content-Type: application/json

{
  "email": "john@example.com",
  "password": "password123"
}
```

**Response:**
```json
{
  "message": "Login successful",
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": "user_id",
    "name": "John Doe",
    "email": "john@example.com",
    "phone": "+94771234567",
    "savedAddresses": []
  }
}
```

#### Get User Profile
```http
GET /api/auth/profile
Authorization: Bearer {token}
```

#### Add Delivery Address
```http
POST /api/auth/address
Authorization: Bearer {token}
Content-Type: application/json

{
  "name": "Home",
  "street": "123 Main Street",
  "city": "Colombo",
  "postalCode": "00100",
  "isDefault": true
}
```

---

### Food Items

#### Get All Foods
```http
GET /api/foods
GET /api/foods?category=Kottu
```

**Response:**
```json
{
  "foods": [
    {
      "_id": "food_id",
      "name": "Kottu Chicken",
      "price": 380,
      "description": "Shredded roti with spicy chicken and vegetables",
      "category": "Kottu",
      "rating": 4.8,
      "dietaryTags": ["Non-Vegetarian"],
      "ingredients": ["Roti", "Chicken", "Vegetables", "Spices"],
      "available": true
    }
  ],
  "count": 3
}
```

#### Get Food by ID
```http
GET /api/foods/{foodId}
```

#### Get Categories
```http
GET /api/foods/categories
```

**Response:**
```json
{
  "categories": ["Rice & Curry", "Kottu", "Hoppers", "Short Eats", "Seafood", "Rice Specialties"]
}
```

#### Search Foods
```http
GET /api/foods/search?q=chicken
```

---

### Cart Management

#### Get Cart
```http
GET /api/cart
Authorization: Bearer {token}
```

**Response:**
```json
{
  "cart": {
    "id": "cart_id",
    "items": [
      {
        "_id": "item_id",
        "foodId": "food_id",
        "foodName": "Kottu Chicken",
        "foodPrice": 380,
        "quantity": 2,
        "selectedOptions": {
          "spiceLevel": "hot",
          "specialInstructions": ""
        },
        "totalPrice": 760
      }
    ],
    "subtotal": 760,
    "deliveryFee": 200,
    "discount": 0,
    "promoCode": null,
    "total": 960
  }
}
```

#### Add to Cart
```http
POST /api/cart/add
Authorization: Bearer {token}
Content-Type: application/json

{
  "foodId": "food_id",
  "quantity": 1,
  "selectedOptions": {
    "spiceLevel": "medium",
    "specialInstructions": "No onions"
  }
}
```

#### Update Cart Item
```http
PUT /api/cart/{itemId}
Authorization: Bearer {token}
Content-Type: application/json

{
  "quantity": 3
}
```

#### Remove from Cart
```http
DELETE /api/cart/{itemId}
Authorization: Bearer {token}
```

#### Clear Cart
```http
DELETE /api/cart
Authorization: Bearer {token}
```

#### Apply Promo Code
```http
POST /api/cart/promo
Authorization: Bearer {token}
Content-Type: application/json

{
  "promoCode": "SAVE10"
}
```

**Valid Promo Codes:**
- `SAVE10` - 10% discount
- `SAVE20` - 20% discount
- `FREE` - Free delivery

---

### Orders

#### Place Order
```http
POST /api/orders/place
Authorization: Bearer {token}
Content-Type: application/json

{
  "deliveryAddress": {
    "street": "123 Main Street",
    "city": "Colombo",
    "postalCode": "00100"
  },
  "paymentMethod": "cod",
  "notes": "Please ring bell twice"
}
```

**Payment Methods:**
- `stripe`
- `razorpay`
- `upi`
- `cod` (Cash on Delivery)

**Response:**
```json
{
  "message": "Order placed successfully",
  "order": {
    "id": "order_id",
    "orderId": "ORDER-1234567890",
    "status": "pending",
    "total": 960,
    "estimatedDeliveryTime": "2024-01-17T14:45:00.000Z"
  }
}
```

#### Get Order History
```http
GET /api/orders/history
Authorization: Bearer {token}
```

#### Get Single Order
```http
GET /api/orders/{orderId}
Authorization: Bearer {token}
```

#### Update Order Status (Admin)
```http
PUT /api/orders/{orderId}/status
Content-Type: application/json

{
  "status": "confirmed"
}
```

**Valid Statuses:**
- `pending`
- `confirmed`
- `preparing`
- `out-for-delivery`
- `delivered`
- `cancelled`

---

### Health Check

#### API Status
```http
GET /api/health
```

**Response:**
```json
{
  "status": "OK",
  "message": "CurryFlow Backend is running",
  "timestamp": "2024-01-17T10:30:45.123Z"
}
```

---

## Environment Variables

Located in `.env`:

```env
MONGO_URI=mongodb+srv://5365:l4L9v6shTdxCAkOf@cluster0.wdwlq1l.mongodb.net/lustradb?retryWrites=true&w=majority&appName=Cluster0
PORT=5000
JWT_SECRET=your_jwt_secret_key_change_this_in_production
NODE_ENV=development
```

⚠️ **Important:** In production, change `JWT_SECRET` to a strong random string!

---

## MongoDB Collections

### Users
```javascript
{
  name: String,
  email: String (unique),
  password: String (hashed),
  phone: String,
  savedAddresses: Array,
  createdAt: Date,
  updatedAt: Date
}
```

### Foods
```javascript
{
  name: String,
  price: Number,
  description: String,
  imageUrl: String,
  category: String,
  rating: Number,
  dietaryTags: Array,
  ingredients: Array,
  available: Boolean,
  createdAt: Date
}
```

### Carts
```javascript
{
  userId: ObjectId (ref: User),
  items: Array,
  subtotal: Number,
  deliveryFee: Number,
  discount: Number,
  promoCode: String,
  total: Number,
  createdAt: Date,
  updatedAt: Date
}
```

### Orders
```javascript
{
  userId: ObjectId (ref: User),
  orderId: String (unique),
  items: Array,
  deliveryAddress: Object,
  status: String,
  paymentMethod: String,
  paymentStatus: String,
  subtotal: Number,
  deliveryFee: Number,
  discount: Number,
  total: Number,
  estimatedDeliveryTime: Date,
  notes: String,
  createdAt: Date,
  updatedAt: Date
}
```

---

## Testing with Postman

### Import Collection
1. Create a new Postman collection
2. Add requests for each endpoint above
3. Use the `token` from login response in `Authorization` header for protected routes

### Format:
```
Authorization: Bearer {token}
```

---

## Troubleshooting

### MongoDB Connection Failed
```
Error: connect ECONNREFUSED
```
- Verify MongoDB URI in `.env`
- Check internet connection
- Ensure MongoDB Atlas cluster is active
- Whitelist your IP in MongoDB Atlas Network Access

### Port Already in Use
```bash
# Use a different port
PORT=3000 npm run dev

# Or kill process using port 5000
# Windows: netstat -ano | findstr :5000
```

### JWT Token Expired
- Tokens expire after 30 days
- User must login again to get new token

---

## Development Tips

1. **Auto-reload during development:**
   ```bash
   npm run dev
   ```
   Uses nodemon to restart on file changes

2. **Check MongoDB data:**
   - Go to MongoDB Atlas dashboard
   - Select "Collections" in your cluster
   - View data in real-time

3. **Debug API requests:**
   - Check network tab in browser DevTools
   - Use Postman for testing
   - Check server console for errors

---

## Production Deployment

Before deploying:

1. ✅ Change `JWT_SECRET` to strong random string
2. ✅ Set `NODE_ENV=production`
3. ✅ Use `npm start` instead of `npm run dev`
4. ✅ Configure environment variables on hosting platform
5. ✅ Enable HTTPS for API endpoint
6. ✅ Set up proper error logging
7. ✅ Configure CORS properly for frontend domain

---

**Backend API is ready for integration with Flutter frontend!** 🚀
