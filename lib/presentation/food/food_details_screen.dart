import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../data/app_state.dart';
import '../../data/models.dart';
import '../../theme.dart';

class FoodDetailsScreen extends StatefulWidget {
  final String foodId;

  const FoodDetailsScreen({super.key, required this.foodId});

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  int _quantity = 1;
  String _selectedSpiceLevel = 'Normal';
  final List<String> _spiceLevels = ['Mild', 'Normal', 'Spicy', 'Extra Spicy'];
  
  bool _isAdding = false;

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    
    // Find food item
    FoodItem? food;
    try {
      food = appState.foods.firstWhere((f) => f.id == widget.foodId);
    } catch (e) {
      if (appState.foods.isEmpty) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }
      return const Scaffold(body: Center(child: Text("Item not found")));
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar Image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => context.pop(),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: const Icon(Icons.favorite_border, color: Colors.red),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'food_image_${food.id}',
                child: CachedNetworkImage(
                  imageUrl: food.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: context.colors.surface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
              ),
              transform: Matrix4.translationValues(0, -20, 0),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          food.name,
                          style: context.textStyles.headlineMedium?.bold,
                        ),
                      ),
                      Text(
                        'LKR ${food.price.toStringAsFixed(0)}',
                        style: context.textStyles.headlineSmall?.bold.withColor(AppColors.primary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // Rating & Time
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text('${food.rating} (120 reviews)', style: context.textStyles.bodyMedium?.bold),
                      const SizedBox(width: 16),
                      const Icon(Icons.access_time, color: Colors.grey, size: 20),
                      const SizedBox(width: 4),
                      Text('20 mins', style: context.textStyles.bodyMedium),
                      const SizedBox(width: 16),
                      const Icon(Icons.local_fire_department, color: Colors.orange, size: 20),
                      const SizedBox(width: 4),
                      Text('365 kcal', style: context.textStyles.bodyMedium),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Description
                  Text('Description', style: context.textStyles.titleLarge?.bold),
                  const SizedBox(height: 8),
                  Text(
                    food.description,
                    style: context.textStyles.bodyLarge?.withColor(Colors.grey[700]!).copyWith(height: 1.5),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Ingredients
                  if (food.ingredients.isNotEmpty) ...[
                    Text('Ingredients', style: context.textStyles.titleLarge?.bold),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: food.ingredients.map((ing) => Chip(
                        label: Text(ing),
                        backgroundColor: AppColors.secondaryContainer,
                        labelStyle: TextStyle(color: AppColors.onSecondaryContainer),
                        side: BorderSide.none,
                      )).toList(),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Spice Level Customization
                  Text('Spice Level', style: context.textStyles.titleLarge?.bold),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 50,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _spiceLevels.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final level = _spiceLevels[index];
                        final isSelected = _selectedSpiceLevel == level;
                        return ChoiceChip(
                          label: Text(level),
                          selected: isSelected,
                          onSelected: (val) => setState(() => _selectedSpiceLevel = level),
                          selectedColor: AppColors.primary,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 100), // Spacing for bottom button
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              // Quantity
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () => setState(() => _quantity = _quantity > 1 ? _quantity - 1 : 1),
                    ),
                    Text(
                      '$_quantity',
                      style: context.textStyles.titleMedium?.bold,
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () => setState(() => _quantity++),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Add to Cart
              Expanded(
                child: ElevatedButton(
                  onPressed: _isAdding ? null : () {
                    setState(() => _isAdding = true);
                    
                    context.read<AppState>().addToCart(
                      food!,
                      quantity: _quantity,
                      options: [_selectedSpiceLevel],
                    );

                    Future.delayed(const Duration(milliseconds: 500), () {
                      if (mounted) {
                        setState(() => _isAdding = false);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${food!.name} added to cart'),
                            backgroundColor: AppColors.secondary,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        context.pop();
                      }
                    });
                  },
                  child: _isAdding 
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text('Add to Cart'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
