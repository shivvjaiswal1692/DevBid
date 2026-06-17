import 'package:devbid/theme/app_theme.dart';
import 'package:flutter/material.dart';

class StartupProjectCard extends StatelessWidget {
  const StartupProjectCard({
    super.key,
    required this.title,
    required this.price,
    required this.subtitle,
    required this.category,
    this.imageUrl,
    this.onTap,
  });

  final String title;
  final String price;
  final String subtitle;
  final String category;
  final String? imageUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.lg,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceFor(context),
          borderRadius: AppRadius.lg,
          border: Border.all(color: AppColors.borderFor(context)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: imageUrl != null
                      ? Image.network(
                          imageUrl!,
                          height: 160,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _placeholder(),
                        )
                      : _placeholder(),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(category, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 22))),
                      Text(price, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 22)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(subtitle, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColors.secondaryTextFor(context))),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const CircleAvatar(radius: 12, child: Icon(Icons.person, size: 13)),
                      const SizedBox(width: 6),
                      const Text('You'),
                      const Spacer(),
                      const Text('New', style: TextStyle(color: AppColors.cyan, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      height: 160,
      width: double.infinity,
      color: const Color(0xFF1D2438),
      alignment: Alignment.center,
      child: const Icon(Icons.image_outlined, color: AppColors.textSecondary, size: 30),
    );
  }
}
