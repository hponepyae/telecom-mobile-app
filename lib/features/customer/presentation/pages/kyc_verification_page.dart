import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/status_chip.dart';

class KycVerificationPage extends StatefulWidget {
  const KycVerificationPage({super.key});

  @override
  State<KycVerificationPage> createState() => _KycVerificationPageState();
}

class _KycVerificationPageState extends State<KycVerificationPage> {
  bool _idDone = true;
  bool _passportDone = false;
  bool _selfieDone = false;

  @override
  Widget build(BuildContext context) {
    final completed =
        [_idDone, _passportDone, _selfieDone].where((e) => e).length;
    final progress = completed / 3;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('KYC Verification')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          _StatusCard(progress: progress, completed: completed),
          const SizedBox(height: 20),
          Text('Required documents',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            'Upload clear scans or photos. All files are encrypted at rest.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 14),
          _DocSlot(
            icon: Icons.badge_outlined,
            title: 'National ID Card',
            subtitle: 'Both front and back required',
            uploaded: _idDone,
            onTap: () => setState(() => _idDone = !_idDone),
          ),
          const SizedBox(height: 10),
          _DocSlot(
            icon: Icons.book_outlined,
            title: 'Passport',
            subtitle: 'Photo page · machine-readable zone',
            uploaded: _passportDone,
            onTap: () => setState(() => _passportDone = true),
          ),
          const SizedBox(height: 10),
          _DocSlot(
            icon: Icons.face_outlined,
            title: 'Liveness Selfie',
            subtitle: 'Hold ID next to your face',
            uploaded: _selfieDone,
            onTap: () => setState(() => _selfieDone = true),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: completed == 3 ? () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: AppColors.success,
                  content: Text('KYC submitted for review.'),
                ),
              );
              Navigator.of(context).pop();
            } : null,
            child: const Text('Submit for verification'),
          ),
        ],
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  final double progress;
  final int completed;
  const _StatusCard({required this.progress, required this.completed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.verified_user_outlined, color: Colors.white),
              const SizedBox(width: 10),
              const Text(
                'Verification Progress',
                style: TextStyle(
                  fontFamily: 'Geist',
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                '$completed / 3',
                style: const TextStyle(
                  fontFamily: 'Geist',
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.white.withOpacity(0.18),
              valueColor: const AlwaysStoppedAnimation(Colors.white),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            completed == 3
                ? 'All documents collected. Ready to submit.'
                : 'Complete all documents to verify your account.',
            style: TextStyle(
              fontFamily: 'Geist',
              color: Colors.white.withOpacity(0.85),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _DocSlot extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool uploaded;
  final VoidCallback onTap;

  const _DocSlot({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.uploaded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: uploaded
                  ? AppColors.success.withOpacity(0.4)
                  : AppColors.border,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: uploaded
                      ? AppColors.success.withOpacity(0.12)
                      : AppColors.primarySoft,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: uploaded ? AppColors.success : AppColors.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 2),
                    Text(subtitle,
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              if (uploaded)
                const StatusChip(label: 'Uploaded', type: StatusType.success)
              else
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.primarySoft,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.upload_file_outlined,
                          color: AppColors.primary, size: 14),
                      SizedBox(width: 4),
                      Text(
                        'Upload',
                        style: TextStyle(
                          fontFamily: 'Geist',
                          color: AppColors.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
