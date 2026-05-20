import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/stat_card.dart';
import '../../../../shared/widgets/status_chip.dart';
import '../../../../shared/widgets/user_avatar.dart';

class WorkOrdersTab extends StatelessWidget {
  const WorkOrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: _Header()),
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(16, 18, 16, 12),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    child: StatCard(
                      icon: Icons.pending_actions_rounded,
                      iconColor: AppColors.warning,
                      label: 'Pending',
                      value: '5',
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: StatCard(
                      icon: Icons.autorenew_rounded,
                      iconColor: AppColors.info,
                      label: 'In Progress',
                      value: '2',
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: StatCard(
                      icon: Icons.task_alt_rounded,
                      iconColor: AppColors.success,
                      label: 'Resolved',
                      value: '11',
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Service Activations',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Text(
                    '3 today',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
                _OrderCard(
                  id: 'WO-7821',
                  icon: Icons.router_rounded,
                  color: AppColors.primary,
                  title: 'Fiber installation · 500 Mbps',
                  customer: 'Sarah Lim',
                  address: '14 Cedar Ave, Block B, #08-22',
                  phone: '+65 9123 4567',
                  eta: '09:30 – 11:00',
                  priority: 'High',
                  priorityType: StatusType.danger,
                ),
                _OrderCard(
                  id: 'WO-7825',
                  icon: Icons.sim_card_outlined,
                  color: AppColors.info,
                  title: 'SIM swap activation',
                  customer: 'David Tan',
                  address: '22 Marina Way, #14-08',
                  phone: '+65 9007 2231',
                  eta: '11:30 – 12:00',
                  priority: 'Medium',
                  priorityType: StatusType.warning,
                ),
              ]),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Faults & Tickets',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 32),
            sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
                _OrderCard(
                  id: 'TK-9942',
                  icon: Icons.report_problem_outlined,
                  color: AppColors.danger,
                  title: 'No internet · ONT offline',
                  customer: 'M. Rahman',
                  address: '88 Orchid Heights, #03-11',
                  phone: '+65 9412 8821',
                  eta: 'Today · 14:00',
                  priority: 'Urgent',
                  priorityType: StatusType.danger,
                ),
                _OrderCard(
                  id: 'TK-9947',
                  icon: Icons.signal_wifi_bad_rounded,
                  color: AppColors.warning,
                  title: 'Intermittent signal drops',
                  customer: 'Jenny Park',
                  address: '5 Riverside Loop, #21-05',
                  phone: '+65 8762 1100',
                  eta: 'Today · 15:30',
                  priority: 'Medium',
                  priorityType: StatusType.warning,
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 56, 20, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              UserAvatar(
                imageUrl: UserAvatar.technicianJordan,
                size: 44,
                radius: 12,
                ringColor: Colors.white.withOpacity(0.25),
                ringWidth: 1,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good morning',
                      style: TextStyle(
                        fontFamily: 'Geist',
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 12.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Jordan Reyes',
                      style: TextStyle(
                        fontFamily: 'Geist',
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.16),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _LiveDot(),
                    SizedBox(width: 6),
                    Text(
                      'On duty',
                      style: TextStyle(
                        fontFamily: 'Geist',
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            'Zone B North · 7 active tasks',
            style: TextStyle(
              fontFamily: 'Geist',
              color: Colors.white.withOpacity(0.85),
              fontSize: 12.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _LiveDot extends StatelessWidget {
  const _LiveDot();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: const BoxDecoration(
        color: AppColors.success,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _OrderCard extends StatefulWidget {
  final String id;
  final IconData icon;
  final Color color;
  final String title;
  final String customer;
  final String address;
  final String phone;
  final String eta;
  final String priority;
  final StatusType priorityType;

  const _OrderCard({
    required this.id,
    required this.icon,
    required this.color,
    required this.title,
    required this.customer,
    required this.address,
    required this.phone,
    required this.eta,
    required this.priority,
    required this.priorityType,
  });

  @override
  State<_OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<_OrderCard> {
  bool _active = false;
  bool _paused = false;
  Duration _elapsed = Duration.zero;
  Timer? _ticker;

  // Checklist state — visible while active.
  final List<_ChecklistItem> _checklist = [
    _ChecklistItem('Confirm customer onsite & ID'),
    _ChecklistItem('Run line-quality test'),
    _ChecklistItem('Install & power up CPE'),
    _ChecklistItem('Verify uplink speed > 90% plan'),
    _ChecklistItem('Hand over support docs'),
  ];

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  void _start() {
    setState(() {
      _active = true;
      _paused = false;
      _elapsed = Duration.zero;
    });
    _runTicker();
  }

  void _runTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      if (_paused) return;
      setState(() => _elapsed += const Duration(seconds: 1));
    });
  }

  void _togglePause() {
    setState(() => _paused = !_paused);
  }

  void _complete() {
    _ticker?.cancel();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.check_circle_rounded, color: AppColors.success),
            SizedBox(width: 8),
            Text(
              'Task completed',
              style: TextStyle(
                fontFamily: 'Geist',
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ],
        ),
        content: Text(
          'Logged ${_format(_elapsed)} on the job. The work order is closed.',
          style: const TextStyle(fontFamily: 'Geist', fontSize: 13.5),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {
                _active = false;
                _paused = false;
                _elapsed = Duration.zero;
                for (final c in _checklist) {
                  c.done = false;
                }
              });
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(0, 40),
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  String _format(Duration d) {
    String two(int v) => v.toString().padLeft(2, '0');
    final h = two(d.inHours);
    final m = two(d.inMinutes.remainder(60));
    final s = two(d.inSeconds.remainder(60));
    return '$h:$m:$s';
  }

  void _openMapsSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => _MapsSheet(
        title: widget.title,
        customer: widget.customer,
        address: widget.address,
        phone: widget.phone,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _active ? AppColors.primary : AppColors.border,
          width: _active ? 1.6 : 1,
        ),
      ),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        child: _active ? _buildActive() : _buildIdle(),
      ),
    );
  }

  Widget _buildIdle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: widget.color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(widget.icon, color: widget.color, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.id,
                        style: const TextStyle(
                          fontFamily: 'Geist',
                          color: AppColors.textMuted,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.4,
                        ),
                      ),
                      const SizedBox(width: 8),
                      StatusChip(
                          label: widget.priority,
                          type: widget.priorityType),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(widget.title,
                      style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _InfoRow(
            icon: Icons.person_outline_rounded,
            text: '${widget.customer} · ${widget.address}'),
        const SizedBox(height: 4),
        _InfoRow(icon: Icons.schedule_rounded, text: widget.eta),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _openMapsSheet,
                icon: const Icon(Icons.map_outlined, size: 16),
                label: const Text('Maps'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _start,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(44),
                ),
                icon: const Icon(Icons.play_arrow_rounded, size: 18),
                label: const Text('Start'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActive() {
    final done = _checklist.where((c) => c.done).length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.timer_outlined,
                    color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.18),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            _paused ? 'PAUSED' : 'IN PROGRESS',
                            style: const TextStyle(
                              fontFamily: 'Geist',
                              color: Colors.white,
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.6,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          widget.id,
                          style: TextStyle(
                            fontFamily: 'Geist',
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _format(_elapsed),
                      style: const TextStyle(
                        fontFamily: 'Geist',
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Maps',
                onPressed: _openMapsSheet,
                icon: const Icon(Icons.map_outlined, color: Colors.white),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(widget.title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 4),
        Text(
          '${widget.customer} · ${widget.address}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: Text(
                'Checklist · $done / ${_checklist.length}',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.textPrimary,
                    ),
              ),
            ),
            Text(
              '${(done / _checklist.length * 100).round()}%',
              style: const TextStyle(
                fontFamily: 'Geist',
                color: AppColors.primary,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: LinearProgressIndicator(
            value: done / _checklist.length,
            minHeight: 6,
            backgroundColor: AppColors.primarySoft,
            valueColor: const AlwaysStoppedAnimation(AppColors.primary),
          ),
        ),
        const SizedBox(height: 10),
        ..._checklist.map(
          (c) => InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () => setState(() => c.done = !c.done),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: c.done
                          ? AppColors.success
                          : Colors.transparent,
                      border: Border.all(
                        color: c.done
                            ? AppColors.success
                            : AppColors.border,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: c.done
                        ? const Icon(Icons.check,
                            color: Colors.white, size: 13)
                        : null,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      c.label,
                      style: TextStyle(
                        fontFamily: 'Geist',
                        color: c.done
                            ? AppColors.textMuted
                            : AppColors.textPrimary,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        decoration: c.done
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _togglePause,
                icon: Icon(
                  _paused
                      ? Icons.play_arrow_rounded
                      : Icons.pause_rounded,
                  size: 18,
                ),
                label: Text(_paused ? 'Resume' : 'Pause'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: done == _checklist.length ? _complete : null,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(44),
                  backgroundColor: AppColors.success,
                  disabledBackgroundColor:
                      AppColors.success.withOpacity(0.35),
                ),
                icon: const Icon(Icons.check_rounded, size: 18),
                label: const Text('Complete'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ChecklistItem {
  final String label;
  bool done = false;
  _ChecklistItem(this.label);
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.textMuted),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _MapsSheet extends StatelessWidget {
  final String title;
  final String customer;
  final String address;
  final String phone;

  const _MapsSheet({
    required this.title,
    required this.customer,
    required this.address,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Deployment site',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 2),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: AspectRatio(
                aspectRatio: 16 / 10,
                child: CustomPaint(
                  painter: _MapPreviewPainter(),
                ),
              ),
            ),
            const SizedBox(height: 14),
            _DetailRow(
              icon: Icons.place_outlined,
              tint: AppColors.primary,
              title: 'Address',
              value: address,
            ),
            const SizedBox(height: 10),
            _DetailRow(
              icon: Icons.person_outline_rounded,
              tint: AppColors.info,
              title: 'Customer',
              value: customer,
            ),
            const SizedBox(height: 10),
            _DetailRow(
              icon: Icons.phone_outlined,
              tint: AppColors.success,
              title: 'Phone',
              value: phone,
              trailing: const Icon(Icons.call_rounded,
                  color: AppColors.success, size: 20),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.copy_rounded, size: 16),
                    label: const Text('Copy address'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.directions_rounded, size: 18),
                    label: const Text('Open in Maps'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final Color tint;
  final String title;
  final String value;
  final Widget? trailing;

  const _DetailRow({
    required this.icon,
    required this.tint,
    required this.title,
    required this.value,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: tint.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: tint, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Geist',
                    color: AppColors.textMuted,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontFamily: 'Geist',
                    color: AppColors.textPrimary,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

class _MapPreviewPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = const Color(0xFFEFF3FB);
    canvas.drawRect(Offset.zero & size, bg);

    final grid = Paint()
      ..color = const Color(0xFFDDE3F0)
      ..strokeWidth = 0.8;

    const step = 32.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    // Road
    final road = Paint()
      ..color = Colors.white
      ..strokeWidth = 14;
    final path = Path()
      ..moveTo(0, size.height * 0.72)
      ..quadraticBezierTo(size.width * 0.3, size.height * 0.4,
          size.width * 0.55, size.height * 0.55)
      ..quadraticBezierTo(size.width * 0.78, size.height * 0.68,
          size.width, size.height * 0.42);
    canvas.drawPath(path, road);

    final roadStripe = Paint()
      ..color = const Color(0xFFFEC97A)
      ..strokeWidth = 2;
    canvas.drawPath(path, roadStripe);

    // Secondary road
    final road2 = Paint()
      ..color = Colors.white
      ..strokeWidth = 10;
    canvas.drawLine(
      Offset(size.width * 0.18, 0),
      Offset(size.width * 0.32, size.height),
      road2,
    );

    // Pin
    final pinX = size.width * 0.6;
    final pinY = size.height * 0.5;
    final pinShadow = Paint()..color = Colors.black.withOpacity(0.18);
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(pinX, pinY + 18), width: 22, height: 6),
      pinShadow,
    );
    final pinBody = Paint()..color = const Color(0xFF1E3A8A);
    canvas.drawCircle(Offset(pinX, pinY), 12, pinBody);
    final pinDot = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(pinX, pinY), 4, pinDot);

    // Pulse ring
    final ring = Paint()
      ..style = PaintingStyle.stroke
      ..color = const Color(0xFF1E3A8A).withOpacity(0.25)
      ..strokeWidth = 2;
    canvas.drawCircle(Offset(pinX, pinY), 24, ring);
  }

  @override
  bool shouldRepaint(covariant _MapPreviewPainter old) => false;
}
