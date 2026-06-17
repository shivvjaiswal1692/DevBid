import 'package:devbid/screens/startup_detail_screen.dart';
import 'package:devbid/services/listing_service.dart';
import 'package:devbid/theme/app_theme.dart';
import 'package:devbid/widgets/devbid_bottom_nav.dart';
import 'package:devbid/widgets/startup_project_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});
  static const routeName = '/explore';

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int _selected = 0;
  String _query = '';
  final _categories = ['All', 'SaaS', 'Mobile Apps', 'AI Products', 'Developer Tools', 'Web Platforms', 'E-Commerce'];
  bool _onlyWithImage = false;
  bool _onlyAffordable = false;
  String _sortBy = 'Newest';

  @override
  Widget build(BuildContext context) {
    final selectedCategory = _categories[_selected];
    final searched = context.watch<ListingService>().search(_query, category: selectedCategory);
    var results = List.of(searched);

    if (_onlyWithImage) {
      results = results.where((item) => item.imageUrl != null && item.imageUrl!.isNotEmpty).toList();
    }
    if (_onlyAffordable) {
      results = results.where((item) => item.price <= 50000).toList();
    }

    switch (_sortBy) {
      case 'Price: Low to High':
        results.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price: High to Low':
        results.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Title: A-Z':
        results.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
        break;
      case 'Newest':
      default:
        results.sort((a, b) => (b.createdAt ?? DateTime(0)).compareTo(a.createdAt ?? DateTime(0)));
    }

    return Scaffold(
      bottomNavigationBar: const DevBidBottomNav(currentIndex: 1),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: ListView(
          children: [
            Row(
              children: [
                const Text('Explore Projects', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
                const Spacer(),
                TextButton.icon(
                  onPressed: () => _openFiltersSheet(context),
                  icon: const Icon(Icons.tune, size: 16),
                  label: const Text('Filters'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextField(
              onChanged: (value) => setState(() => _query = value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search projects...',
              ),
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              children: List.generate(
                _categories.length,
                (i) => ChoiceChip(
                  label: Text(_categories[i]),
                  selected: _selected == i,
                  onSelected: (_) => setState(() => _selected = i),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Text('${results.length} projects found', style: const TextStyle(color: AppColors.textSecondary)),
                const Spacer(),
                TextButton.icon(
                  onPressed: () => _openSortSheet(context),
                  icon: const Icon(Icons.swap_vert, size: 16),
                  label: Text('Sort: $_sortBy'),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            if (results.isEmpty)
              const _ExploreEmptyState()
            else
              ...List.generate(
                results.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: StartupProjectCard(
                    title: results[index].title,
                    price: 'INR ${results[index].price.toStringAsFixed(0)}',
                    subtitle: results[index].description,
                    category: results[index].category,
                    imageUrl: results[index].imageUrl,
                    onTap: () => Navigator.pushNamed(context, StartupDetailScreen.routeName),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _openFiltersSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (_) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SwitchListTile(
                title: const Text('Only listings with image'),
                value: _onlyWithImage,
                onChanged: (value) {
                  setModalState(() => _onlyWithImage = value);
                  setState(() => _onlyWithImage = value);
                },
              ),
              SwitchListTile(
                title: const Text('Affordable (<= INR 50,000)'),
                value: _onlyAffordable,
                onChanged: (value) {
                  setModalState(() => _onlyAffordable = value);
                  setState(() => _onlyAffordable = value);
                },
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    setModalState(() {
                      _onlyWithImage = false;
                      _onlyAffordable = false;
                    });
                    setState(() {
                      _onlyWithImage = false;
                      _onlyAffordable = false;
                    });
                  },
                  child: const Text('Reset filters'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openSortSheet(BuildContext context) {
    final options = ['Newest', 'Price: Low to High', 'Price: High to Low', 'Title: A-Z'];
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: options
              .map(
                (option) => RadioListTile<String>(
                  title: Text(option),
                  value: option,
                  groupValue: _sortBy,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _sortBy = value);
                      Navigator.pop(context);
                    }
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _ExploreEmptyState extends StatelessWidget {
  const _ExploreEmptyState();

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
          Icon(Icons.search_off, color: AppColors.textSecondary),
          SizedBox(height: 8),
          Text('No matching projects found'),
        ],
      ),
    );
  }
}
