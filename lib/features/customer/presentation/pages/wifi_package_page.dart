import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class WifiPackagePage extends StatelessWidget {
  const WifiPackagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('WiFi Packages')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: const [
          _HeaderBanner(),
          SizedBox(height: 18),
          _PackageCard(
            speed: '100',
            unit: 'Mbps',
            name: 'Starter Home',
            price: '19,900 MMK',
            cycle: '/month',
            perks: [
              'Unlimited monthly data',
              'WiFi 5 router included',
              'Self-install kit',
            ],
            recommended: false,
          ),
          _PackageCard(
            speed: '500',
            unit: 'Mbps',
            name: 'Family Pro',
            price: '29,900 MMK',
            cycle: '/month',
            perks: [
              'Unlimited monthly data',
              'WiFi 6 AX3000 router',
              'Mesh-ready · 2 nodes',
              'Free first-month',
            ],
            recommended: true,
          ),
          _PackageCard(
            speed: '1',
            unit: 'Gbps',
            name: 'Power Gigabit',
            price: '49,900 MMK',
            cycle: '/month',
            perks: [
              'Symmetric 1 Gbps',
              'WiFi 6E router · 4 ports',
              'Static IP available',
              'Priority support 24/7',
            ],
            recommended: false,
          ),
          _PackageCard(
            speed: '2',
            unit: 'Gbps',
            name: 'Studio Plus',
            price: '79,900 MMK',
            cycle: '/month',
            perks: [
              '2 Gbps fiber connection',
              'WiFi 7 mesh · 3 nodes',
              'Static IPv4 + /56 IPv6',
              'Dedicated NOC support',
            ],
            recommended: false,
          ),
        ],
      ),
    );
  }
}

class _HeaderBanner extends StatelessWidget {
  const _HeaderBanner();

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
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.25)),
            ),
            child: const Icon(Icons.wifi_rounded, color: Colors.white),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose your WiFi plan',
                  style: TextStyle(
                    fontFamily: 'Geist',
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.2,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'No contract · cancel anytime',
                  style: TextStyle(
                    fontFamily: 'Geist',
                    color: Colors.white70,
                    fontSize: 12,
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

class _PackageCard extends StatelessWidget {
  final String speed;
  final String unit;
  final String name;
  final String price;
  final String cycle;
  final List<String> perks;
  final bool recommended;

  const _PackageCard({
    required this.speed,
    required this.unit,
    required this.name,
    required this.price,
    required this.cycle,
    required this.perks,
    required this.recommended,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: recommended ? AppColors.primary : AppColors.border,
          width: recommended ? 1.6 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.primarySoft,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    Text(
                      speed,
                      style: const TextStyle(
                        fontFamily: 'Geist',
                        color: AppColors.primary,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        height: 1,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      unit,
                      style: const TextStyle(
                        fontFamily: 'Geist',
                        color: AppColors.primary,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style:
                                Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        if (recommended)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'POPULAR',
                              style: TextStyle(
                                fontFamily: 'Geist',
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          price,
                          style:
                              Theme.of(context).textTheme.headlineMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primary,
                                    letterSpacing: -0.4,
                                  ),
                        ),
                        const SizedBox(width: 4),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            cycle,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          for (final perk in perks)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  const Icon(Icons.check_circle_rounded,
                      color: AppColors.success, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      perk,
                      style: const TextStyle(
                        fontFamily: 'Geist',
                        color: AppColors.textSecondary,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: recommended
                ? ElevatedButton(
                    onPressed: () {},
                    child: const Text('Choose this plan'),
                  )
                : OutlinedButton(
                    onPressed: () {},
                    child: const Text('Choose this plan'),
                  ),
          ),
        ],
      ),
    );
  }
}
