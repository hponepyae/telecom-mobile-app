import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/user_avatar.dart';
import '../pages/failure_payment_page.dart';
import '../pages/kyc_verification_page.dart';
import '../pages/line_failure_report_page.dart';
import '../pages/online_payment_page.dart';
import '../pages/payment_history_page.dart';
import '../pages/product_info_page.dart';
import '../pages/wifi_package_page.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  void _go(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: _GreetingHeader()),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 22, 16, 12),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Text(
                    'Quick Services',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  Text(
                    '6 shortcuts',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.92,
              ),
              delegate: SliverChildListDelegate.fixed([
                _ServiceCard(
                  icon: Icons.credit_card_rounded,
                  color: AppColors.primary,
                  label: 'Online\nPayment',
                  onTap: () => _go(context, const OnlinePaymentPage()),
                ),
                _ServiceCard(
                  icon: Icons.verified_user_outlined,
                  color: AppColors.info,
                  label: 'KYC\nVerification',
                  onTap: () => _go(context, const KycVerificationPage()),
                ),
                _ServiceCard(
                  icon: Icons.error_outline_rounded,
                  color: AppColors.danger,
                  label: 'Failure\nPayment',
                  onTap: () => _go(context, const FailurePaymentPage()),
                ),
                _ServiceCard(
                  icon: Icons.inventory_2_outlined,
                  color: AppColors.success,
                  label: 'Active\nService Info',
                  onTap: () => _go(context, const ProductInfoPage()),
                ),
                _ServiceCard(
                  icon: Icons.build_circle_outlined,
                  color: AppColors.warning,
                  label: 'Line Failure\nReport',
                  onTap: () => _go(context, const LineFailureReportPage()),
                ),
                _ServiceCard(
                  icon: Icons.wifi_rounded,
                  color: const Color(0xFF7C3AED),
                  label: 'WiFi\nPackage',
                  onTap: () => _go(context, const WifiPackagePage()),
                ),
              ]),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account Snapshot',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  const _AccountSnapshotCard(),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Payment History',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      TextButton(
                        onPressed: () =>
                            _go(context, const PaymentHistoryPage()),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 4),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'See More',
                          style: TextStyle(
                            fontFamily: 'Geist',
                            color: AppColors.primary,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const _RecentPaymentList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GreetingHeader extends StatelessWidget {
  const _GreetingHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 56, 20, 28),
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
                imageUrl: UserAvatar.customerAlex,
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
                      'Alex Chen',
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
              _NotificationButton(),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            'Account ID · 7841-2298',
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

class _NotificationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.14),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          IconButton(
            onPressed: () => _showNotifications(context),
            icon: const Icon(
              Icons.notifications_outlined,
              color: Colors.white,
              size: 20,
            ),
            tooltip: 'Notifications',
          ),
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.danger,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _showNotifications(BuildContext context) {
  showGeneralDialog<void>(
    context: context,
    barrierColor: Colors.black.withOpacity(0.25),
    barrierDismissible: true,
    barrierLabel: 'Notifications',
    transitionDuration: const Duration(milliseconds: 180),
    pageBuilder: (ctx, a1, a2) => const SizedBox.shrink(),
    transitionBuilder: (ctx, anim, sec, child) {
      final scale = Tween<double>(begin: 0.94, end: 1).animate(
        CurvedAnimation(parent: anim, curve: Curves.easeOutCubic),
      );
      return FadeTransition(
        opacity: anim,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 56, 12, 12),
            child: Align(
              alignment: Alignment.topRight,
              child: ScaleTransition(
                alignment: Alignment.topRight,
                scale: scale,
                child: const _NotificationPopover(),
              ),
            ),
          ),
        ),
      );
    },
  );
}

class _NotificationPopover extends StatelessWidget {
  const _NotificationPopover();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 24;
    return Material(
      color: Colors.transparent,
      child: Container(
        width: width,
        constraints: const BoxConstraints(maxWidth: 380),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 30,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 8, 8),
              child: Row(
                children: [
                  Text(
                    'Notifications',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Mark all read',
                      style: TextStyle(
                        fontFamily: 'Geist',
                        color: AppColors.primary,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.divider),
            const _NotifItem(
              icon: Icons.event_outlined,
              color: AppColors.warning,
              title: 'Invoice due in 10 days',
              body: 'Your May invoice of 48,900 MMK is due May 28, 2026.',
              time: '2h ago',
              unread: true,
            ),
            const Divider(
                height: 1, color: AppColors.divider, indent: 60),
            const _NotifItem(
              icon: Icons.check_circle_outline,
              color: AppColors.success,
              title: 'KYC document received',
              body: 'Your NRIC scan was approved.',
              time: 'Yesterday',
              unread: true,
            ),
            const Divider(
                height: 1, color: AppColors.divider, indent: 60),
            const _NotifItem(
              icon: Icons.build_circle_outlined,
              color: AppColors.primary,
              title: 'Network maintenance scheduled',
              body: 'Brief outage on May 22, 02:00 – 03:00 SGT.',
              time: '2 days ago',
              unread: false,
            ),
            const Divider(height: 1, color: AppColors.divider),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'See all notifications',
                  style: TextStyle(
                    fontFamily: 'Geist',
                    color: AppColors.primary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotifItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String body;
  final String time;
  final bool unread;

  const _NotifItem({
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
    required this.time,
    required this.unread,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
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
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    if (unread)
                      Container(
                        margin: const EdgeInsets.only(left: 6, top: 4),
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  body,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 4),
                Text(
                  time,
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
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;

  const _ServiceCard({
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(height: 10),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AccountSnapshotCard extends StatelessWidget {
  const _AccountSnapshotCard();

  @override
  Widget build(BuildContext context) {
    Widget metric(IconData icon, String label, String value, Color color) {
      return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 14, color: color),
                const SizedBox(width: 4),
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
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'Geist',
                color: AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          metric(Icons.cloud_download_outlined, 'Data', '30,720 MB',
              AppColors.primary),
          Container(width: 1, height: 30, color: AppColors.divider),
          const SizedBox(width: 10),
          metric(Icons.check_circle_outline, 'Services', '3 active',
              AppColors.success),
          Container(width: 1, height: 30, color: AppColors.divider),
          const SizedBox(width: 10),
          metric(Icons.event_available_outlined, 'Days Left', '12 days',
              AppColors.warning),
        ],
      ),
    );
  }
}

class _RecentPaymentList extends StatelessWidget {
  const _RecentPaymentList();

  @override
  Widget build(BuildContext context) {
    Widget row(IconData icon, Color color, String title, String time,
        String amount) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
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
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 2),
                  Text(time, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            Text(
              amount,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          row(Icons.check_circle_rounded, AppColors.success,
              'April invoice paid', 'May 02 · Apple Pay', '–48,900 MMK'),
          const Divider(height: 1, color: AppColors.divider),
          row(Icons.add_circle_rounded, AppColors.info, 'Data top-up',
              'Apr 28 · KBZPay', '–30,000 MMK'),
          const Divider(height: 1, color: AppColors.divider),
          row(Icons.dataset_outlined, AppColors.primary, 'Add-on · 5 GB',
              'Apr 22 · AYAPay', '–6,000 MMK'),
        ],
      ),
    );
  }
}
