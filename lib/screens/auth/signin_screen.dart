import 'package:devbid/screens/auth/signup_screen.dart';
import 'package:devbid/screens/home_screen.dart';
import 'package:devbid/theme/app_theme.dart';
import 'package:devbid/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const routeName = '/signin';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: ListView(
              padding: const EdgeInsets.all(18),
              children: [
                const SizedBox(height: 12),
                Center(
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.brandCharcoal,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.asset('assets/images/devbid_logo.png', fit: BoxFit.cover),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'DevBid',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontSize: 44,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ) ??
                      TextStyle(
                        fontSize: 44,
                        color: Theme.of(context).textTheme.headlineLarge?.color,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Start selling your projects today',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.secondaryTextFor(context)),
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceFor(context),
                    borderRadius: AppRadius.lg,
                    border: Border.all(color: AppColors.borderFor(context)),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.isDark(context) ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: AppColors.isDark(context) ? AppColors.surfaceMuted : Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, 2)),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text('Sign In', style: TextStyle(fontWeight: FontWeight.w700, color: Theme.of(context).textTheme.bodyLarge?.color)),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => Navigator.pushReplacementNamed(context, SignupScreen.routeName),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text('Sign Up', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.secondaryTextFor(context))),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        _AppInput(
                          label: 'Email ID',
                          controller: _emailController,
                          validator: (v) => (v == null || v.isEmpty || !v.contains('@')) ? 'Please enter a valid email ID' : null,
                        ),
                        const SizedBox(height: 10),
                        _AppInput(
                          label: 'Password',
                          controller: _passwordController,
                          obscureText: true,
                          validator: (v) => (v == null || v.isEmpty) ? 'Please enter your password' : null,
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: FilledButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                                if (states.contains(WidgetState.disabled)) {
                                  return Colors.white.withValues(alpha: 0.12);
                                }
                                return Theme.of(context).textTheme.bodyLarge?.color ?? Colors.white;
                              }),
                              foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                                if (states.contains(WidgetState.disabled)) {
                                  return Colors.white.withValues(alpha: 0.92);
                                }
                                return Theme.of(context).scaffoldBackgroundColor;
                              }),
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              ),
                              textStyle: const WidgetStatePropertyAll(
                                TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                              ),
                            ),
                            child: const Text('Sign In'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Expanded(child: Divider()),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Text('OR', style: TextStyle(color: AppColors.secondaryTextFor(context))),
                            ),
                            const Expanded(child: Divider()),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: OutlinedButton.icon(
                            onPressed: () async {
                              final googleSignIn = GoogleSignIn(clientId: '800543633852-fake-client-id.apps.googleusercontent.com');
                              try {
                                await googleSignIn.signIn();
                                if (context.mounted) {
                                  Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                                }
                              } catch (error) {
                                debugPrint("Google Sign In Error: $error");
                              }
                            },
                            icon: Image.network(
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1024px-Google_%22G%22_logo.svg.png',
                              width: 24,
                              height: 24,
                              errorBuilder: (context, error, stackTrace) => Icon(Icons.g_mobiledata, color: Theme.of(context).textTheme.bodyLarge?.color, size: 32),
                            ),
                            label: Text(
                              'Continue with Google',
                              style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color, fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: AppColors.borderFor(context), width: 1),
                              shape: const RoundedRectangleBorder(borderRadius: AppRadius.md),
                            ),
                          ),
                        ),

                      ],
                    ),
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

class _AppInput extends StatelessWidget {
  const _AppInput({
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.validator,
  });

  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
      decoration: InputDecoration(
        label: Text.rich(
          TextSpan(
            children: [
              TextSpan(text: label, style: TextStyle(color: AppColors.secondaryTextFor(context))),
            ],
          ),
        ),
        filled: true,
        fillColor: AppColors.isDark(context) ? AppColors.surfaceMuted : Colors.white,
        border: OutlineInputBorder(
          borderRadius: AppRadius.md,
          borderSide: BorderSide(color: AppColors.borderFor(context)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.md,
          borderSide: BorderSide(color: AppColors.borderFor(context)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: AppRadius.md,
          borderSide: BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }
}
