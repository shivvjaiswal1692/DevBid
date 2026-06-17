import 'package:devbid/screens/auth/signup_screen.dart';
import 'package:devbid/screens/home_screen.dart';
import 'package:devbid/theme/app_theme.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';

  static const Color _bg = Color(0xFF000000);
  static const Color _textPrimary = Color(0xFFFFFFFF);
  static const Color _textMuted = Color(0xFFB0B0B5);
  static const Color _textSubtle = Color(0xFF8E8E93);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: LoginScreen._bg,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                    width: 84,
                    height: 84,
                    decoration: BoxDecoration(
                      color: AppColors.brandCharcoal,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset('assets/images/devbid_logo.png', fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'DevBid',
                    style: theme.headlineLarge?.copyWith(
                          fontSize: 44,
                          fontWeight: FontWeight.w700,
                          color: LoginScreen._textPrimary,
                          letterSpacing: -0.5,
                        ) ??
                        const TextStyle(
                          fontSize: 44,
                          fontWeight: FontWeight.w700,
                          color: LoginScreen._textPrimary,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'The marketplace where student projects meet real-world buyers',
                    style: theme.bodyLarge?.copyWith(
                      color: LoginScreen._textMuted,
                      fontSize: 17,
                      height: 1.35,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 34),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton(
                      onPressed: () => Navigator.pushNamed(context, SignupScreen.routeName),
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                          if (states.contains(WidgetState.disabled)) {
                            return Colors.white.withValues(alpha: 0.12);
                          }
                          return LoginScreen._textPrimary;
                        }),
                        foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                          if (states.contains(WidgetState.disabled)) {
                            return Colors.white.withValues(alpha: 0.92);
                          }
                          return LoginScreen._bg;
                        }),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        textStyle: const WidgetStatePropertyAll(
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                      ),
                      child: const Text('Get Started'),
                    ),
                  ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
                  child: Text(
                    '© ${DateTime.now().year} DevBid. All rights reserved.',
                    style: theme.bodySmall?.copyWith(color: LoginScreen._textSubtle),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
