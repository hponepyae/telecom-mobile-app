import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/status_chip.dart';
import '../../../../shared/widgets/user_avatar.dart';

class HomeDashboardTab extends StatefulWidget {
  const HomeDashboardTab({super.key});

  @override
  State<HomeDashboardTab> createState() => _HomeDashboardTabState();
}

class _HomeDashboardTabState extends State<HomeDashboardTab> {
  bool _onDuty = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _DutyHeader(
              onDuty: _onDuty,
              onToggle: (v) => setState(() => _onDuty = v),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(16, 18, 16, 12),
            sliver: SliverToBoxAdapter(child: _StatsRow()),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    child: _SectionLabel(text: 'Your Current Assignments'),
                  ),
                  Text(
                    '2 active',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: const [
                  _HomeTicketCard(
                    id: 'TK-9942',
                    icon: Icons.report_problem_rounded,
                    iconColor: AppColors.danger,
                    title: 'No internet Â· ONT offline',
                    customer: 'M. Rahman',
                    address: '88 Orchid Heights, #03-11',
                    timeSlot: 'Today Â· 14:00 â€“ 15:00',
                    initialStatus: 'Pending',
                  ),
                  SizedBox(height: 10),
                  _HomeTicketCard(
                    id: 'WO-7821',
                    icon: Icons.router_rounded,
                    iconColor: AppColors.primary,
                    title: 'Fiber installation Â· 500 Mbps',
                    customer: 'Sarah Lim',
                    address: '14 Cedar Ave, Block B, #08-22',
                    timeSlot: 'Today Â· 09:30 â€“ 11:00',
                    initialStatus: 'Pending',
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            sliver: SliverToBoxAdapter(
              child: _SectionLabel(text: 'Quick Tools'),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 32),
            sliver: SliverToBoxAdapter(child: _QuickActionsGrid()),
          ),
        ],
      ),
    );
  }
}

// â”€â”€ Shift status + duty toggle â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
class _DutyHeader extends StatelessWidget {
  final bool onDuty;
  final ValueChanged<bool> onToggle;

  const _DutyHeader({required this.onDuty, required this.onToggle});

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
                      onDuty ? 'Good morning' : 'Welcome back',
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
              _DutyToggle(value: onDuty, onChanged: onToggle),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            onDuty
                ? 'Zone B North Â· 7 active tasks'
                : 'Off duty Â· Tap toggle to resume',
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

class _DutyToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  const _DutyToggle({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: value
              ? Colors.white.withOpacity(0.18)
              : Colors.white.withOpacity(0.10),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: Colors.white.withOpacity(value ? 0.30 : 0.18),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: value
                    ? AppColors.success
                    : Colors.white.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              value ? 'On Duty' : 'Off Duty',
              style: const TextStyle(
                fontFamily: 'Geist',
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// â”€â”€ 3-column stats row â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: _StatTile(
            icon: Icons.pending_actions_rounded,
            color: AppColors.warning,
            label: 'Pending Tasks',
            value: '5',
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _StatTile(
            icon: Icons.autorenew_rounded,
            color: AppColors.info,
            label: 'In Progress',
            value: '2',
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _StatTile(
            icon: Icons.task_alt_rounded,
            color: AppColors.success,
            label: 'Completed Today',
            value: '4',
          ),
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String value;

  const _StatTile({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Geist',
              color: AppColors.textMuted,
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Geist',
              color: AppColors.textPrimary,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.titleLarge);
  }
}

// â”€â”€ Home Ticket Card (matches Tickets-page card style with inline status) â”€
class _HomeTicketCard extends StatefulWidget {
  final String id;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String customer;
  final String address;
  final String timeSlot;
  final String initialStatus;

  const _HomeTicketCard({
    required this.id,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.customer,
    required this.address,
    required this.timeSlot,
    required this.initialStatus,
  });

  @override
  State<_HomeTicketCard> createState() => _HomeTicketCardState();
}

class _HomeTicketCardState extends State<_HomeTicketCard> {
  late String _status;

  @override
  void initState() {
    super.initState();
    _status = widget.initialStatus;
  }

  StatusType _statusType(String s) {
    switch (s) {
      case 'Pending':
        return StatusType.warning;
      case 'In Progress':
        return StatusType.info;
      case 'Resolved':
        return StatusType.success;
      default:
        return StatusType.neutral;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: widget.iconColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(widget.icon, color: widget.iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    const SizedBox(height: 4),
                    Text(widget.title,
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              StatusChip(
                label: _status,
                type: _statusType(_status),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.person_outline_rounded,
                  size: 14, color: AppColors.textMuted),
              const SizedBox(width: 4),
              Text(widget.customer,
                  style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(width: 10),
              const Icon(Icons.place_outlined,
                  size: 14, color: AppColors.textMuted),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  widget.address,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.schedule_rounded,
                  size: 14, color: AppColors.textMuted),
              const SizedBox(width: 4),
              Text(widget.timeSlot,
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _StatusBtn(
                  label: 'Pending',
                  color: AppColors.warning,
                  selected: _status == 'Pending',
                  onTap: () => setState(() => _status = 'Pending'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _StatusBtn(
                  label: 'In Progress',
                  color: AppColors.info,
                  selected: _status == 'In Progress',
                  onTap: () => setState(() => _status = 'In Progress'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _StatusBtn(
                  label: 'Resolved',
                  color: AppColors.success,
                  selected: _status == 'Resolved',
                  onTap: () => setState(() => _status = 'Resolved'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusBtn extends StatelessWidget {
  final String label;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  const _StatusBtn({
    required this.label,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? color.withOpacity(0.16) : color.withOpacity(0.08),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          height: 38,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selected ? color : color.withOpacity(0.4),
              width: 1.2,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Geist',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}

// â”€â”€ Quick Actions Grid â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
class _QuickActionsGrid extends StatelessWidget {
  const _QuickActionsGrid();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: _ActionButton(
              icon: Icons.qr_code_scanner_rounded,
              color: AppColors.primary,
              label: 'Scan Device',
              sublabel: 'Barcode',
              onTap: () => _toast(context, 'Opening barcode scannerâ€¦'),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _ActionButton(
              icon: Icons.inventory_2_rounded,
              color: AppColors.info,
              label: 'My Stock',
              sublabel: 'Equipment',
              onTap: () => _toast(context, 'Loading equipment stockâ€¦'),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _ActionButton(
              icon: Icons.network_check_rounded,
              color: AppColors.success,
              label: 'Signal Test',
              sublabel: 'Run diagnostics',
              onTap: () => _toast(context, 'Running line signal testâ€¦'),
            ),
          ),
        ],
      ),
    );
  }

  void _toast(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: Text(msg, style: const TextStyle(fontFamily: 'Geist')),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String sublabel;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.color,
    required this.label,
    required this.sublabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.background,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Geist',
                  color: AppColors.textPrimary,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                sublabel,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Geist',
                  color: AppColors.textMuted,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
