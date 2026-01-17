import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../data/app_state.dart';
import '../../data/models.dart';
import '../../theme.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _selectedPaymentMethod = 'Stripe';
  bool _isPlacingOrder = false;
  Address? _selectedAddress;

  @override
  void initState() {
    super.initState();
    // Default to first address
    final user = context.read<AppState>().currentUser;
    if (user != null && user.savedAddresses.isNotEmpty) {
      _selectedAddress = user.savedAddresses.first;
    }
  }

  Future<void> _handlePlaceOrder() async {
    if (_selectedAddress == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a delivery address')),
      );
      return;
    }

    setState(() => _isPlacingOrder = true);
    try {
      final order = await context.read<AppState>().placeOrder(_selectedAddress!.fullAddress);
      if (mounted) {
        context.go('/tracking/${order.id}');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to place order: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isPlacingOrder = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final user = appState.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Delivery Address
            Text('Delivery Address', style: context.textStyles.titleMedium?.bold),
            const SizedBox(height: 12),
            if (user != null)
              ...user.savedAddresses.map((addr) => _buildAddressCard(addr)).toList()
            else
              const Text("Please add an address in profile"),
            
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Add New Address'),
            ),

            const SizedBox(height: 32),

            // Payment Method
            Text('Payment Method', style: context.textStyles.titleMedium?.bold),
            const SizedBox(height: 12),
            _buildPaymentMethodTile('Stripe', FontAwesomeIcons.ccStripe),
            _buildPaymentMethodTile('Razorpay', FontAwesomeIcons.moneyBill),
            _buildPaymentMethodTile('UPI', FontAwesomeIcons.mobile),
            _buildPaymentMethodTile('Cash on Delivery', FontAwesomeIcons.handHoldingDollar),

            const SizedBox(height: 32),

            // Summary
            Text('Order Summary', style: context.textStyles.titleMedium?.bold),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Subtotal'),
                      Text('LKR ${appState.subtotal.toStringAsFixed(0)}'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Delivery Fee'),
                      Text('LKR ${appState.deliveryFee.toStringAsFixed(0)}'),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Divider()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total', style: context.textStyles.titleMedium?.bold),
                      Text('LKR ${appState.total.toStringAsFixed(0)}', style: context.textStyles.titleMedium?.bold.withColor(AppColors.primary)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: _isPlacingOrder ? null : _handlePlaceOrder,
            child: _isPlacingOrder 
              ? const CircularProgressIndicator(color: Colors.white)
              : Text('Place Order - LKR ${appState.total.toStringAsFixed(0)}'),
          ),
        ),
      ),
    );
  }

  Widget _buildAddressCard(Address address) {
    final isSelected = _selectedAddress?.id == address.id;
    return GestureDetector(
      onTap: () => setState(() => _selectedAddress = address),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryContainer.withOpacity(0.3) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              address.label == 'Home' ? Icons.home : Icons.work,
              color: isSelected ? AppColors.primary : Colors.grey,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(address.label, style: context.textStyles.titleSmall?.bold),
                  Text(address.fullAddress, style: context.textStyles.bodySmall),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppColors.primary),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodTile(String name, IconData icon) {
    final isSelected = _selectedPaymentMethod == name;
    return GestureDetector(
      onTap: () => setState(() => _selectedPaymentMethod = name),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey[300]!,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? AppColors.primary : Colors.grey[600], size: 20),
            const SizedBox(width: 16),
            Text(name, style: context.textStyles.bodyMedium?.medium),
            const Spacer(),
            if (isSelected)
              const Icon(Icons.radio_button_checked, color: AppColors.primary, size: 20)
            else
              const Icon(Icons.radio_button_unchecked, color: Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }
}
