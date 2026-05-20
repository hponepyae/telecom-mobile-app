import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/circular_gauge.dart';
import '../../../../shared/widgets/status_chip.dart';

class UsageTab extends StatefulWidget {
  const UsageTab({super.key});

  @override
  State<UsageTab> createState() => _UsageTabState();
}

class _UsageTabState extends State<UsageTab> {
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
                const _TrafficCard(),
                const SizedBox(height: 18),
                const _SectionTitle(title: 'Throughput Breakdown'),
                const SizedBox(height: 10),
                const _ThroughputCard(),
                const SizedBox(height: 18),
                const _SectionTitle(title: 'Service Quota Status'),
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
                  border:
                      Border.all(color: Colors.white.withOpacity(0.25)),
                ),
                child: const Icon(Icons.insights_rounded,
                    color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                'Usage Tracker',
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
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 5),
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
            'Monitor traffic, quota, and subscribers across Zone B.',
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

class _TrafficCard extends StatelessWidget {
  const _TrafficCard();

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
              const Icon(Icons.cloud_sync_rounded,
                  color: AppColors.primary, size: 18),
              const SizedBox(width: 8),
              Text('Total Bandwidth Used',
                  style: Theme.of(context).textTheme.titleMedium),
              const Spacer(),
              const StatusChip(label: 'Healthy', type: StatusType.success),
            ],
          ),
          const SizedBox(height: 16),
          const Row(
            children: [
              CircularGauge(
                value: 0.62,
                centerLabel: 'of quota',
                centerValue: '62%',
                size: 130,
                strokeWidth: 12,
              ),
              SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _MetricLine(
                        label: 'Consumed',
                        value: '4.83 TB',
                        color: AppColors.primary),
                    SizedBox(height: 10),
                    _MetricLine(
                        label: 'Remaining',
                        value: '2.97 TB',
                        color: AppColors.info),
                    SizedBox(height: 10),
                    _MetricLine(
                        label: 'Allocation',
                        value: '7.80 TB',
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

class _ThroughputCard extends StatelessWidget {
  const _ThroughputCard();

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
                child: _ThroughputTile(
                  icon: Icons.south_rounded,
                  color: AppColors.primary,
                  label: 'Downlink',
                  value: '842',
                  unit: 'Mbps avg',
                  trend: '+12%',
                  trendPositive: true,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _ThroughputTile(
                  icon: Icons.north_rounded,
                  color: AppColors.info,
                  label: 'Uplink',
                  value: '186',
                  unit: 'Mbps avg',
                  trend: '+4%',
                  trendPositive: true,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _ThroughputTile(
                  icon: Icons.bolt_rounded,
                  color: AppColors.warning,
                  label: 'Peak',
                  value: '1.2',
                  unit: 'Gbps',
                  trend: '11:42',
                  trendPositive: true,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _ThroughputTile(
                  icon: Icons.network_check_rounded,
                  color: AppColors.success,
                  label: 'Latency',
                  value: '18',
                  unit: 'ms avg',
                  trend: '-3 ms',
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

class _ThroughputTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String value;
  final String unit;
  final String trend;
  final bool trendPositive;

  const _ThroughputTile({
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
        label: 'Fiber Plans',
        used: 0.62,
        usedLabel: '4.83 / 7.80 TB',
      ),
      _QuotaRow(
        icon: Icons.smartphone_rounded,
        color: AppColors.info,
        label: 'Mobile Postpaid',
        used: 0.41,
        usedLabel: '1.23 / 3.00 TB',
      ),
      _QuotaRow(
        icon: Icons.live_tv_rounded,
        color: AppColors.warning,
        label: 'TV Streaming',
        used: 0.88,
        usedLabel: '880 / 1000 GB',
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
                            color:
                                critical ? AppColors.danger : color,
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

