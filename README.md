# CurryFlow - Restaurant App

A modern, full-featured Sri Lankan Restaurant mobile application built with Flutter, featuring a complete food ordering system with cart, checkout, payment options, and order tracking.

## Project Overview

**CurryFlow** is a complete Flutter mobile application for ordering authentic Sri Lankan cuisine. The app includes:

- 🔐 Authentication (Login/Register)
- 🍛 Browse Sri Lankan food menu with multiple categories
- 🛒 Shopping cart with quantity management
- 💳 Checkout with multiple payment options
- 📍 Delivery address selection
- 📦 Real-time order tracking
- 👤 User profile and order history
- 🎫 Table reservation (mock UI)
- 🎨 Modern, warm UI with material design 3

## Features

### 1. Authentication
- Login screen with pre-filled demo credentials
- Registration screen
- JWT-based authentication (mock)
- Demo user: `user@example.com` / `password`

### 2. Home Screen
- Personalized greeting
- Search bar
- Promotional banners
- Category chips
- Featured food items carousel
- Popular items grid

### 3. Menu Browsing
- Browse all food items
- Filter by categories:
  - Rice & Curry
  - Kottu
  - Hoppers
  - Short Eats
  - Seafood
  - Rice Specialties
- Search functionality
- Grid/List view

### 4. Food Details
- Large food image with hero animation
- Description and ingredients
- Spice level customization
- Quantity selection
- Add to cart functionality

### 5. Cart Management
- View all items in cart
- Adjust quantities
- Swipe to delete items
- Promo code input
- Dynamic total calculation with delivery fee

### 6. Checkout
- Select delivery address
- Add new address
- Choose payment method:
  - Stripe
  - Razorpay
  - UPI
  - Cash on Delivery
- Order summary
- Place order functionality

### 7. Order Tracking
- Real-time status updates:
  - Order Placed
  - Preparing
  - Out for Delivery
  - Delivered
- Animated delivery icon
- Estimated delivery time
- Progress indicators

### 8. Profile
- User information display
- Order history with dates and amounts
- Track past orders
- Book table (reservation)
- Logout functionality

### 9. Table Reservation (Mock UI)
- Date picker
- Time picker
- Guest count selector
- Confirmation animation
- No backend persistence

## Sri Lankan Food Categories

The app includes authentic Sri Lankan dishes across 9+ categories with 15+ pre-loaded items:

- **Rice & Curry**: Chicken, Fish Ambul Thiyal
- **Kottu**: Chicken, Cheese, Vegetable variants
- **Hoppers**: String Hoppers, Egg Hopper
- **Short Eats**: Fish Rolls, Samosa, Chicken Roll
- **Seafood**: Devilled Prawns, Garlic Butter Crab
- **Rice Specialties**: Fried Rice variants, Biriyani, etc.

## Technology Stack

### Frontend
- **Framework**: Flutter 3.6.0+
- **State Management**: Provider
- **Routing**: GoRouter
- **UI Framework**: Material Design 3
- **Fonts**: Google Fonts (Poppins, Inter)

### Backend (Mock)
- **Service**: MockApiService (in-app simulation)
- **Data**: Local data models
- **Delay Simulation**: Network latency simulation

### Database
- **Storage**: In-memory (for demo)
- **Real Backend**: MongoDB ready (API design included)

## Project Structure

```
lib/
├── main.dart                      # App entry point
├── nav.dart                       # GoRouter configuration
├── theme.dart                     # Color scheme and typography
├── data/
│   ├── models.dart               # Data models (User, Food, Order, etc.)
│   ├── mock_service.dart         # Mock API service
│   └── app_state.dart            # Provider state management
└── presentation/
    ├── auth/
    │   ├── login_screen.dart
    │   └── register_screen.dart
    ├── home/
    │   └── home_screen.dart
    ├── menu/
    │   └── menu_screen.dart
    ├── food/
    │   └── food_details_screen.dart
    ├── cart/
    │   └── cart_screen.dart
    ├── checkout/
    │   └── checkout_screen.dart
    ├── order/
    │   └── order_tracking_screen.dart
    ├── profile/
    │   └── profile_screen.dart
    ├── reservation/
    │   └── reservation_screen.dart
    ├── widgets/
    │   └── food_card.dart
    └── main_scaffold.dart         # Bottom navigation shell
```

## Dependencies

- `flutter`: Latest stable
- `provider: ^6.1.2` - State management
- `go_router: ^16.2.0` - Navigation and routing
- `google_fonts: ^6.1.0` - Beautiful typography
- `cached_network_image: ^3.0.0` - Image caching
- `flutter_animate: ^4.0.0` - Smooth animations
- `font_awesome_flutter: ^10.0.0` - Icon set
- `intl: ^0.20.2` - Date/time formatting

## Setup Instructions

### Prerequisites
- Flutter SDK 3.6.0 or higher
- Dart 3.0+
- Android Studio / Xcode (for emulator)
- Git

### Installation

1. **Clone/Extract the project**
   ```bash
   cd "d:\PROJECTS\group\mobile application development\resturent app"
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate necessary files** (if using code generation)
   ```bash
   flutter pub run build_runner build
   ```

4. **Run the app**
   ```bash
   # For Android
   flutter run
   
   # For iOS
   flutter run -d iphone
   
   # For web
   flutter run -d chrome
   ```

### Demo Login Credentials
- **Email**: `user@example.com`
- **Password**: `password`

The app allows any email/password combination for demo purposes.

## App Flow

1. **Login/Register** → Authenticate user
2. **Home** → Browse featured items and categories
3. **Menu** → Search and filter all items
4. **Food Details** → Customize item (spice level, quantity)
5. **Cart** → Review items and apply promo codes
6. **Checkout** → Select address and payment method
7. **Order Tracking** → Real-time status updates
8. **Profile** → View history and manage account

## Color Scheme

- **Primary (Orange)**: `#FF5722` - Warm, appetizing
- **Secondary (Green)**: `#4CAF50` - Fresh, vegetables
- **Tertiary (Gold)**: `#FFC107` - Turmeric, fried items
- **Background**: `#FFFBF7` - Warm creamy white
- **Surface**: `#FFFFFF` - Clean white

## Key Features Implementation

### State Management
Uses Provider pattern for:
- User authentication state
- Food items catalog
- Shopping cart management
- Order history

### Navigation
GoRouter provides:
- Deep linking support
- Named routes
- Route guards (auth check)
- Shell routing (bottom nav)

### Mock API Service
- Simulates network delays (500-1500ms)
- Returns mock food items (15+ items)
- Creates orders with realistic data
- Handles user session

## Future Enhancements

- [ ] Real backend integration (Node.js + MongoDB)
- [ ] Payment gateway integration (Stripe/Razorpay)
- [ ] Push notifications
- [ ] Real maps integration (Google Maps)
- [ ] Favorite items functionality
- [ ] Rating and reviews
- [ ] Multiple language support
- [ ] Dark mode
- [ ] Order cancellation
- [ ] Live chat support
- [ ] Loyalty points system

## API Endpoints (Ready for Backend Integration)

```
Auth
POST /api/auth/login
POST /api/auth/register

Food
GET /api/foods
GET /api/foods/:id
GET /api/foods?category=Rice%20&%20Curry

Cart
POST /api/cart/add
PUT /api/cart/update/:itemId
DELETE /api/cart/:itemId

Orders
POST /api/orders/place
GET /api/orders/history
GET /api/orders/:orderId

Payment
POST /api/payments/process

Delivery
POST /api/delivery/addresses
GET /api/delivery/addresses

Notifications
GET /api/notifications
```

## Customization

### Theme Colors
Edit `lib/theme.dart`:
```dart
static const primary = Color(0xFFFF5722); // Change primary color
static const secondary = Color(0xFF4CAF50); // Change secondary color
```

### Food Items
Edit `lib/data/mock_service.dart`:
```dart
static final List<FoodItem> _allFoods = [
  // Add or modify items here
];
```

### Restaurant Details
Update strings in respective screens

## Troubleshooting

### Dependencies not installing
```bash
flutter clean
flutter pub get
```

### Hot reload not working
```bash
flutter run
```

### Image loading issues
- Check internet connection (uses placeholder images)
- Images load from `https://via.placeholder.com`

## Testing

The app includes:
- Mock data with 15+ food items
- Pre-loaded user with saved addresses
- Sample orders in history
- Animation demonstrations

No unit tests/widget tests included (add as needed).

## Performance

- Lazy loading for food items
- Cached network images
- Efficient state management with Provider
- Smooth animations with flutter_animate

## Accessibility

- Proper contrast ratios
- Readable font sizes (>12pt)
- Touch targets >48dp
- Semantic labels on buttons

## License

This project is for educational and demonstration purposes.

## Credits

- Built with Flutter
- Material Design 3 principles
- Inspired by modern food delivery apps
- Sri Lankan cuisine focus

---

**Happy Ordering with CurryFlow!** 🍛
#   R e s t a u r a n t - a p p 
 
 