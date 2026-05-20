import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/status_chip.dart';

class ProductInfoPage extends StatelessWidget {
  const ProductInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Product Information')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: const [
          _ProductCard(
            icon: Icons.wifi_rounded,
            tint: AppColors.primary,
            title: 'Fiber Internet',
            serviceId: 'FB-500-2298',
            tagline: '500 Mbps Symmetric',
            price: '29,900 MMK / mo',
            specs: [
              _Spec(label: 'Download', value: '500 Mbps'),
              _Spec(label: 'Upload', value: '500 Mbps'),
              _Spec(label: 'Data cap', value: 'Unlimited'),
              _Spec(label: 'Router', value: 'AX3000 WiFi 6'),
              _Spec(label: 'IP', value: 'Dynamic IPv4 / IPv6'),
              _Spec(label: 'Renewal', value: 'Monthly · May 28'),
            ],
          ),
          _ProductCard(
            icon: Icons.smartphone_rounded,
            tint: AppColors.info,
            title: 'Mobile Postpaid',
            serviceId: 'MS-65812345',
            tagline: '30 GB · Unlimited Calls & SMS',
            price: '14,500 MMK / mo',
            specs: [
              _Spec(label: 'Data', value: '30 GB high speed'),
              _Spec(label: 'After cap', value: '1 Mbps unlimited'),
              _Spec(label: 'Voice', value: 'Unlimited local'),
              _Spec(label: 'SMS', value: 'Unlimited local'),
              _Spec(label: 'Roaming', value: 'Pay-as-you-go'),
              _Spec(label: '5G', value: 'Included'),
            ],
          ),
          _ProductCard(
            icon: Icons.live_tv_rounded,
            tint: AppColors.warning,
            title: 'TV Streaming',
            serviceId: 'TV-PREM-7841',
            tagline: 'Premium 4K · 120+ channels',
            price: '4,500 MMK / mo',
            specs: [
              _Spec(label: 'Channels', value: '120+ HD / 4K'),
              _Spec(label: 'Devices', value: 'Up to 4 concurrent'),
              _Spec(label: 'Recording', value: '500 hours cloud DVR'),
              _Spec(label: 'Add-ons', value: 'Sports, Movies, Kids'),
            ],
          ),
        ],
      ),
    );
  }
}

class _Spec {
  final String label;
  final String value;
  const _Spec({required this.label, required this.value});
}

class _ProductCard extends StatelessWidget {
  final IconData icon;
  final Color tint;
  final String title;
  final String serviceId;
  final String tagline;
  final String price;
  final List<_Spec> specs;

  const _ProductCard({
    required this.icon,
    required this.tint,
    required this.title,
    required this.serviceId,
    required this.tagline,
    required this.price,
    required this.specs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
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
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: tint.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: tint, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 2),
                    Text(tagline,
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              const StatusChip(label: 'Active', type: StatusType.success),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                serviceId,
                style: const TextStyle(
                  fontFamily: 'Geist',
                  color: AppColors.textMuted,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4,
                ),
              ),
              const Spacer(),
              Text(
                price,
                style: const TextStyle(
                  fontFamily: 'Geist',
                  color: AppColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                for (int i = 0; i < specs.length; i++) ...[
                  _row(specs[i]),
                  if (i < specs.length - 1)
                    const Divider(
                      height: 1,
                      color: AppColors.divider,
                      indent: 12,
                      endIndent: 12,
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(_Spec spec) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      child: Row(
        children: [
          Expanded(
            child: Text(
              spec.label,
              style: const TextStyle(
                fontFamily: 'Geist',
                color: AppColors.textMuted,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            spec.value,
            style: const TextStyle(
              fontFamily: 'Geist',
              color: AppColors.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
