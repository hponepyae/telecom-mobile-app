import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class LineFailureReportPage extends StatefulWidget {
  const LineFailureReportPage({super.key});

  @override
  State<LineFailureReportPage> createState() => _LineFailureReportPageState();
}

class _LineFailureReportPageState extends State<LineFailureReportPage> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _phoneController = TextEditingController(text: '+65 8123 4567');
  String _service = 'Fiber Internet · FB-500-2298';
  String _severity = 'Medium';
  bool _submitting = false;

  static const _services = [
    'Fiber Internet · FB-500-2298',
    'Mobile Postpaid · MS-65812345',
    'TV Streaming · TV-PREM-7841',
  ];

  static const _severities = ['Low', 'Medium', 'High'];

  @override
  void dispose() {
    _descriptionController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _submitting = true);
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    setState(() => _submitting = false);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.check_circle_rounded, color: AppColors.success),
            SizedBox(width: 8),
            Text(
              'Report submitted',
              style: TextStyle(
                fontFamily: 'Geist',
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ],
        ),
        content: const Text(
          'Ticket TK-9981 dispatched to the operations console. '
          'Our team will follow up within 2 hours.',
          style: TextStyle(fontFamily: 'Geist', fontSize: 13.5),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(0, 40),
              padding: const EdgeInsets.symmetric(horizontal: 18),
            ),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Line Failure Report')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          children: [
            _InfoBanner(),
            const SizedBox(height: 18),
            const _Label('Affected Service'),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _service,
              items: _services
                  .map((s) => DropdownMenuItem(
                        value: s,
                        child: Text(s,
                            style: const TextStyle(
                              fontFamily: 'Geist',
                              fontSize: 13.5,
                              fontWeight: FontWeight.w500,
                            )),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _service = v ?? _service),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.cell_tower_rounded, size: 20),
              ),
            ),
            const SizedBox(height: 16),
            const _Label('Severity'),
            const SizedBox(height: 8),
            Row(
              children: _severities
                  .map(
                    (s) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: _SeverityChip(
                          label: s,
                          selected: _severity == s,
                          onTap: () => setState(() => _severity = s),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16),
            const _Label('Failure Details / Description'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _descriptionController,
              maxLines: 5,
              maxLength: 500,
              decoration: const InputDecoration(
                hintText:
                    'Describe the issue, when it started, devices affected…',
                alignLabelWithHint: true,
              ),
              validator: (v) {
                if (v == null || v.trim().length < 10) {
                  return 'Please describe the issue (min 10 characters)';
                }
                return null;
              },
            ),
            const SizedBox(height: 4),
            const _Label('Contact Phone Number'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.phone_outlined, size: 20),
                hintText: '+65 8123 4567',
              ),
              validator: (v) {
                if (v == null || v.trim().length < 6) {
                  return 'Please enter a reachable phone number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.camera_alt_outlined, size: 18),
              label: const Text('Attach photo (optional)'),
            ),
            const SizedBox(height: 22),
            ElevatedButton.icon(
              onPressed: _submitting ? null : _submit,
              icon: _submitting
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.2,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    )
                  : const Icon(Icons.send_rounded, size: 18),
              label: Text(_submitting ? 'Dispatching…' : 'Submit Report'),
            ),
            const SizedBox(height: 8),
            Text(
              'Your report will be sent directly to the Admin Web Portal.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.primarySoft,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.build_circle_outlined, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Tell us what\'s wrong with your service and a field engineer will be assigned.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Geist',
        color: AppColors.textPrimary,
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _SeverityChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SeverityChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  Color get _accent {
    switch (label) {
      case 'Low':
        return AppColors.success;
      case 'Medium':
        return AppColors.warning;
      case 'High':
        return AppColors.danger;
      default:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = _accent;
    return Material(
      color: selected ? c : c.withOpacity(0.08),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? c : c.withOpacity(0.4),
              width: 1.2,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Geist',
              color: selected ? Colors.white : c,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
