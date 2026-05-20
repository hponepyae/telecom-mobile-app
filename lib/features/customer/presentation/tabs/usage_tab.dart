import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/circular_gauge.dart';
import '../../../../shared/widgets/status_chip.dart';

class CustomerUsageTab extends StatefulWidget {
  const CustomerUsageTab({super.key});

  @override
  State<CustomerUsageTab> createState() => _CustomerUsageTabState();
}

class _CustomerUsageTabState extends State<CustomerUsageTab> {
  int _rangeIndex = 1; // 0=Today, 1=Week, 2=Month

  static const _ranges = ['Today', 'This Week', 'This Month'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: _UsageHeader()),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 32),
            sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
                _RangeSwitcher(
                  ranges: _ranges,
                  index: _rangeIndex,
                  onChanged: (i) => setState(() => _rangeIndex = i),
                ),
                const SizedBox(height: 18),
                const _DataUsageCard(),
                const SizedBox(height: 18),
                const _SectionTitle(title: 'Usage Breakdown'),
                const SizedBox(height: 10),
                const _BreakdownCard(),
                const SizedBox(height: 18),
                const _SectionTitle(title: 'Service Quota'),
                const SizedBox(height: 10),
                const _QuotaList(),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _UsageHeader extends StatelessWidget {
  const _UsageHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 56, 20, 22),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.25)),
                ),
                child: const Icon(Icons.data_usage_rounded,
                    color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                'My Usage',
                style: TextStyle(
                  fontFamily: 'Geist',
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.16),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: Colors.white.withOpacity(0.22)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Live',
                      style: TextStyle(
                        fontFamily: 'Geist',
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Track your data, calls, and quota across all services.',
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

class _RangeSwitcher extends StatelessWidget {
  final List<String> ranges;
  final int index;
  final ValueChanged<int> onChanged;
  const _RangeSwitcher({
    required this.ranges,
    required this.index,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: List.generate(ranges.length, (i) {
          final active = i == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(vertical: 9),
                decoration: BoxDecoration(
                  color: active ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(9),
                ),
                alignment: Alignment.center,
                child: Text(
                  ranges[i],
                  style: TextStyle(
                    fontFamily: 'Geist',
                    color: active ? Colors.white : AppColors.textSecondary,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _DataUsageCard extends StatelessWidget {
  const _DataUsageCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.wifi_rounded,
                  color: AppColors.primary, size: 18),
              const SizedBox(width: 8),
              Text('Mobile Data Usage',
                  style: Theme.of(context).textTheme.titleMedium),
              const Spacer(),
              const StatusChip(label: 'Normal', type: StatusType.success),
            ],
          ),
          const SizedBox(height: 16),
          const Row(
            children: [
              CircularGauge(
                value: 0.54,
                centerLabel: 'used',
                centerValue: '54%',
                size: 130,
                strokeWidth: 12,
              ),
              SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _MetricLine(
                        label: 'Used',
                        value: '16.2 GB',
                        color: AppColors.primary),
                    SizedBox(height: 10),
                    _MetricLine(
                        label: 'Remaining',
                        value: '13.8 GB',
                        color: AppColors.info),
                    SizedBox(height: 10),
                    _MetricLine(
                        label: 'Total Plan',
                        value: '30 GB',
                        color: AppColors.textSecondary),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetricLine extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _MetricLine({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Geist',
            color: AppColors.textMuted,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Geist',
            color: AppColors.textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
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

class _BreakdownCard extends StatelessWidget {
  const _BreakdownCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: const Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _StatTile(
                  icon: Icons.download_rounded,
                  color: AppColors.primary,
                  label: 'Download',
                  value: '12.4',
                  unit: 'GB',
                  trend: '+8%',
                  trendPositive: true,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _StatTile(
                  icon: Icons.upload_rounded,
                  color: AppColors.info,
                  label: 'Upload',
                  value: '3.8',
                  unit: 'GB',
                  trend: '+2%',
                  trendPositive: true,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _StatTile(
                  icon: Icons.call_rounded,
                  color: AppColors.success,
                  label: 'Calls',
                  value: '284',
                  unit: 'min',
                  trend: 'Unlimited',
                  trendPositive: true,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _StatTile(
                  icon: Icons.sms_rounded,
                  color: AppColors.warning,
                  label: 'SMS',
                  value: '47',
                  unit: 'sent',
                  trend: 'Unlimited',
                  trendPositive: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String value;
  final String unit;
  final String trend;
  final bool trendPositive;

  const _StatTile({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
    required this.unit,
    required this.trend,
    required this.trendPositive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Icon(icon, size: 13, color: color),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Geist',
                  color: AppColors.textMuted,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontFamily: 'Geist',
                  color: AppColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  unit,
                  style: const TextStyle(
                    fontFamily: 'Geist',
                    color: AppColors.textMuted,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            trend,
            style: TextStyle(
              fontFamily: 'Geist',
              color: trendPositive ? AppColors.success : AppColors.danger,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuotaList extends StatelessWidget {
  const _QuotaList();

  @override
  Widget build(BuildContext context) {
    const items = [
      _QuotaRow(
        icon: Icons.wifi_rounded,
        color: AppColors.primary,
        label: 'Fiber Internet',
        used: 0.54,
        usedLabel: '16.2 / 30 GB',
      ),
      _QuotaRow(
        icon: Icons.call_rounded,
        color: AppColors.success,
        label: 'Voice Minutes',
        used: 0.28,
        usedLabel: '284 / 1,000 min',
      ),
      _QuotaRow(
        icon: Icons.live_tv_rounded,
        color: AppColors.warning,
        label: 'TV Streaming',
        used: 0.71,
        usedLabel: '71 / 100 GB',
        last: true,
      ),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(children: items),
    );
  }
}

class _QuotaRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final double used;
  final String usedLabel;
  final bool last;
  const _QuotaRow({
    required this.icon,
    required this.color,
    required this.label,
    required this.used,
    required this.usedLabel,
    this.last = false,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (used * 100).round();
    final critical = used > 0.85;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
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
                    Row(
                      children: [
                        Expanded(
                          child: Text(label,
                              style:
                                  Theme.of(context).textTheme.titleMedium),
                        ),
                        Text(
                          '$percent%',
                          style: TextStyle(
                            fontFamily: 'Geist',
                            color: critical ? AppColors.danger : color,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(99),
                      child: LinearProgressIndicator(
                        value: used,
                        minHeight: 6,
                        backgroundColor: AppColors.primarySoft,
                        valueColor: AlwaysStoppedAnimation(
                          critical ? AppColors.danger : color,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      usedLabel,
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
        ),
        if (!last) const Divider(height: 1, color: AppColors.divider),
      ],
    );
  }
}
