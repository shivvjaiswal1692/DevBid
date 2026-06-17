import 'package:devbid/screens/startup_detail_screen.dart';
import 'package:devbid/services/listing_service.dart';
import 'package:devbid/services/theme_service.dart';
import 'package:devbid/theme/app_theme.dart';
import 'package:devbid/widgets/devbid_bottom_nav.dart';
import 'package:devbid/widgets/startup_project_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final listings = context.watch<ListingService>().listings;
    final themeService = context.watch<ThemeService>();
    return Scaffold(
      bottomNavigationBar: const DevBidBottomNav(currentIndex: 0),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset('assets/images/devbid_logo.png', fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('DevBid', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22)),
                      Text('Discover amazing projects', style: TextStyle(color: AppColors.textSecondary)),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => context.read<ThemeService>().toggleTheme(),
                  icon: Icon(
                    themeService.isDarkMode ? Icons.wb_sunny_outlined : Icons.dark_mode_outlined,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Stack(
                  children: [
                    IconButton(
                      onPressed: () => context.read<ThemeService>().toggleNotifications(),
                      icon: Icon(
                        themeService.notificationsEnabled ? Icons.notifications_none : Icons.notifications_off_outlined,
                      ),
                    ),
                    if (themeService.notificationsEnabled)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(width: 7, height: 7, decoration: const BoxDecoration(color: AppColors.cyan, shape: BoxShape.circle)),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search projects, AI tools, SaaS...',
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            const _ExploreDigitalAssetsSection(),
            const SizedBox(height: AppSpacing.xl),
            Row(
              children: [
                const Text('Your Projects', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
                const Spacer(),
                TextButton(onPressed: () {}, child: Text('${listings.length} total')),
              ],
            ),
            const SizedBox(height: 10),
            if (listings.isEmpty)
              const _EmptyProjectsState()
            else
              ...List.generate(
                listings.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: StartupProjectCard(
                    title: listings[index].title,
                    price: 'INR ${listings[index].price.toStringAsFixed(0)}',
                    subtitle: listings[index].description,
                    category: listings[index].category,
                    imageUrl: listings[index].imageUrl,
                    onTap: () => Navigator.pushNamed(context, StartupDetailScreen.routeName),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _EmptyProjectsState extends StatelessWidget {
  const _EmptyProjectsState();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceFor(context),
        borderRadius: AppRadius.lg,
        border: Border.all(color: AppColors.borderFor(context)),
      ),
      child: const Column(
        children: [
          Icon(Icons.inventory_2_outlined, size: 30, color: AppColors.textSecondary),
          SizedBox(height: 8),
          Text('No projects yet', style: TextStyle(fontWeight: FontWeight.w700)),
          SizedBox(height: 4),
          Text(
            'Go to Sell and publish your first project listing.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _ExploreDigitalAssetsSection extends StatelessWidget {
  const _ExploreDigitalAssetsSection();

  @override
  Widget build(BuildContext context) {
    const categories = [
      _CategoryMeta('SaaS', Icons.cloud_outlined, '312 listings'),
      _CategoryMeta('Mobile Apps', Icons.phone_android_outlined, '228 listings'),
      _CategoryMeta('AI Products', Icons.auto_awesome_outlined, '189 listings'),
      _CategoryMeta('Developer Tools', Icons.code_outlined, '141 listings'),
      _CategoryMeta('Web Platforms', Icons.language_outlined, '176 listings'),
      _CategoryMeta('E-Commerce', Icons.shopping_bag_outlined, '124 listings'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Explore Digital Assets', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        Text(
          'Premium categories for acquisitions and software investments.',
          style: TextStyle(color: AppColors.secondaryTextFor(context)),
        ),
        const SizedBox(height: AppSpacing.md),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 112,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (_, index) => _CategoryCard(item: categories[index]),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const [
            _MarketSignal(label: 'Trending This Week'),
            _MarketSignal(label: 'Recently Sold'),
            _MarketSignal(label: 'High Buyer Interest'),
          ],
        ),
      ],
    );
  }
}

class _CategoryMeta {
  const _CategoryMeta(this.title, this.icon, this.count);
  final String title;
  final IconData icon;
  final String count;
}

class _CategoryCard extends StatefulWidget {
  const _CategoryCard({required this.item});
  final _CategoryMeta item;

  @override
  State<_CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<_CategoryCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _hovering = true),
        onTapUp: (_) => setState(() => _hovering = false),
        onTapCancel: () => setState(() => _hovering = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? [
                      const Color(0xFF141416),
                      _hovering ? const Color(0xFF1D1E21) : const Color(0xFF17181A),
                    ]
                  : [
                      Colors.white,
                      _hovering ? const Color(0xFFF4F7FF) : const Color(0xFFF9FBFF),
                    ],
            ),
            borderRadius: AppRadius.lg,
            border: Border.all(
              color: _hovering ? AppColors.primary.withValues(alpha: 0.5) : AppColors.borderFor(context),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: _hovering ? 20 : 10,
                color: Colors.black.withValues(alpha: isDark ? 0.24 : 0.06),
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.mutedSurfaceFor(context),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  widget.item.icon,
                  color: AppColors.isDark(context) ? AppColors.textPrimary : AppColors.lightText,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.item.title, style: const TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(widget.item.count, style: TextStyle(color: AppColors.secondaryTextFor(context), fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MarketSignal extends StatelessWidget {
  const _MarketSignal({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceFor(context),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderFor(context)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.secondaryTextFor(context),
          fontSize: 12,
        ),
      ),
    );
  }
}
