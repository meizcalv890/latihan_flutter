import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthController auth = Get.find<AuthController>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool obscurePassword = true;
  bool rememberMe = true;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Theme.of(context).colorScheme;
    final isDesktop = MediaQuery.of(context).size.width >= 760;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(isDesktop ? 32 : 20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1040),
              child: isDesktop
                  ? _desktopLayout(context)
                  : _mobileLayout(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _desktopLayout(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      constraints: const BoxConstraints(minHeight: 620),
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colors.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Expanded(child: _brandPanel(context)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 54, vertical: 48),
              child: _loginForm(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mobileLayout(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _mobileBrand(context),
        const SizedBox(height: 30),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: colors.surfaceContainer,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: colors.outlineVariant),
          ),
          child: _loginForm(context),
        ),
        const SizedBox(height: 24),
        _footer(context),
      ],
    );
  }

  Widget _brandPanel(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      color: colors.primary,
      padding: const EdgeInsets.all(48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _brandImage(context, size: 150, padding: 12),
              const SizedBox(height: 32),
              Text(
                'UTILITY\nHUB.',
                style: TextStyle(
                  color: colors.onPrimary,
                  fontSize: 48,
                  height: 1.05,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1.8,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'login_brand_description'.tr,
                style: TextStyle(
                  color: colors.onPrimary.withValues(alpha: 0.75),
                  fontSize: 15,
                  height: 1.7,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(width: 42, height: 3, color: colors.tertiary),
              const SizedBox(height: 18),
              Text(
                'login_brand_tagline'.tr.toUpperCase(),
                style: TextStyle(
                  color: colors.onPrimary.withValues(alpha: 0.7),
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'login_brand_footer'.tr,
                style: TextStyle(
                  color: colors.onPrimary.withValues(alpha: 0.9),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _mobileBrand(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      children: [
        _brandImage(context, size: 58, padding: 5),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'UTILITY HUB',
                style: TextStyle(
                  color: colors.onSurface,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                'login_mobile_subtitle'.tr,
                style: TextStyle(color: colors.onSurfaceVariant, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _brandImage(
    BuildContext context, {
    required double size,
    required double padding,
  }) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.6)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        'assets/images/OIP.webp',
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            Icons.image_not_supported_outlined,
            color: colors.onSurfaceVariant,
            size: size * 0.45,
          );
        },
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'login_section_label'.tr.toUpperCase(),
            style: TextStyle(
              color: colors.tertiary,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.8,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'login_welcome'.tr,
            style: TextStyle(
              color: colors.onSurface,
              fontSize: 31,
              fontWeight: FontWeight.w800,
              letterSpacing: -1.1,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'login_subtitle'.tr,
            style: TextStyle(
              color: colors.onSurfaceVariant,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 36),

          _fieldLabel(context, 'login_username'.tr),
          const SizedBox(height: 10),
          TextFormField(
            controller: usernameController,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.username],
            decoration: _inputDecoration(
              context,
              hint: 'login_username_hint'.tr,
              icon: Icons.person_outline_rounded,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'login_username_required'.tr;
              }
              return null;
            },
          ),

          const SizedBox(height: 24),

          _fieldLabel(context, 'login_password'.tr),
          const SizedBox(height: 10),
          TextFormField(
            controller: passwordController,
            obscureText: obscurePassword,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.password],
            onFieldSubmitted: (_) => handleLogin(),
            decoration:
                _inputDecoration(
                  context,
                  hint: 'login_password_hint'.tr,
                  icon: Icons.lock_outline_rounded,
                ).copyWith(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: colors.onSurfaceVariant,
                      size: 20,
                    ),
                  ),
                ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'login_password_required'.tr;
              }
              return null;
            },
          ),

          const SizedBox(height: 12),

          CheckboxListTile(
            value: rememberMe,
            onChanged: (value) {
              setState(() {
                rememberMe = value ?? false;
              });
            },
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: colors.primary,
            dense: true,
            title: Text(
              'login_remember'.tr,
              style: TextStyle(
                color: colors.onSurfaceVariant,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(height: 22),

          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                foregroundColor: colors.onPrimary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'login_button'.tr,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.arrow_forward_rounded, size: 18),
                ],
              ),
            ),
          ),

          const SizedBox(height: 28),

          if (MediaQuery.of(context).size.width >= 760) _footer(context),
        ],
      ),
    );
  }

  Widget _fieldLabel(BuildContext context, String label) {
    final colors = Theme.of(context).colorScheme;

    return Text(
      label.toUpperCase(),
      style: TextStyle(
        color: colors.onSurface,
        fontSize: 10,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.2,
      ),
    );
  }

  InputDecoration _inputDecoration(
    BuildContext context, {
    required String hint,
    required IconData icon,
  }) {
    final colors = Theme.of(context).colorScheme;

    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: colors.onSurfaceVariant, fontSize: 13),
      prefixIcon: Icon(icon, color: colors.onSurfaceVariant, size: 20),
      filled: true,
      fillColor: colors.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colors.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colors.primary, width: 1.5),
      ),
    );
  }

  Widget _footer(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Center(
      child: Text(
        'login_footer'.tr.toUpperCase(),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: colors.onSurfaceVariant.withValues(alpha: 0.8),
          fontSize: 9,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.3,
        ),
      ),
    );
  }

  void handleLogin() {
    if (!formKey.currentState!.validate()) return;

    auth.login(
      inputUsername: usernameController.text,
      inputPassword: passwordController.text,
      remember: rememberMe,
    );
  }
}
