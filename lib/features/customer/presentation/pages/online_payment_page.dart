import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class OnlinePaymentPage extends StatefulWidget {
  const OnlinePaymentPage({super.key});

  @override
  State<OnlinePaymentPage> createState() => _OnlinePaymentPageState();
}

class _OnlinePaymentPageState extends State<OnlinePaymentPage> {
  int _selected = 0;

  static final _gateways = [
    _Gateway(
      label: 'KBZPay',
      tagline: 'Direct wallet transfer',
      logoWidget: const _KBZPayLogo(),
    ),
    _Gateway(
      label: 'AYAPay',
      tagline: 'Bank-backed e-wallet',
      logoWidget: const _AYAPayLogo(),
    ),
    _Gateway(
      label: 'WaveMoney',
      tagline: 'Instant mobile transfer',
      logoWidget: const _WaveMoneyLogo(),
    ),
    _Gateway(
      label: 'Bank Card',
      tagline: 'Visa, Mastercard, JCB',
      logoWidget: const _BankCardLogo(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Online Payment'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          _AmountCard(),
          const SizedBox(height: 20),
          Text(
            'Choose payment method',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 4),
          Text(
            'Funds are transferred directly to your service — no in-app wallet.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 14),
          for (int i = 0; i < _gateways.length; i++) ...[
            _GatewayTile(
              gateway: _gateways[i],
              selected: _selected == i,
              onTap: () => setState(() => _selected = i),
            ),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppColors.success,
                  content: Text(
                    'Continuing with ${_gateways[_selected].label}…',
                  ),
                ),
              );
            },
            icon: const Icon(Icons.lock_outline_rounded, size: 18),
            label: const Text('Continue securely'),
          ),
        ],
      ),
    );
  }
}

class _AmountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Service · Fiber Internet · 500 Mbps',
            style: TextStyle(
              fontFamily: 'Geist',
              color: Colors.white.withOpacity(0.85),
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'FB-500-2298',
            style: TextStyle(
              fontFamily: 'Geist',
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Amount due',
            style: TextStyle(
              fontFamily: 'Geist',
              color: Colors.white.withOpacity(0.8),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            '48,900 MMK',
            style: TextStyle(
              fontFamily: 'Geist',
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.event_outlined,
                  color: Colors.white.withOpacity(0.85), size: 14),
              const SizedBox(width: 6),
              Text(
                'Due May 28, 2026',
                style: TextStyle(
                  fontFamily: 'Geist',
                  color: Colors.white.withOpacity(0.85),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Gateway {
  final String label;
  final String tagline;
  final Widget logoWidget;
  const _Gateway({
    required this.label,
    required this.tagline,
    required this.logoWidget,
  });
}

// ── KBZPay Logo ────────────────────────────────────────────────────────────
class _KBZPayLogo extends StatelessWidget {
  const _KBZPayLogo();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF1A4AB0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          // Corner arrow marks
          Positioned(
            top: 5,
            right: 5,
            child: CustomPaint(size: const Size(7, 7), painter: _ArrowPainter()),
          ),
          Positioned(
            bottom: 5,
            left: 5,
            child: Transform.rotate(
              angle: 3.14159,
              child: CustomPaint(size: const Size(7, 7), painter: _ArrowPainter()),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'KBZ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                    height: 1.1,
                  ),
                ),
                const Text(
                  'Pay',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                    height: 1.2,
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

class _ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.7)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;
    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

// ── AYAPay Logo ────────────────────────────────────────────────────────────
class _AYAPayLogo extends StatelessWidget {
  const _AYAPayLogo();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        gradient: const RadialGradient(
          colors: [Color(0xFFD92B2B), Color(0xFF9B0E0E)],
          center: Alignment(-0.4, -0.4),
          radius: 1.2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: CustomPaint(
        painter: _AYASwirl(),
      ),
    );
  }
}

class _AYASwirl extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Draw a "P"-like swirl shape matching AYA Pay branding
    final path = Path();
    final cx = size.width * 0.42;
    final cy = size.height * 0.50;
    final r = size.width * 0.30;

    // Outer arc (top-right sweep)
    final rect = Rect.fromCircle(center: Offset(cx, cy - r * 0.1), radius: r);
    path.addArc(rect, -3.14, 3.14 * 1.6);

    // Inner hole
    final innerRect = Rect.fromCircle(
        center: Offset(cx + r * 0.08, cy - r * 0.05), radius: r * 0.55);
    path.addArc(innerRect, 0, -3.14 * 2);

    // Tail sweeping down-left
    final tail = Path()
      ..moveTo(cx - r * 0.9, cy + r * 0.6)
      ..quadraticBezierTo(
        cx - r * 0.2, cy + r * 1.4,
        cx + r * 0.5, cy + r * 0.85,
      )
      ..quadraticBezierTo(
        cx + r * 0.25, cy + r * 0.6,
        cx - r * 0.05, cy + r * 0.55,
      )
      ..quadraticBezierTo(
        cx - r * 0.5, cy + r * 1.1,
        cx - r * 0.85, cy + r * 0.52,
      )
      ..close();

    path.fillType = PathFillType.evenOdd;
    canvas.drawPath(path, paint);
    canvas.drawPath(tail, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

// ── WaveMoney Logo ─────────────────────────────────────────────────────────
class _WaveMoneyLogo extends StatelessWidget {
  const _WaveMoneyLogo();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFFFE000),
        borderRadius: BorderRadius.circular(12),
      ),
      child: CustomPaint(painter: _WaveSwirl()),
    );
  }
}

class _WaveSwirl extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1AABDB)
      ..style = PaintingStyle.fill;

    final cx = size.width * 0.50;
    final cy = size.height * 0.50;

    // Three overlapping circles forming a swirl (Wave Money brand mark)
    // Top-left circle
    final p1 = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(cx - size.width * 0.14, cy - size.height * 0.10),
          radius: size.width * 0.22));

    // Bottom-left circle
    final p2 = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(cx - size.width * 0.10, cy + size.height * 0.13),
          radius: size.width * 0.22));

    // Right circle
    final p3 = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(cx + size.width * 0.16, cy),
          radius: size.width * 0.22));

    // Center yellow hole (subtracts to reveal background)
    final hole = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(cx + size.width * 0.02, cy + size.height * 0.02),
          radius: size.width * 0.095));

    final combined =
        Path.combine(PathOperation.union, Path.combine(PathOperation.union, p1, p2), p3);
    final withHole = Path.combine(PathOperation.difference, combined, hole);

    canvas.drawPath(withHole, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

// ── Bank Card Logo ─────────────────────────────────────────────────────────
class _BankCardLogo extends StatelessWidget {
  const _BankCardLogo();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF0EA5E9).withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(
        Icons.credit_card_rounded,
        color: Color(0xFF0EA5E9),
        size: 24,
      ),
    );
  }
}

class _GatewayTile extends StatelessWidget {
  final _Gateway gateway;
  final bool selected;
  final VoidCallback onTap;

  const _GatewayTile({
    required this.gateway,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.border,
              width: selected ? 1.6 : 1,
            ),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: gateway.logoWidget,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(gateway.label,
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 2),
                    Text(gateway.tagline,
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected ? AppColors.primary : Colors.transparent,
                  border: Border.all(
                    color: selected ? AppColors.primary : AppColors.border,
                    width: 2,
                  ),
                ),
                child: selected
                    ? const Icon(Icons.check, size: 14, color: Colors.white)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
