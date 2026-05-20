import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/app_info.dart';
import '../../../core/theme/app_colors.dart';
import '../../../main.dart' show AppRoutes;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;
  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    setState(() => _loading = true);
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;

    final email = _emailController.text.trim().toLowerCase();

    // Role-based routing (unchanged).
    if (email.contains('technician')) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.technicianHome);
    } else if (email.contains('customer')) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.customerHome);
    } else {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.danger,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(16),
          content: const Text(
            'Use an email containing "customer" or "technician" to continue.',
            style: TextStyle(fontFamily: 'Geist'),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _CurvedHeader(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(28, 16, 28, 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const _FieldLabel('Email Address'),
                        const SizedBox(height: 10),
                        _PillTextField(
                          controller: _emailController,
                          hint: 'Enter Mail Address',
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'Email is required';
                            }
                            if (!v.contains('@')) return 'Enter a valid email';
                            return null;
                          },
                        ),
                        const SizedBox(height: 18),
                        const _FieldLabel('Password'),
                        const SizedBox(height: 10),
                        _PillTextField(
                          controller: _passwordController,
                          hint: 'Enter Your Password',
                          obscure: _obscure,
                          suffix: GestureDetector(
                            onTap: () =>
                                setState(() => _obscure = !_obscure),
                            child: Icon(
                              _obscure
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              size: 20,
                              color: AppColors.textMuted,
                            ),
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return 'Password is required';
                            }
                            if (v.length < 4) {
                              return 'Minimum 4 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Forget Password?',
                              style: TextStyle(
                                fontFamily: 'Geist',
                                color: _LoginPalette.accentBlue,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 22),
                        _PillButton(
                          label: 'Sign In',
                          loading: _loading,
                          onPressed: _signIn,
                        ),
                        const SizedBox(height: 22),
                        const _OrDivider(),
                        const SizedBox(height: 18),
                        _OtpButton(onPressed: () {}),
                        const SizedBox(height: 26),
                        Center(
                          child: GestureDetector(
                            onTap: () {},
                            child: RichText(
                              text: const TextSpan(
                                style: TextStyle(
                                  fontFamily: 'Geist',
                                  fontSize: 13,
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.w500,
                                ),
                                children: [
                                  TextSpan(text: "Don't Have An Account? "),
                                  TextSpan(
                                    text: 'Sign Up',
                                    style: TextStyle(
                                      color: _LoginPalette.accentBlue,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Center(
                          child: Text(
                            AppInfo.fullLabel,
                            style: const TextStyle(
                              fontFamily: 'Geist',
                              fontSize: 11,
                              color: AppColors.textMuted,
                              fontWeight: FontWeight.w500,
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
    );
  }
}

/// Palette tuned to the reference mock — keeps brand primary for routing
/// surfaces and uses a brighter accent for the form's CTAs / wave.
class _LoginPalette {
  static const Color accentBlue = Color(0xFF2D72D9);
  static const Color accentBlueDeep = Color(0xFF1E5DB8);
  static const Color waveSoft = Color(0xFFE9F1FB);
  static const Color fieldFill = Color(0xFFF7F8FA);
  static const Color fieldShadow = Color(0x14000000);
}

class _CurvedHeader extends StatelessWidget {
  const _CurvedHeader();

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;
    final headerHeight = 280 + topInset;
    return SizedBox(
      height: headerHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Soft wave behind, slightly offset for depth.
          Positioned.fill(
            child: ClipPath(
              clipper: _BackWaveClipper(),
              child: Container(color: _LoginPalette.waveSoft),
            ),
          ),
          // Primary blue wave — fills from the very top of the screen.
          Positioned.fill(
            child: ClipPath(
              clipper: _FrontWaveClipper(),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _LoginPalette.accentBlue,
                      _LoginPalette.accentBlueDeep,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),
          // Heading text — centered in the wave header.
          Positioned(
            left: 0,
            right: 0,
            top: topInset + 32,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Welcome Back!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Geist',
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Sign In',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Geist',
                    color: Colors.white,
                    fontSize: 44,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1.2,
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FrontWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final p = Path();
    // Start near top-right, sweep a soft S-curve down to bottom-left,
    // then close along the top-right edge.
    p.moveTo(size.width, 0);
    p.lineTo(size.width, size.height * 0.85);
    p.cubicTo(
      size.width * 0.78, size.height * 1.05,
      size.width * 0.50, size.height * 0.68,
      size.width * 0.32, size.height * 0.78,
    );
    p.cubicTo(
      size.width * 0.18, size.height * 0.86,
      size.width * 0.08, size.height * 0.55,
      0, size.height * 0.30,
    );
    p.lineTo(0, 0);
    return p..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _BackWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final p = Path();
    p.moveTo(size.width, 0);
    p.lineTo(size.width, size.height * 0.95);
    p.cubicTo(
      size.width * 0.70, size.height * 1.10,
      size.width * 0.42, size.height * 0.80,
      size.width * 0.22, size.height * 0.92,
    );
    p.cubicTo(
      size.width * 0.10, size.height * 0.96,
      size.width * 0.02, size.height * 0.70,
      0, size.height * 0.45,
    );
    p.lineTo(0, 0);
    return p..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Geist',
        color: Color(0xFF111827),
        fontSize: 14,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.1,
      ),
    );
  }
}

class _PillTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final Widget? suffix;
  final TextInputType keyboardType;
  final Iterable<String>? autofillHints;
  final String? Function(String?) validator;

  const _PillTextField({
    required this.controller,
    required this.hint,
    required this.validator,
    this.obscure = false,
    this.suffix,
    this.keyboardType = TextInputType.text,
    this.autofillHints,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _LoginPalette.fieldFill,
        borderRadius: BorderRadius.circular(32),
        boxShadow: const [
          BoxShadow(
            color: _LoginPalette.fieldShadow,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        autofillHints: autofillHints,
        validator: validator,
        cursorColor: _LoginPalette.accentBlue,
        style: const TextStyle(
          fontFamily: 'Geist',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFF111827),
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontFamily: 'Geist',
            fontSize: 13.5,
            fontWeight: FontWeight.w400,
            color: AppColors.textMuted,
          ),
          suffixIcon: suffix == null
              ? null
              : Padding(
                  padding: const EdgeInsets.only(right: 18),
                  child: suffix,
                ),
          suffixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          errorStyle: const TextStyle(
            fontFamily: 'Geist',
            fontSize: 11.5,
            color: AppColors.danger,
            height: 1.2,
          ),
        ),
      ),
    );
  }
}

class _PillButton extends StatelessWidget {
  final String label;
  final bool loading;
  final VoidCallback onPressed;
  const _PillButton({
    required this.label,
    required this.loading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: loading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _LoginPalette.accentBlue,
          foregroundColor: Colors.white,
          disabledBackgroundColor: _LoginPalette.accentBlue.withOpacity(0.75),
          disabledForegroundColor: Colors.white,
          elevation: 0,
          shadowColor: _LoginPalette.accentBlue.withOpacity(0.35),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 180),
          child: loading
              ? const SizedBox(
                  key: ValueKey('l'),
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.4,
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                )
              : Text(
                  label,
                  key: const ValueKey('t'),
                  style: const TextStyle(
                    fontFamily: 'Geist',
                    fontSize: 15.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.1,
                  ),
                ),
        ),
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: const Color(0xFFE5E7EB))),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'Or',
            style: TextStyle(
              fontFamily: 'Geist',
              color: AppColors.textMuted,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(child: Container(height: 1, color: const Color(0xFFE5E7EB))),
      ],
    );
  }
}

class _OtpButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _OtpButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: const Icon(
          Icons.sms_outlined,
          size: 20,
          color: _LoginPalette.accentBlue,
        ),
        label: const Text(
          'Get OTP',
          style: TextStyle(
            fontFamily: 'Geist',
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: _LoginPalette.accentBlue,
            letterSpacing: 0.1,
          ),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: BorderSide(
            color: _LoginPalette.accentBlue.withOpacity(0.45),
            width: 1.4,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
      ),
    );
  }
}
