import 'package:devbid/screens/offer_bid_screen.dart';
import 'package:devbid/theme/app_theme.dart';
import 'package:devbid/widgets/app_button.dart';
import 'package:flutter/material.dart';

class StartupDetailScreen extends StatelessWidget {
  const StartupDetailScreen({super.key});
  static const routeName = '/detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Startup Details')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('AI Resume Builder SaaS', style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: AppSpacing.sm),
                    const Text(
                      'Built with Flutter + Node. Active users and recurring revenue included in the acquisition.',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    _card(
                      context,
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Asking Price'),
                          Text('INR 1,20,000', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.primary)),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _card(
                      context,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Acquisition Highlights', style: TextStyle(fontWeight: FontWeight.w700)),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: const [
                              _PremiumBadge('Source Code Included'),
                              _PremiumBadge('GitHub Transfer Available'),
                              _PremiumBadge('Documentation Included'),
                              _PremiumBadge('Revenue Generating'),
                              _PremiumBadge('Verified Seller'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _card(
                      context,
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Technical Stack', style: TextStyle(fontWeight: FontWeight.w700)),
                          SizedBox(height: 10),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              _TechTag('Flutter'),
                              _TechTag('React'),
                              _TechTag('Node.js'),
                              _TechTag('Firebase'),
                              _TechTag('MongoDB'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _card(
                      context,
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('What\'s Included', style: TextStyle(fontWeight: FontWeight.w700)),
                          SizedBox(height: 10),
                          _IncludedTile('Complete Source Code'),
                          _IncludedTile('UI/UX Files and assets'),
                          _IncludedTile('Deployment and setup guide'),
                          _IncludedTile('API and database scripts'),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _card(
                      context,
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Seller Trust', style: TextStyle(fontWeight: FontWeight.w700)),
                          SizedBox(height: 10),
                          _TrustRow(label: 'Seller Rating', value: '4.9 / 5'),
                          _TrustRow(label: 'Projects Sold', value: '27'),
                          _TrustRow(label: 'Verification Status', value: 'Fully Verified'),
                          _TrustRow(label: 'Response Time', value: '< 2 hours'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.lg),
              child: AppButton(
                text: 'Place a Bid',
                onPressed: () => Navigator.pushNamed(context, OfferBidScreen.routeName),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _card(BuildContext context, Widget child) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceFor(context),
        borderRadius: AppRadius.lg,
        border: Border.all(color: AppColors.borderFor(context)),
      ),
      child: child,
    );
  }
}

class _PremiumBadge extends StatelessWidget {
  const _PremiumBadge(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
    );
  }
}

class _TechTag extends StatelessWidget {
  const _TechTag(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.mutedSurfaceFor(context),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderFor(context)),
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
    );
  }
}

class _IncludedTile extends StatelessWidget {
  const _IncludedTile(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, size: 18, color: AppColors.success),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

class _TrustRow extends StatelessWidget {
  const _TrustRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(child: Text(label, style: TextStyle(color: AppColors.secondaryTextFor(context)))),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
