import 'package:devbid/theme/app_theme.dart';
import 'package:devbid/widgets/app_button.dart';
import 'package:flutter/material.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});
  static const routeName = '/delivery';

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  bool _sellerView = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Delivery Center')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _DeliveryProgressTracker(),
              const SizedBox(height: AppSpacing.md),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.surfaceFor(context),
                  borderRadius: AppRadius.md,
                  border: Border.all(color: AppColors.borderFor(context)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        text: 'Seller View',
                        isSecondary: !_sellerView,
                        onPressed: () => setState(() => _sellerView = true),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: AppButton(
                        text: 'Buyer View',
                        isSecondary: _sellerView,
                        onPressed: () => setState(() => _sellerView = false),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              _sellerView ? const _SellerDeliveryCard() : const _BuyerDeliveryCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class _DeliveryProgressTracker extends StatelessWidget {
  const _DeliveryProgressTracker();

  @override
  Widget build(BuildContext context) {
    const labels = ['Payment Complete', 'Delivery Submitted', 'Buyer Review', 'Deal Completed'];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceFor(context),
        borderRadius: AppRadius.lg,
        border: Border.all(color: AppColors.borderFor(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Deal Workflow', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Row(
            children: List.generate(
              labels.length,
              (index) => Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: index == labels.length - 1 ? 0 : 6),
                  height: 4,
                  decoration: BoxDecoration(
                    color: index <= 1 ? AppColors.primary : AppColors.borderFor(context),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 6,
            children: List.generate(
              labels.length,
              (index) => Text(
                labels[index],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: index == 1 ? FontWeight.w700 : FontWeight.w500,
                  color: index <= 1 ? AppColors.textPrimary : AppColors.secondaryTextFor(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SellerDeliveryCard extends StatelessWidget {
  const _SellerDeliveryCard();

  @override
  Widget build(BuildContext context) {
    return _ActionCard(
      title: 'Seller Delivery Actions',
      actions: const [
        'Upload Source Code',
        'Upload Documentation',
        'GitHub Transfer Link',
        'Deployment Instructions',
      ],
      primaryLabel: 'Submit Delivery Package',
      secondaryLabel: 'Save Draft',
    );
  }
}

class _BuyerDeliveryCard extends StatelessWidget {
  const _BuyerDeliveryCard();

  @override
  Widget build(BuildContext context) {
    return _ActionCard(
      title: 'Buyer Review Actions',
      actions: const [
        'Download Files',
        'View Repository',
        'Confirm Delivery',
        'Raise Issue',
      ],
      primaryLabel: 'Confirm Delivery',
      secondaryLabel: 'Open Dispute',
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.title,
    required this.actions,
    required this.primaryLabel,
    required this.secondaryLabel,
  });
  final String title;
  final List<String> actions;
  final String primaryLabel;
  final String secondaryLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceFor(context),
        borderRadius: AppRadius.lg,
        border: Border.all(color: AppColors.borderFor(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
          const SizedBox(height: 10),
          ...actions.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  const Icon(Icons.check_circle_outline, size: 18, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Expanded(child: Text(item)),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          AppButton(
            text: primaryLabel,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$primaryLabel (demo action)')),
              );
            },
          ),
          const SizedBox(height: AppSpacing.sm),
          AppButton(
            text: secondaryLabel,
            isSecondary: true,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$secondaryLabel (demo action)')),
              );
            },
          ),
        ],
      ),
    );
  }
}
