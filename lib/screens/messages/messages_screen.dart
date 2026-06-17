import 'package:devbid/theme/app_theme.dart';
import 'package:devbid/widgets/devbid_bottom_nav.dart';
import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});
  static const routeName = '/messages';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const DevBidBottomNav(currentIndex: 3),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          const Text('Messages', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30)),
          const SizedBox(height: 10),
          const TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search conversations...',
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceFor(context),
              borderRadius: AppRadius.lg,
              border: Border.all(color: AppColors.borderFor(context)),
            ),
            child: Text(
              'No conversations yet. Buyers can message you after you publish a project.',
              style: TextStyle(color: AppColors.secondaryTextFor(context)),
            ),
          ),
        ],
      ),
    );
  }
}
