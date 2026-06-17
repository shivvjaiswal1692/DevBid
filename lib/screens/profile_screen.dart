import 'package:devbid/services/listing_service.dart';
import 'package:devbid/services/theme_service.dart';
import 'package:devbid/screens/auth/login_screen.dart';
import 'package:devbid/theme/app_theme.dart';
import 'package:devbid/widgets/devbid_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedTab = 0;
  String _name = 'Jordan Smith';
  String _email = 'jordan@example.com';

  @override
  Widget build(BuildContext context) {
    final listings = context.watch<ListingService>().listings;
    final themeService = context.watch<ThemeService>();
    return Scaffold(
      bottomNavigationBar: const DevBidBottomNav(currentIndex: 4),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Row(
            children: [
              const Text('Profile', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28)),
              const Spacer(),
              IconButton(
                onPressed: () => _openSettingsSheet(context, themeService),
                icon: const Icon(Icons.settings_outlined),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              CircleAvatar(radius: 28, child: Icon(Icons.person)),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
                    SizedBox(height: 2),
                    Text(_email, style: const TextStyle(color: AppColors.textSecondary)),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Text('Verified', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
                        SizedBox(width: 8),
                        Text('Member since 2025', style: TextStyle(color: AppColors.textSecondary)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(child: _StatCard(value: '${listings.length}', label: 'Listings')),
              SizedBox(width: 8),
              Expanded(child: _StatCard(value: '0', label: 'Offers')),
              SizedBox(width: 8),
              Expanded(child: _StatCard(value: '0', label: 'Purchases')),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: _TabButton(
                label: 'My Listings',
                isActive: _selectedTab == 0,
                onTap: () => setState(() => _selectedTab = 0),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _TabButton(
                label: 'Offers',
                isActive: _selectedTab == 1,
                onTap: () => setState(() => _selectedTab = 1),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _TabButton(
                label: 'Purchases',
                isActive: _selectedTab == 2,
                onTap: () => setState(() => _selectedTab = 2),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (_selectedTab == 0 && listings.isEmpty)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surfaceFor(context),
                borderRadius: AppRadius.lg,
                border: Border.all(color: AppColors.borderFor(context)),
              ),
              child: Text(
                'No listings uploaded yet. Create your first project from Sell tab.',
                style: TextStyle(color: AppColors.secondaryTextFor(context)),
              ),
            )
          else if (_selectedTab == 0)
            ...List.generate(
              listings.length,
              (index) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceFor(context),
                  borderRadius: AppRadius.lg,
                  border: Border.all(color: AppColors.borderFor(context)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(listings[index].title, style: const TextStyle(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text('INR ${listings[index].price.toStringAsFixed(0)}',
                        style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    Text(listings[index].description,
                        maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColors.secondaryTextFor(context))),
                  ],
                ),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surfaceFor(context),
                borderRadius: AppRadius.lg,
                border: Border.all(color: AppColors.borderFor(context)),
              ),
              child: Text(
                _selectedTab == 1 ? 'No offers yet.' : 'No purchases yet.',
                style: TextStyle(color: AppColors.secondaryTextFor(context)),
              ),
            ),
        ],
      ),
    );
  }

  void _openSettingsSheet(BuildContext context, ThemeService themeService) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<ThemeService>(
          builder: (context, settings, __) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit_outlined),
                title: const Text('Edit profile'),
                onTap: () {
                  Navigator.pop(context);
                  _openEditProfileDialog(context);
                },
              ),
              SwitchListTile(
                title: const Text('Dark theme'),
                value: settings.isDarkMode,
                onChanged: (value) => context.read<ThemeService>().setDarkMode(value),
              ),
              SwitchListTile(
                title: const Text('Notifications'),
                value: settings.notificationsEnabled,
                onChanged: (value) => context.read<ThemeService>().setNotifications(value),
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.redAccent),
                title: const Text('Log out', style: TextStyle(color: Colors.redAccent)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (_) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openEditProfileDialog(BuildContext context) {
    final nameController = TextEditingController(text: _name);
    final emailController = TextEditingController(text: _email);

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Name')),
            const SizedBox(height: 10),
            TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _name = nameController.text.trim().isEmpty ? _name : nameController.text.trim();
                _email = emailController.text.trim().isEmpty ? _email : emailController.text.trim();
              });
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.value, required this.label});
  final String value;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceFor(context),
        borderRadius: AppRadius.md,
        border: Border.all(color: AppColors.borderFor(context)),
      ),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 22, color: AppColors.cyan, fontWeight: FontWeight.w700)),
          Text(label, style: const TextStyle(color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary.withValues(alpha: 0.18) : Colors.transparent,
          border: Border.all(
            color: isActive ? AppColors.primary.withValues(alpha: 0.45) : AppColors.borderFor(context),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            color: isActive
                ? (AppColors.isDark(context) ? AppColors.textPrimary : AppColors.lightText)
                : AppColors.secondaryTextFor(context),
          ),
        ),
      ),
    );
  }
}

