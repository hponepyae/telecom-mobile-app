import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/status_chip.dart';
import '../../../../shared/widgets/user_avatar.dart';

class TechnicianProfileTab extends StatelessWidget {
  const TechnicianProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _Hero()),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16, 18, 16, 32),
            sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
                _SectionTitle(title: 'Employee Details'),
                SizedBox(height: 10),
                _EmployeeDetailsCard(),
                SizedBox(height: 18),
                _SectionTitle(title: 'Assignment Zones'),
                SizedBox(height: 10),
                _ZonesCard(),
                SizedBox(height: 18),
                _SectionTitle(title: 'This Month'),
                SizedBox(height: 10),
                _MonthMetrics(),
                SizedBox(height: 18),
                _SectionTitle(title: 'Payroll Summary'),
                SizedBox(height: 10),
                _PayrollCard(),
                SizedBox(height: 18),
                _SectionTitle(title: 'Certifications'),
                SizedBox(height: 10),
                _CertificationsCard(),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero();

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
        children: [
          Row(
            children: [
              _AvatarPlaceholder(),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Jordan Reyes',
                      style: TextStyle(
                        fontFamily: 'Geist',
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'technician@telecom.com',
                      style: TextStyle(
                        fontFamily: 'Geist',
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 12.5,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.14),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  tooltip: 'Edit profile',
                  onPressed: () {},
                  icon: const Icon(Icons.edit_outlined,
                      color: Colors.white, size: 18),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              _HeroStat(label: 'Employee ID', value: 'TC-4082'),
              _HeroStatDivider(),
              _HeroStat(label: 'Role', value: 'Field Engineer II'),
              _HeroStatDivider(),
              _HeroStat(label: 'Status', value: 'On Duty'),
            ],
          ),
        ],
      ),
    );
  }
}

class _AvatarPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UserAvatar(
      imageUrl: UserAvatar.technicianJordan,
      size: 72,
      radius: 22,
      ringColor: Colors.white.withOpacity(0.35),
      ringWidth: 2,
      showCameraBadge: true,
      onCameraTap: () {},
    );
  }
}

class _HeroStat extends StatelessWidget {
  final String label;
  final String value;
  const _HeroStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Geist',
              color: Colors.white,
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Geist',
              color: Colors.white.withOpacity(0.7),
              fontSize: 10.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroStatDivider extends StatelessWidget {
  const _HeroStatDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      width: 1,
      color: Colors.white.withOpacity(0.2),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Geist',
        color: AppColors.textPrimary,
        fontSize: 15,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.2,
      ),
    );
  }
}

class _CardWrap extends StatelessWidget {
  final Widget child;
  const _CardWrap({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: child,
    );
  }
}

class _Field extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;
  final bool last;
  const _Field({
    required this.label,
    required this.value,
    this.icon,
    this.last = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 16, color: AppColors.textMuted),
                const SizedBox(width: 10),
              ],
              Expanded(
                flex: 4,
                child: Text(
                  label,
                  style: const TextStyle(
                    fontFamily: 'Geist',
                    color: AppColors.textMuted,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Text(
                  value,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontFamily: 'Geist',
                    color: AppColors.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (!last) const Divider(height: 1, color: AppColors.divider),
      ],
    );
  }
}

class _EmployeeDetailsCard extends StatelessWidget {
  const _EmployeeDetailsCard();
  @override
  Widget build(BuildContext context) {
    return const _CardWrap(
      child: Column(
        children: [
          _Field(
            icon: Icons.fingerprint_rounded,
            label: 'Employee ID',
            value: 'TC-4082',
          ),
          _Field(
            icon: Icons.badge_outlined,
            label: 'Role',
            value: 'Field Engineer · Level II',
          ),
          _Field(
            icon: Icons.event_available_rounded,
            label: 'Joined',
            value: 'Jul 18, 2021',
          ),
          _Field(
            icon: Icons.phone_outlined,
            label: 'Work Phone',
            value: '+65 9012 4082',
          ),
          _Field(
            icon: Icons.mail_outline_rounded,
            label: 'Email',
            value: 'jordan.reyes@telecom.com',
            last: true,
          ),
        ],
      ),
    );
  }
}

class _ZonesCard extends StatelessWidget {
  const _ZonesCard();
  @override
  Widget build(BuildContext context) {
    Widget chip(String label, {bool primary = false}) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: primary
              ? AppColors.primary
              : AppColors.primarySoft,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Geist',
            color: primary ? Colors.white : AppColors.primary,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

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
            children: [
              const Icon(Icons.place_outlined,
                  color: AppColors.primary, size: 18),
              const SizedBox(width: 8),
              Text(
                'Primary · Zone B North',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Covers 14 km² · ~430 active subscribers',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              chip('Zone B North', primary: true),
              chip('Zone B South'),
              chip('Zone C West'),
              chip('Emergency cover · A'),
            ],
          ),
        ],
      ),
    );
  }
}

class _MonthMetrics extends StatelessWidget {
  const _MonthMetrics();
  @override
  Widget build(BuildContext context) {
    Widget tile(String value, String label, IconData icon, Color color) {
      return Expanded(
        child: Container(
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
                child: Icon(icon, size: 16, color: color),
              ),
              const SizedBox(height: 10),
              Text(
                value,
                style: const TextStyle(
                  fontFamily: 'Geist',
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Geist',
                  color: AppColors.textMuted,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Row(
      children: [
        tile('38', 'Resolved', Icons.task_alt_rounded, AppColors.success),
        const SizedBox(width: 10),
        tile('4.9', 'CSAT score', Icons.star_rounded, AppColors.warning),
        const SizedBox(width: 10),
        tile('98%', 'On-time SLA', Icons.timer_outlined, AppColors.info),
      ],
    );
  }
}

class _PayrollCard extends StatelessWidget {
  const _PayrollCard();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.payments_rounded, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                'Current pay cycle',
                style: TextStyle(
                  fontFamily: 'Geist',
                  color: Colors.white.withOpacity(0.85),
                  fontSize: 12.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            '3,420,000 MMK',
            style: TextStyle(
              fontFamily: 'Geist',
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'May 01 – May 31 · Payable on Jun 05',
            style: TextStyle(
              fontFamily: 'Geist',
              color: Colors.white.withOpacity(0.85),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.14),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _miniStat('Base', '2,800,000 MMK', Colors.white),
                ),
                Container(
                    width: 1, height: 28, color: Colors.white.withOpacity(0.25)),
                Expanded(
                  child: _miniStat('Overtime', '420,000 MMK', Colors.white),
                ),
                Container(
                    width: 1, height: 28, color: Colors.white.withOpacity(0.25)),
                Expanded(
                  child: _miniStat('Bonus', '200,000 MMK', Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _miniStat(String label, String value, Color textColor) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Geist',
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Geist',
            color: textColor.withOpacity(0.75),
            fontSize: 10.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _CertificationsCard extends StatelessWidget {
  const _CertificationsCard();
  @override
  Widget build(BuildContext context) {
    Widget cert(IconData icon, String title, String expiry, StatusType type) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppColors.primarySoft,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.primary, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 2),
                  Text(expiry,
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            StatusChip(label: type == StatusType.success ? 'Active' : 'Renew', type: type),
          ],
        ),
      );
    }

    return _CardWrap(
      child: Column(
        children: [
          cert(Icons.cable_rounded, 'Fiber Splicing · L2',
              'Expires Mar 2027', StatusType.success),
          const Divider(height: 1, color: AppColors.divider),
          cert(Icons.electrical_services_rounded, 'High-voltage Safety',
              'Expires Sep 2026', StatusType.success),
          const Divider(height: 1, color: AppColors.divider),
          cert(Icons.health_and_safety_outlined, 'Workplace First-Aid',
              'Expires Jul 2026', StatusType.warning),
        ],
      ),
    );
  }
}
