import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../data/app_state.dart';
import '../../theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final user = appState.currentUser;
    final orders = appState.orders;

    if (user == null) {
      return Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () => context.go('/login'),
            child: const Text('Login to view profile'),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Header
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.primaryContainer,
                    child: Text(
                      user.name[0],
                      style: context.textStyles.headlineMedium?.bold.withColor(AppColors.primary),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(user.name, style: context.textStyles.headlineSmall?.bold),
                  Text(user.email, style: context.textStyles.bodyMedium?.withColor(Colors.grey)),
                ],
              ),
            ),
            
            const SizedBox(height: 32),

            // Actions
            ListTile(
              leading: const Icon(Icons.table_restaurant, color: AppColors.primary),
              title: const Text('Book a Table'),
              subtitle: const Text('Reserve a spot for dining in'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/reservation'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey[200]!),
              ),
            ),
            
            const SizedBox(height: 24),
            Align(alignment: Alignment.centerLeft, child: Text('Order History', style: context.textStyles.titleLarge?.bold)),
            const SizedBox(height: 12),

            if (orders.isEmpty)
              Padding(
                padding: const EdgeInsets.all(32),
                child: Text('No recent orders', style: context.textStyles.bodyMedium?.withColor(Colors.grey)),
              )
            else
              ...orders.map((order) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Order #${order.id}', style: context.textStyles.titleMedium?.bold),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(order.status, style: context.textStyles.labelSmall?.bold.withColor(Colors.green[800]!)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(DateFormat('MMM d, h:mm a').format(order.createdAt), style: context.textStyles.bodySmall),
                        Text('LKR ${order.totalAmount.toStringAsFixed(0)}', style: context.textStyles.titleMedium?.bold),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => context.push('/tracking/${order.id}'),
                        child: const Text('Track Order'),
                      ),
                    ),
                  ],
                ),
              )).toList(),

            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  context.read<AppState>().logout();
                  context.go('/login');
                },
                child: const Text('Log Out', style: TextStyle(color: Colors.red)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
