import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme.dart';

class OrderTrackingScreen extends StatefulWidget {
  final String orderId;

  const OrderTrackingScreen({super.key, required this.orderId});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  int _currentStep = 1;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) setState(() => _currentStep = 2);
    });
    Future.delayed(const Duration(seconds: 8), () {
      if (mounted) setState(() => _currentStep = 3);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Tracking'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              color: Colors.grey[200],
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Opacity(
                    opacity: 0.1,
                    child: GridView.builder(
                      itemCount: 100,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10),
                      itemBuilder: (_, __) => Container(
                        margin: const EdgeInsets.all(1),
                        color: Colors.green,
                      ),
                    ),
                  ),
                  const Center(child: Text("Google Maps Placeholder", style: TextStyle(color: Colors.grey))),
                  
                  if (_currentStep >= 2)
                    Positioned(
                      bottom: 50,
                      child: const Icon(Icons.delivery_dining, size: 64, color: AppColors.primary)
                          .animate(onPlay: (c) => c.repeat())
                          .moveX(begin: -100, end: 100, duration: const Duration(seconds: 4))
                          .fadeIn(),
                    ),
                ],
              ),
            ),
          ),

          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Estimated Delivery', style: context.textStyles.labelMedium?.withColor(Colors.grey)),
                  const SizedBox(height: 4),
                  Text('25 - 30 Minutes', style: context.textStyles.headlineSmall?.bold),
                  const SizedBox(height: 24),
                  
                  _buildStep(1, 'Order Placed', 'We have received your order', Icons.receipt_long),
                  _buildLine(1),
                  _buildStep(2, 'Preparing', 'Kitchen is preparing your food', Icons.soup_kitchen),
                  _buildLine(2),
                  _buildStep(3, 'Out for Delivery', 'Rider is on the way', Icons.delivery_dining),
                  _buildLine(3),
                  _buildStep(4, 'Delivered', 'Enjoy your meal!', Icons.home),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(int step, String title, String subtitle, IconData icon) {
    final isActive = _currentStep >= step;
    final isCurrent = _currentStep == step;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : Colors.grey[200],
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: isActive ? Colors.white : Colors.grey, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title, 
                style: context.textStyles.titleMedium?.copyWith(
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  color: isActive ? Colors.black : Colors.grey,
                ),
              ),
              if (isCurrent)
                Text(subtitle, style: context.textStyles.bodySmall?.withColor(Colors.grey)),
            ],
          ),
        ),
        if (isActive)
          const Icon(Icons.check, color: AppColors.primary, size: 16),
      ],
    );
  }

  Widget _buildLine(int step) {
    if (step >= 4) return const SizedBox.shrink(); // No line after last step
    final isActive = _currentStep > step;
    return Container(
      margin: const EdgeInsets.only(left: 18),
      height: 24,
      width: 2,
      color: isActive ? AppColors.primary : Colors.grey[200],
    );
  }
}
