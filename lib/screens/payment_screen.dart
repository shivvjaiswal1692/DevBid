import 'package:devbid/screens/delivery_screen.dart';
import 'package:devbid/theme/app_theme.dart';
import 'package:devbid/widgets/app_button.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});
  static const routeName = '/payment';

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final List<_MethodItem> _methods = const [
    _MethodItem('UPI', Icons.qr_code_2_outlined),
    _MethodItem('Debit / Credit Card', Icons.credit_card_outlined),
    _MethodItem('Net Banking', Icons.account_balance_outlined),
    _MethodItem('Wallets', Icons.account_balance_wallet_outlined),
  ];
  int _selectedMethod = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Secure Payment')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _FlowStepper(),
              const SizedBox(height: AppSpacing.lg),
              _sectionCard(
                context,
                title: 'Order Summary',
                child: const Column(
                  children: [
                    _SummaryRow(label: 'Project Name', value: 'AI Resume Builder SaaS'),
                    _SummaryRow(label: 'Seller Name', value: 'Aman Verma'),
                    _SummaryRow(label: 'Deal Amount', value: 'INR 1,20,000'),
                    _SummaryRow(label: 'Platform Fee', value: 'INR 3,600'),
                    Divider(height: 22),
                    _SummaryRow(label: 'Total Amount', value: 'INR 1,23,600', isEmphasized: true),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              _sectionCard(
                context,
                title: 'Payment Method',
                child: Column(
                  children: List.generate(
                    _methods.length,
                    (index) => RadioListTile<int>(
                      contentPadding: EdgeInsets.zero,
                      value: index,
                      groupValue: _selectedMethod,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _selectedMethod = value);
                        }
                      },
                      title: Text(_methods[index].title),
                      secondary: Icon(_methods[index].icon, color: AppColors.secondaryTextFor(context)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              _sectionCard(
                context,
                title: 'Security & Protection',
                child: const Column(
                  children: [
                    _TrustTile(
                      icon: Icons.lock_outline,
                      title: 'Secure Payment Badge',
                      subtitle: 'Bank-grade encrypted payment processing.',
                    ),
                    SizedBox(height: 10),
                    _TrustTile(
                      icon: Icons.verified_user_outlined,
                      title: 'Escrow Protection Badge',
                      subtitle: 'Funds are released only after delivery verification.',
                    ),
                    SizedBox(height: 10),
                    _TrustTile(
                      icon: Icons.shield_outlined,
                      title: 'Money-back Protection',
                      subtitle: 'Issue disputes quickly if deliverables do not match.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              AppButton(
                text: 'Pay Securely',
                onPressed: () => Navigator.pushNamed(context, DeliveryScreen.routeName),
              ),
              const SizedBox(height: AppSpacing.sm),
              AppButton(
                text: 'Cancel Transaction',
                isSecondary: true,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionCard(BuildContext context, {required String title, required Widget child}) {
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
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _MethodItem {
  const _MethodItem(this.title, this.icon);
  final String title;
  final IconData icon;
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.isEmphasized = false,
  });
  final String label;
  final String value;
  final bool isEmphasized;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontWeight: isEmphasized ? FontWeight.w700 : FontWeight.w500,
      fontSize: isEmphasized ? 16 : 14,
      color: isEmphasized ? AppColors.textPrimary : AppColors.secondaryTextFor(context),
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(child: Text(label, style: style)),
          Text(value, style: style.copyWith(color: isEmphasized ? AppColors.primary : null)),
        ],
      ),
    );
  }
}

class _TrustTile extends StatelessWidget {
  const _TrustTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.primary.withValues(alpha: 0.12),
          ),
          child: Icon(icon, size: 17, color: AppColors.primary),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 2),
              Text(subtitle, style: TextStyle(color: AppColors.secondaryTextFor(context))),
            ],
          ),
        ),
      ],
    );
  }
}

class _FlowStepper extends StatelessWidget {
  const _FlowStepper();

  @override
  Widget build(BuildContext context) {
    const labels = ['Deal Accepted', 'Payment', 'Delivery', 'Verification', 'Completed'];
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceFor(context),
        borderRadius: AppRadius.lg,
        border: Border.all(color: AppColors.borderFor(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Transaction Progress', style: TextStyle(fontWeight: FontWeight.w700)),
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
