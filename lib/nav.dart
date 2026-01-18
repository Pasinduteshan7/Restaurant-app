import 'package:go_router/go_router.dart';
import 'data/app_state.dart';
import 'presentation/auth/login_screen.dart';
import 'presentation/auth/register_screen.dart';
import 'presentation/home/home_screen.dart';
import 'presentation/menu/menu_screen.dart';
import 'presentation/cart/cart_screen.dart';
import 'presentation/profile/profile_screen.dart';
import 'presentation/main_scaffold.dart';
import 'presentation/food/food_details_screen.dart';
import 'presentation/checkout/checkout_screen.dart';
import 'presentation/order/order_tracking_screen.dart';
import 'presentation/reservation/reservation_screen.dart';

class AppRouter {
  static GoRouter createRouter(AppState appState) {
    return GoRouter(
      initialLocation: '/login',
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterScreen(),
        ),

        ShellRoute(
          builder: (context, state, child) {
            return MainScaffold(child: child);
          },
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const HomeScreen(),
            ),
            GoRoute(
              path: '/menu',
              builder: (context, state) => const MenuScreen(),
            ),
            GoRoute(
              path: '/cart',
              builder: (context, state) => const CartScreen(),
            ),
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),

        GoRoute(
          path: '/food/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return FoodDetailsScreen(foodId: id);
          },
        ),
        GoRoute(
          path: '/checkout',
          builder: (context, state) => const CheckoutScreen(),
        ),
        GoRoute(
          path: '/tracking/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return OrderTrackingScreen(orderId: id);
          },
        ),
        GoRoute(
          path: '/reservation',
          builder: (context, state) => const ReservationScreen(),
        ),
      ],
    );
  }
}
