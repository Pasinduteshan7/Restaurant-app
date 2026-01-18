import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../data/app_state.dart';
import '../../theme.dart';
import '../widgets/food_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final featured = appState.foods.where((f) => f.isPopular).toList();
    final categories = ['All', 'Rice & Curry', 'Kottu', 'Hoppers', 'Short Eats', 'Seafood'];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ayubowan, ${appState.currentUser?.name.split(' ').first ?? 'Guest'} 👋',
                  style: context.textStyles.titleMedium?.withColor(Colors.grey[600]!),
                ),
                Text(
                  'Hungry?',
                  style: context.textStyles.headlineSmall?.bold.withColor(AppColors.primary),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_none),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () => context.go('/menu'),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.outline.withOpacity(0.5)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.grey),
                      const SizedBox(width: 12),
                      Text('Search for kotthu, hoppers...', style: context.textStyles.bodyMedium?.withColor(Colors.grey)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          SliverToBoxAdapter(
            child: SizedBox(
              height: 160,
              child: PageView(
                padEnds: false,
                controller: PageController(viewportFraction: 0.9),
                children: [
                  _buildPromoBanner(context, 'Free Delivery', 'On your first order!', Colors.orange),
                  _buildPromoBanner(context, '20% OFF', 'Spicy Weekend Special', Colors.red),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  return Chip(
                    label: Text(categories[index]),
                    backgroundColor: index == 0 ? AppColors.primary : Colors.white,
                    labelStyle: TextStyle(
                      color: index == 0 ? Colors.white : Colors.black,
                    ),
                    side: BorderSide(color: index == 0 ? Colors.transparent : Colors.grey[300]!),
                  );
                },
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Featured', style: context.textStyles.headlineSmall?.bold),
                  TextButton(onPressed: () => context.go('/menu'), child: const Text('See All')),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 230,
              child: appState.isLoadingFoods
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: featured.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        return FoodCard(food: featured[index], isHorizontal: true);
                      },
                    ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Text('Popular Near You', style: context.textStyles.headlineSmall?.bold),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: appState.isLoadingFoods
                ? const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()))
                : SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.75,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return FoodCard(food: appState.foods[index]);
                      },
                      childCount: appState.foods.length,
                    ),
                  ),
          ),
          
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }

  Widget _buildPromoBanner(BuildContext context, String title, String subtitle, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [color, color.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Icon(Icons.fastfood, size: 120, color: Colors.white.withOpacity(0.2)),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('PROMO', style: context.textStyles.labelSmall?.bold.withColor(color)),
                ),
                const SizedBox(height: 8),
                Text(title, style: context.textStyles.headlineMedium?.bold.withColor(Colors.white)),
                Text(subtitle, style: context.textStyles.titleMedium?.withColor(Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
