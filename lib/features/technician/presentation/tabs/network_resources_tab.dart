import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../../shared/widgets/status_chip.dart';

class NetworkResourcesTab extends StatelessWidget {
  const NetworkResourcesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: _NetworkHeader()),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 32),
            sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
                _SearchField(),
                const SizedBox(height: 16),
                const SectionHeader(title: 'Nearest Network Nodes'),
                const SizedBox(height: 12),
                const _NodeCard(
                  name: 'OLT-CENTRAL-04',
                  type: 'Optical Line Terminal',
                  status: 'Operational',
                  statusType: StatusType.success,
                  ports: 64,
                  used: 41,
                ),
                const _NodeCard(
                  name: 'DSLAM-EAST-12',
                  type: 'DSLAM cabinet',
                  status: 'Degraded',
                  statusType: StatusType.warning,
                  ports: 48,
                  used: 46,
                ),
                const _NodeCard(
                  name: 'CT-NORTH-CELL-08',
                  type: 'LTE Cell Tower',
                  status: 'Operational',
                  statusType: StatusType.success,
                  ports: 0,
                  used: 0,
                  showPorts: false,
                ),
                const SizedBox(height: 20),
                const SectionHeader(title: 'Port Status · OLT-CENTRAL-04'),
                const SizedBox(height: 12),
                _PortGrid(),
                const SizedBox(height: 16),
                _Legend(),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _NetworkHeader extends StatelessWidget {
  const _NetworkHeader();

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
                child: const Icon(Icons.lan_rounded,
                    color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                'Network Resources',
                style: TextStyle(
                  fontFamily: 'Geist',
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Look up nodes, port status, and inventory.',
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

class _SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search device, node, or port (e.g. OLT-CENTRAL-04)',
        prefixIcon: const Icon(Icons.search_rounded, size: 20),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(6),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.qr_code_scanner_rounded,
                  color: Colors.white, size: 18),
            ),
          ),
        ),
      ),
    );
  }
}

class _NodeCard extends StatelessWidget {
  final String name;
  final String type;
  final String status;
  final StatusType statusType;
  final int ports;
  final int used;
  final bool showPorts;

  const _NodeCard({
    required this.name,
    required this.type,
    required this.status,
    required this.statusType,
    required this.ports,
    required this.used,
    this.showPorts = true,
  });

  @override
  Widget build(BuildContext context) {
    final usage = ports == 0 ? 0.0 : used / ports;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.primarySoft,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.dns_rounded,
                    color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 2),
                    Text(type, style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              StatusChip(label: status, type: statusType),
            ],
          ),
          if (showPorts) ...[
            const SizedBox(height: 14),
            Row(
              children: [
                Text(
                  '$used / $ports ports used',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Spacer(),
                Text(
                  '${(usage * 100).toStringAsFixed(0)}%',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.primary,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(99),
              child: LinearProgressIndicator(
                value: usage,
                minHeight: 6,
                backgroundColor: AppColors.primarySoft,
                valueColor: AlwaysStoppedAnimation(
                  usage > 0.85 ? AppColors.danger : AppColors.primary,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PortGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Demo data: 32 ports with mixed states.
    final states = List.generate(32, (i) {
      if (i % 9 == 0) return _PortState.fault;
      if (i % 3 == 0) return _PortState.free;
      return _PortState.active;
    });

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 8,
          mainAxisSpacing: 6,
          crossAxisSpacing: 6,
          childAspectRatio: 1,
        ),
        itemCount: states.length,
        itemBuilder: (_, i) {
          final s = states[i];
          Color color;
          switch (s) {
            case _PortState.active:
              color = AppColors.success;
              break;
            case _PortState.free:
              color = AppColors.border;
              break;
            case _PortState.fault:
              color = AppColors.danger;
              break;
          }
          return Container(
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              border: Border.all(color: color, width: 1.2),
              borderRadius: BorderRadius.circular(6),
            ),
            alignment: Alignment.center,
            child: Text(
              '${i + 1}',
              style: TextStyle(
                fontFamily: 'Geist',
                color: s == _PortState.free
                    ? AppColors.textMuted
                    : color,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        },
      ),
    );
  }
}

enum _PortState { active, free, fault }

class _Legend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget dot(Color c, String label) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: c.withOpacity(0.15),
              border: Border.all(color: c, width: 1.2),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 6),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        dot(AppColors.success, 'Active'),
        dot(AppColors.border, 'Free'),
        dot(AppColors.danger, 'Fault'),
      ],
    );
  }
}
