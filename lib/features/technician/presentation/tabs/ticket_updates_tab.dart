import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/status_chip.dart';

class TicketUpdatesTab extends StatefulWidget {
  const TicketUpdatesTab({super.key});

  @override
  State<TicketUpdatesTab> createState() => _TicketUpdatesTabState();
}

class _TicketUpdatesTabState extends State<TicketUpdatesTab>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;

  TicketCategory _filter = TicketCategory.all;

  final List<Ticket> _active = [
    Ticket(
      id: 'WO-7821',
      title: 'Fiber installation · 500 Mbps',
      customer: 'Sarah Lim',
      address: '14 Cedar Ave, Block B, #08-22',
      phone: '+65 9123 4567',
      reason:
          'New customer activation. Install AX3000 router, terminate fiber drop, run uplink test, register CPE on OSS.',
      status: 'Pending',
      category: TicketCategory.serviceActivation,
      appointment: 'Today · 09:30 – 11:00',
    ),
    Ticket(
      id: 'WO-7825',
      title: 'SIM swap activation',
      customer: 'David Tan',
      address: '22 Marina Way, #14-08',
      phone: '+65 9007 2231',
      reason:
          'Customer upgrading to 5G. Provision new eSIM profile, port number, verify HSS registration.',
      status: 'Pending',
      category: TicketCategory.serviceActivation,
      appointment: 'Today · 11:30 – 12:00',
    ),
    Ticket(
      id: 'TK-9942',
      title: 'No internet · ONT offline',
      customer: 'M. Rahman',
      address: '88 Orchid Heights, #03-11',
      phone: '+65 9412 8821',
      reason:
          'Customer reports complete loss of service since 06:00. ONT power LED off. Likely hardware fault — replacement unit may be required.',
      status: 'Pending',
      category: TicketCategory.faultReport,
      appointment: 'Today · 14:00 – 15:00',
    ),
    Ticket(
      id: 'TK-9947',
      title: 'Intermittent signal drops',
      customer: 'Jenny Park',
      address: '5 Riverside Loop, #21-05',
      phone: '+65 8762 1100',
      reason:
          'Signal drops every 15-20 minutes throughout the day. Modem reboots restore briefly. Possible upstream line issue.',
      status: 'In Progress',
      category: TicketCategory.faultReport,
      appointment: 'Today · 15:30 – 16:30',
    ),
    Ticket(
      id: 'TK-9930',
      title: 'Slow speed on 500 Mbps plan',
      customer: 'A. Suresh',
      address: '12 Pine Court, #07-09',
      phone: '+65 9223 4416',
      reason:
          'Speed test consistently shows ~120 Mbps despite 500 Mbps plan. Customer has tried multiple devices and routers.',
      status: 'In Progress',
      category: TicketCategory.faultReport,
      appointment: 'Tomorrow · 10:00 – 11:00',
    ),
  ];

  final List<Ticket> _history = [
    Ticket(
      id: 'WO-7810',
      title: 'Mesh WiFi expansion',
      customer: 'T. Brooks',
      address: '9 Lake Street, #06-14',
      phone: '+65 8120 4477',
      reason: 'Added 2 mesh nodes. Verified roaming handoff < 200 ms.',
      status: 'Resolved',
      category: TicketCategory.serviceActivation,
      appointment: 'Yesterday',
    ),
    Ticket(
      id: 'TK-9899',
      title: 'Set-top box no signal',
      customer: 'L. Cheung',
      address: '4 Bay View, #11-02',
      phone: '+65 9778 4002',
      reason: 'STB replaced. Service restored on first visit.',
      status: 'Resolved',
      category: TicketCategory.faultReport,
      appointment: 'Yesterday',
    ),
    Ticket(
      id: 'TK-9881',
      title: 'WiFi extender pairing',
      customer: 'P. Almeida',
      address: '17 Cypress Walk, #05-18',
      phone: '+65 8401 7723',
      reason: 'Onsite reconfiguration. Tested at 480 Mbps on extender.',
      status: 'Resolved',
      category: TicketCategory.faultReport,
      appointment: '2 days ago',
    ),
    Ticket(
      id: 'TK-9860',
      title: 'Fiber cable damage',
      customer: 'R. Nakamura',
      address: '203 Maple Drive, #02-04',
      phone: '+65 9655 3014',
      reason: 'Splice + drop replaced. 0 errors after 24h soak test.',
      status: 'Resolved',
      category: TicketCategory.faultReport,
      appointment: '3 days ago',
    ),
  ];

  List<Ticket> _applyFilter(List<Ticket> list) {
    if (_filter == TicketCategory.all) return list;
    return list.where((t) => t.category == _filter).toList();
  }

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  void _updateStatus(Ticket t, String next) =>
      setState(() => t.status = next);

  void _openDetail(Ticket t) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => _TicketDetailSheet(
        ticket: t,
        onStatusChange: (s) {
          setState(() => t.status = s);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _Header(controller: _tab),
          _CategoryFilter(
            selected: _filter,
            onSelect: (c) => setState(() => _filter = c),
          ),
          Expanded(
            child: TabBarView(
              controller: _tab,
              children: [
                _TicketList(
                  tickets: _applyFilter(_active),
                  onTap: _openDetail,
                  onStatus: _updateStatus,
                  editable: true,
                ),
                _TicketList(
                  tickets: _applyFilter(_history),
                  onTap: _openDetail,
                  onStatus: _updateStatus,
                  editable: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum TicketCategory { all, serviceActivation, faultReport }

class Ticket {
  final String id;
  final String title;
  final String customer;
  final String address;
  final String phone;
  final String reason;
  final TicketCategory category;
  final String appointment;
  String status;
  Ticket({
    required this.id,
    required this.title,
    required this.customer,
    required this.address,
    required this.phone,
    required this.reason,
    required this.status,
    required this.category,
    required this.appointment,
  });
}

class _CategoryFilter extends StatelessWidget {
  final TicketCategory selected;
  final ValueChanged<TicketCategory> onSelect;

  const _CategoryFilter({required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    Widget pill(TicketCategory cat, String label, IconData icon) {
      final active = selected == cat;
      return GestureDetector(
        onTap: () => onSelect(cat),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: active ? AppColors.primary : AppColors.surface,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: active ? AppColors.primary : AppColors.border,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 14,
                color: active ? Colors.white : AppColors.textMuted,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Geist',
                  color: active ? Colors.white : AppColors.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            pill(TicketCategory.all, 'All', Icons.apps_rounded),
            const SizedBox(width: 8),
            pill(TicketCategory.serviceActivation, 'Service Activations',
                Icons.handshake_outlined),
            const SizedBox(width: 8),
            pill(TicketCategory.faultReport, 'Fault Reports',
                Icons.report_problem_outlined),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final TabController controller;
  const _Header({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 56, 20, 0),
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
                child: const Icon(Icons.assignment_turned_in_rounded,
                    color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                'Tickets',
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
          const SizedBox(height: 6),
          Text(
            'Manage active issues and historical resolutions.',
            style: TextStyle(
              fontFamily: 'Geist',
              color: Colors.white.withOpacity(0.85),
              fontSize: 12.5,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.14),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TabBar(
              controller: controller,
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(9),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelColor: AppColors.primary,
              unselectedLabelColor: Colors.white,
              labelStyle: const TextStyle(
                fontFamily: 'Geist',
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelStyle: const TextStyle(
                fontFamily: 'Geist',
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              tabs: const [
                Tab(text: 'Active Queue'),
                Tab(text: 'History Log'),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _TicketList extends StatelessWidget {
  final List<Ticket> tickets;
  final void Function(Ticket) onTap;
  final void Function(Ticket, String) onStatus;
  final bool editable;

  const _TicketList({
    required this.tickets,
    required this.onTap,
    required this.onStatus,
    required this.editable,
  });

  @override
  Widget build(BuildContext context) {
    if (tickets.isEmpty) {
      return Center(
        child: Text(
          editable ? 'No active tickets.' : 'No history yet.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      itemCount: tickets.length,
      itemBuilder: (_, i) => _TicketCard(
        ticket: tickets[i],
        editable: editable,
        onTap: () => onTap(tickets[i]),
        onStatus: (s) => onStatus(tickets[i], s),
      ),
    );
  }
}

class _TicketCard extends StatefulWidget {
  final Ticket ticket;
  final bool editable;
  final VoidCallback onTap;
  final ValueChanged<String> onStatus;

  const _TicketCard({
    required this.ticket,
    required this.editable,
    required this.onTap,
    required this.onStatus,
  });

  @override
  State<_TicketCard> createState() => _TicketCardState();
}

class _TicketCardState extends State<_TicketCard> {
  String? _pendingStatus;
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _onSelectStatus(String s) {
    if (s == widget.ticket.status) return;
    setState(() {
      _pendingStatus = s;
      _noteController.clear();
    });
  }

  void _cancelStatusChange() {
    setState(() {
      _pendingStatus = null;
      _noteController.clear();
    });
  }

  void _confirmStatusChange() {
    final note = _noteController.text.trim();
    if (note.length < 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.warning,
          content: Text('Please add at least 5 characters of justification.'),
        ),
      );
      return;
    }
    widget.onStatus(_pendingStatus!);
    setState(() {
      _pendingStatus = null;
      _noteController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: widget.onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Builder(builder: (context) {
                final v = _ticketVisual(widget.ticket);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: v.color.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(v.icon, color: v.color, size: 20),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.ticket.id,
                                style: const TextStyle(
                                  fontFamily: 'Geist',
                                  color: AppColors.textMuted,
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.4,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(widget.ticket.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        StatusChip(
                          label: widget.ticket.status,
                          type: _statusType(widget.ticket.status),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.person_outline_rounded,
                            size: 14, color: AppColors.textMuted),
                        const SizedBox(width: 4),
                        Text(widget.ticket.customer,
                            style: Theme.of(context).textTheme.bodySmall),
                        const SizedBox(width: 10),
                        const Icon(Icons.place_outlined,
                            size: 14, color: AppColors.textMuted),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            widget.ticket.address,
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
                        Text(widget.ticket.appointment,
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ],
                );
              }),
            ),
          ),
          if (widget.editable) ...[
            const SizedBox(height: 14),
            _StatusButtonGroup(
              current: widget.ticket.status,
              pending: _pendingStatus,
              onSelect: _onSelectStatus,
            ),
            _AnimatedNoteInput(
              expanded: _pendingStatus != null,
              controller: _noteController,
              pendingStatus: _pendingStatus,
              onCancel: _cancelStatusChange,
              onConfirm: _confirmStatusChange,
            ),
          ],
        ],
      ),
    );
  }
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

({IconData icon, Color color}) _ticketVisual(Ticket t) {
  if (t.category == TicketCategory.faultReport) {
    return (icon: Icons.report_problem_rounded, color: AppColors.danger);
  }
  final title = t.title.toLowerCase();
  if (title.contains('sim')) {
    return (icon: Icons.sim_card_outlined, color: AppColors.info);
  }
  if (title.contains('mesh') || title.contains('wifi')) {
    return (icon: Icons.wifi_rounded, color: AppColors.success);
  }
  return (icon: Icons.router_rounded, color: AppColors.primary);
}

class _StatusButtonGroup extends StatelessWidget {
  final String current;
  final String? pending;
  final ValueChanged<String> onSelect;

  const _StatusButtonGroup({
    required this.current,
    required this.pending,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatusBtn(
            label: 'Pending',
            color: AppColors.warning,
            selected: current == 'Pending' || pending == 'Pending',
            highlighted: pending == 'Pending',
            onTap: () => onSelect('Pending'),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _StatusBtn(
            label: 'In Progress',
            color: AppColors.info,
            selected: current == 'In Progress' || pending == 'In Progress',
            highlighted: pending == 'In Progress',
            onTap: () => onSelect('In Progress'),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _StatusBtn(
            label: 'Resolved',
            color: AppColors.success,
            selected: current == 'Resolved' || pending == 'Resolved',
            highlighted: pending == 'Resolved',
            onTap: () => onSelect('Resolved'),
          ),
        ),
      ],
    );
  }
}

class _StatusBtn extends StatelessWidget {
  final String label;
  final Color color;
  final bool selected;
  final bool highlighted;
  final VoidCallback onTap;

  const _StatusBtn({
    required this.label,
    required this.color,
    required this.selected,
    required this.highlighted,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = highlighted
        ? color
        : selected
            ? color.withOpacity(0.16)
            : color.withOpacity(0.08);
    final border = highlighted
        ? color
        : selected
            ? color
            : color.withOpacity(0.4);
    final fg = highlighted ? Colors.white : color;

    return Material(
      color: bg,
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
            border: Border.all(color: border, width: 1.2),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Geist',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: fg,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}

class _AnimatedNoteInput extends StatefulWidget {
  final bool expanded;
  final TextEditingController controller;
  final String? pendingStatus;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  const _AnimatedNoteInput({
    required this.expanded,
    required this.controller,
    required this.pendingStatus,
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  State<_AnimatedNoteInput> createState() => _AnimatedNoteInputState();
}

class _AnimatedNoteInputState extends State<_AnimatedNoteInput> {
  // Mock attached image slots (null = empty, true = has image)
  final List<bool?> _images = [null, null, null];

  String get _prompt {
    switch (widget.pendingStatus) {
      case 'Pending':
        return 'Why is this ticket pending?';
      case 'In Progress':
        return 'What actions are being taken right now?';
      case 'Resolved':
        return 'Describe the resolution applied.';
      default:
        return 'Please describe what changed and why.';
    }
  }

  void _toggleImage(int i) {
    setState(() {
      _images[i] = _images[i] == null ? true : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      alignment: Alignment.topCenter,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        transitionBuilder: (child, anim) => FadeTransition(
          opacity: anim,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -0.04),
              end: Offset.zero,
            ).animate(anim),
            child: child,
          ),
        ),
        child: widget.expanded
            ? Padding(
                key: const ValueKey('input'),
                padding: const EdgeInsets.only(top: 12),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primarySoft,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: AppColors.primary.withOpacity(0.25)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.edit_note_rounded,
                              size: 18, color: AppColors.primary),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              _prompt,
                              style: const TextStyle(
                                fontFamily: 'Geist',
                                color: AppColors.primary,
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: widget.controller,
                        minLines: 2,
                        maxLines: 4,
                        maxLength: 240,
                        autofocus: true,
                        style: const TextStyle(
                          fontFamily: 'Geist',
                          fontSize: 13.5,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Type your justification…',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          counterText: '',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: AppColors.border),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: AppColors.border),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: AppColors.primary, width: 1.4),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // ── Image upload section ──────────────────────────
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.photo_camera_outlined,
                                    size: 15, color: AppColors.textMuted),
                                const SizedBox(width: 6),
                                const Text(
                                  'Attach Photos',
                                  style: TextStyle(
                                    fontFamily: 'Geist',
                                    color: AppColors.textMuted,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '${_images.where((e) => e == true).length}/3',
                                  style: const TextStyle(
                                    fontFamily: 'Geist',
                                    color: AppColors.textMuted,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: List.generate(3, (i) {
                                final hasImage = _images[i] == true;
                                return Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: i < 2 ? 8 : 0),
                                    child: GestureDetector(
                                      onTap: () => _toggleImage(i),
                                      child: AnimatedContainer(
                                        duration: const Duration(
                                            milliseconds: 180),
                                        height: 72,
                                        decoration: BoxDecoration(
                                          color: hasImage
                                              ? AppColors.primary
                                                  .withOpacity(0.08)
                                              : AppColors.background,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: hasImage
                                                ? AppColors.primary
                                                    .withOpacity(0.4)
                                                : AppColors.border,
                                            width: hasImage ? 1.4 : 1,
                                            style: hasImage
                                                ? BorderStyle.solid
                                                : BorderStyle.solid,
                                          ),
                                        ),
                                        child: hasImage
                                            ? Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.image_rounded,
                                                    size: 28,
                                                    color: AppColors.primary
                                                        .withOpacity(0.6),
                                                  ),
                                                  Positioned(
                                                    top: 4,
                                                    right: 4,
                                                    child: Container(
                                                      width: 16,
                                                      height: 16,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color:
                                                            AppColors.primary,
                                                        shape:
                                                            BoxShape.circle,
                                                      ),
                                                      child: const Icon(
                                                        Icons.check,
                                                        size: 10,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.add_photo_alternate_outlined,
                                                    size: 22,
                                                    color: AppColors.textMuted
                                                        .withOpacity(0.6),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    'Add photo',
                                                    style: TextStyle(
                                                      fontFamily: 'Geist',
                                                      color: AppColors
                                                          .textMuted
                                                          .withOpacity(0.6),
                                                      fontSize: 9.5,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: widget.onCancel,
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size.fromHeight(40),
                              ),
                              child: const Text('Cancel'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: widget.onConfirm,
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(40),
                              ),
                              icon: const Icon(Icons.check_rounded,
                                  size: 16),
                              label: const Text('Save status'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox.shrink(key: ValueKey('empty')),
      ),
    );
  }
}

class _TicketDetailSheet extends StatefulWidget {
  final Ticket ticket;
  final ValueChanged<String> onStatusChange;

  const _TicketDetailSheet({
    required this.ticket,
    required this.onStatusChange,
  });

  @override
  State<_TicketDetailSheet> createState() => _TicketDetailSheetState();
}

class _TicketDetailSheetState extends State<_TicketDetailSheet> {
  String? _pendingStatus;
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _select(String s) {
    if (s == widget.ticket.status) return;
    setState(() {
      _pendingStatus = s;
      _noteController.clear();
    });
  }

  void _cancel() => setState(() {
        _pendingStatus = null;
        _noteController.clear();
      });

  void _confirm() {
    final note = _noteController.text.trim();
    if (note.length < 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.warning,
          content: Text('Please add at least 5 characters of justification.'),
        ),
      );
      return;
    }
    setState(() {
      widget.ticket.status = _pendingStatus!;
      _pendingStatus = null;
      _noteController.clear();
    });
    widget.onStatusChange(widget.ticket.status);
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.ticket;
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            16,
            10,
            16,
            16 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Text(
                    t.id,
                    style: const TextStyle(
                      fontFamily: 'Geist',
                      color: AppColors.textMuted,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.4,
                    ),
                  ),
                  const Spacer(),
                  StatusChip(label: t.status, type: _statusType(t.status)),
                ],
              ),
              const SizedBox(height: 6),
              Text(t.title, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 16),
              _DetailTile(
                icon: Icons.person_outline_rounded,
                tint: AppColors.info,
                title: 'Customer',
                value: t.customer,
              ),
              const SizedBox(height: 8),
              _DetailTile(
                icon: Icons.place_outlined,
                tint: AppColors.primary,
                title: 'Target Location',
                value: t.address,
              ),
              const SizedBox(height: 8),
              _DetailTile(
                icon: Icons.phone_outlined,
                tint: AppColors.success,
                title: 'Contact Phone',
                value: t.phone,
                trailing: const Icon(Icons.call_rounded,
                    color: AppColors.success, size: 20),
              ),
              const SizedBox(height: 14),
              const Text(
                'Reason / Issue Details',
                style: TextStyle(
                  fontFamily: 'Geist',
                  color: AppColors.textMuted,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Text(
                  t.reason,
                  style: const TextStyle(
                    fontFamily: 'Geist',
                    color: AppColors.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Update status',
                style: TextStyle(
                  fontFamily: 'Geist',
                  color: AppColors.textMuted,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 8),
              _StatusButtonGroup(
                current: t.status,
                pending: _pendingStatus,
                onSelect: _select,
              ),
              _AnimatedNoteInput(
                expanded: _pendingStatus != null,
                controller: _noteController,
                pendingStatus: _pendingStatus,
                onCancel: _cancel,
                onConfirm: _confirm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailTile extends StatelessWidget {
  final IconData icon;
  final Color tint;
  final String title;
  final String value;
  final Widget? trailing;

  const _DetailTile({
    required this.icon,
    required this.tint,
    required this.title,
    required this.value,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: tint.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: tint, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Geist',
                    color: AppColors.textMuted,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontFamily: 'Geist',
                    color: AppColors.textPrimary,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
