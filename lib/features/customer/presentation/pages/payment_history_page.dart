import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/status_chip.dart';

class PaymentHistoryPage extends StatelessWidget {
  const PaymentHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Payment History')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: const [
          _SummaryRow(),
          SizedBox(height: 18),
          _MonthGroup(label: 'May 2026', items: [
            _PaymentItem(
              title: 'April Invoice',
              method: 'Apple Pay',
              amount: '48,900 MMK',
              date: 'May 02',
              statusType: StatusType.success,
              statusLabel: 'Paid',
            ),
          ]),
          _MonthGroup(label: 'April 2026', items: [
            _PaymentItem(
              title: 'Data Top-up',
              method: 'KBZPay',
              amount: '30,000 MMK',
              date: 'Apr 28',
              statusType: StatusType.success,
              statusLabel: 'Paid',
            ),
            _PaymentItem(
              title: 'March Invoice',
              method: 'AYAPay',
              amount: '48,900 MMK',
              date: 'Apr 02',
              statusType: StatusType.success,
              statusLabel: 'Paid',
            ),
          ]),
          _MonthGroup(label: 'March 2026', items: [
            _PaymentItem(
              title: 'Add-on · 5 GB',
              method: 'Bank · Visa ••4421',
              amount: '6,000 MMK',
              date: 'Mar 22',
              statusType: StatusType.success,
              statusLabel: 'Paid',
            ),
            _PaymentItem(
              title: 'February Invoice',
              method: 'WaveMoney',
              amount: '52,100 MMK',
              date: 'Mar 02',
              statusType: StatusType.success,
              statusLabel: 'Paid',
            ),
            _PaymentItem(
              title: 'January Adjustment',
              method: 'Account credit',
              amount: '12,000 MMK',
              date: 'Jan 18',
              statusType: StatusType.info,
              statusLabel: 'Refunded',
            ),
          ]),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow();

  @override
  Widget build(BuildContext context) {
    Widget tile(String label, String value, IconData icon, Color color) {
      return Expanded(
        child: Container(
          padding: const EdgeInsets.all(14),
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
              Text(label, style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 2),
              Text(
                value,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                    ),
              ),
            ],
          ),
        ),
      );
    }

    return Row(
      children: [
        tile('Paid YTD', '248,800 MMK', Icons.trending_up_rounded,
            AppColors.success),
        const SizedBox(width: 10),
        tile('Transactions', '7', Icons.receipt_long_rounded,
            AppColors.primary),
        const SizedBox(width: 10),
        tile('Avg / month', '49,800 MMK', Icons.show_chart_rounded,
            AppColors.info),
      ],
    );
  }
}

class _MonthGroup extends StatelessWidget {
  final String label;
  final List<_PaymentItem> items;
  const _MonthGroup({required this.label, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Text(
            label.toUpperCase(),
            style: const TextStyle(
              fontFamily: 'Geist',
              color: AppColors.textMuted,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              for (int i = 0; i < items.length; i++) ...[
                items[i],
                if (i < items.length - 1)
                  const Divider(
                    height: 1,
                    color: AppColors.divider,
                    indent: 14,
                    endIndent: 14,
                  ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _PaymentItem extends StatelessWidget {
  final String title;
  final String method;
  final String amount;
  final String date;
  final StatusType statusType;
  final String statusLabel;

  const _PaymentItem({
    required this.title,
    required this.method,
    required this.amount,
    required this.date,
    required this.statusType,
    required this.statusLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primarySoft,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.description_outlined,
                color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 2),
                Text(
                  '$method · $date',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 4),
              StatusChip(label: statusLabel, type: statusType),
            ],
          ),
        ],
      ),
    );
  }
}
