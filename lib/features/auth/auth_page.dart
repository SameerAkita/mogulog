import 'package:flutter/material.dart';
import 'package:mogulog/features/onboarding/onboarding_page.dart';
import 'package:mogulog/theme/app_colors.dart';
import 'package:mogulog/views/widget_tree.dart';

enum AuthMode { signIn, signUp }

class AuthPage extends StatefulWidget {
  final AuthMode initialMode;

  const AuthPage({super.key, this.initialMode = AuthMode.signUp});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late AuthMode mode = widget.initialMode;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void handleContinue() {
    if (mode == AuthMode.signUp) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingPage()),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const WidgetTree()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isSignUp = mode == AuthMode.signUp;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Text(
                  isSignUp ? 'Create your account' : 'Welcome back',
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    height: 1.05,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  isSignUp
                      ? 'Set up auth first, then you can connect Supabase cleanly.'
                      : 'Sign in to continue to your meals and analytics.',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 28),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.orangeAccent.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _AuthModeButton(
                          label: 'Sign Up',
                          isSelected: isSignUp,
                          onTap: () {
                            setState(() {
                              mode = AuthMode.signUp;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: _AuthModeButton(
                          label: 'Sign In',
                          isSelected: !isSignUp,
                          onTap: () {
                            setState(() {
                              mode = AuthMode.signIn;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                if (isSignUp) ...[],
                _AuthField(
                  controller: emailController,
                  label: 'Email',
                  hintText: 'sameer@example.com',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 14),
                _AuthField(
                  controller: passwordController,
                  label: 'Password',
                  hintText: '••••••••',
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: handleContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      isSignUp ? 'Continue to onboarding' : 'Continue to app',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WidgetTree(),
                        ),
                      );
                    },
                    child: const Text('Skip for now'),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Temporary auth UI for Supabase setup. Next step is wiring these fields into Supabase Auth.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black45,
                    height: 1.4,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AuthModeButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _AuthModeButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: isSelected ? AppColors.darkbrown : Colors.black54,
          ),
        ),
      ),
    );
  }
}

class _AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  const _AuthField({
    required this.controller,
    required this.label,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        filled: true,
        fillColor: AppColors.orangeAccent.withValues(alpha: 0.18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.orange, width: 1.5),
        ),
      ),
    );
  }
}
