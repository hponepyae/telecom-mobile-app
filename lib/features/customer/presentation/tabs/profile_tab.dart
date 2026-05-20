import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/status_chip.dart';
import '../../../../shared/widgets/user_avatar.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _ProfileHero()),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16, 18, 16, 32),
            sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
                _SectionTitle(title: 'Account Summary'),
                SizedBox(height: 10),
                _AccountSummaryCard(),
                SizedBox(height: 18),
                _SectionTitle(title: 'Personal Details'),
                SizedBox(height: 10),
                _PersonalDetailsCard(),
                SizedBox(height: 18),
                _SectionTitle(title: 'Contact Information'),
                SizedBox(height: 10),
                _ContactCard(),
                SizedBox(height: 18),
                _SectionTitle(title: 'Active Service IDs'),
                SizedBox(height: 10),
                _ServiceIdsCard(),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileHero extends StatelessWidget {
  const _ProfileHero();

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
                      'Alex Chen',
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
                      'customer@telecom.com',
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
              _HeroStat(label: 'Account ID', value: '7841-2298'),
              _HeroStatDivider(),
              _HeroStat(label: 'Member since', value: 'Mar 2022'),
              _HeroStatDivider(),
              _HeroStat(label: 'Services', value: '3 active'),
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
      imageUrl: UserAvatar.customerAlex,
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
              fontSize: 14,
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

class _AccountSummaryCard extends StatelessWidget {
  const _AccountSummaryCard();

  @override
  Widget build(BuildContext context) {
    return const _CardWrap(
      child: Column(
        children: [
          _Field(
            icon: Icons.fingerprint_rounded,
            label: 'Account ID',
            value: '7841-2298',
          ),
          _Field(
            icon: Icons.confirmation_number_outlined,
            label: 'Service ID',
            value: 'WF-A7k2-9301',
          ),
          _Field(
            icon: Icons.workspace_premium_rounded,
            label: 'Account Type',
            value: 'Postpaid · Gold',
          ),
          _Field(
            icon: Icons.event_available_rounded,
            label: 'Registration Date',
            value: 'Mar 14, 2022',
          ),
          _Field(
            icon: Icons.verified_user_outlined,
            label: 'Status',
            value: 'Active',
            last: true,
          ),
        ],
      ),
    );
  }
}

class _PersonalDetailsCard extends StatelessWidget {
  const _PersonalDetailsCard();

  @override
  Widget build(BuildContext context) {
    return const _CardWrap(
      child: Column(
        children: [
          _Field(label: 'Full Name', value: 'Alex Chen Wei Liang'),
          _Field(label: 'Date of Birth', value: '08 Aug 1992'),
          _Field(label: 'Gender', value: 'Male'),
          _Field(label: 'Nationality', value: 'Singaporean'),
          _Field(
            label: 'NRIC / ID',
            value: 'S••••562J',
            last: true,
          ),
        ],
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard();

  @override
  Widget build(BuildContext context) {
    return const _CardWrap(
      child: Column(
        children: [
          _Field(
            icon: Icons.mail_outline_rounded,
            label: 'Email',
            value: 'customer@telecom.com',
          ),
          _Field(
            icon: Icons.phone_outlined,
            label: 'Mobile',
            value: '+65 8123 4567',
          ),
          _Field(
            icon: Icons.home_outlined,
            label: 'Billing Address',
            value: '14 Cedar Ave, #08-22',
          ),
          _Field(
            icon: Icons.language_rounded,
            label: 'Preferred Language',
            value: 'English',
            last: true,
          ),
        ],
      ),
    );
  }
}

class _ServiceIdsCard extends StatelessWidget {
  const _ServiceIdsCard();

  @override
  Widget build(BuildContext context) {
    Widget row({
      required IconData icon,
      required Color color,
      required String title,
      required String id,
      required String plan,
      bool last = false,
    }) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: color, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style:
                              Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 2),
                      Text(
                        '$id · $plan',
                        style:
                            Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const StatusChip(label: 'Active', type: StatusType.success),
              ],
            ),
          ),
          if (!last) const Divider(height: 1, color: AppColors.divider),
        ],
      );
    }

    return _CardWrap(
      child: Column(
        children: [
          row(
            icon: Icons.wifi_rounded,
            color: AppColors.primary,
            title: 'Fiber Internet',
            id: 'FB-500-2298',
            plan: '500 Mbps',
          ),
          row(
            icon: Icons.smartphone_rounded,
            color: AppColors.info,
            title: 'Mobile Postpaid',
            id: 'MS-65812345',
            plan: '30 GB',
          ),
          row(
            icon: Icons.live_tv_rounded,
            color: AppColors.warning,
            title: 'TV Streaming',
            id: 'TV-PREM-7841',
            plan: 'Premium 4K',
            last: true,
          ),
        ],
      ),
    );
  }
}

