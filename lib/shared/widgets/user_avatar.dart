import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Realistic human portrait avatar with graceful loading + error states.
///
/// Uses curated public portrait URLs (randomuser.me) so the UI showcases
/// real human imagery instead of monogram initials. Falls back to a soft
/// person glyph if the network request fails or while loading.
class UserAvatar extends StatelessWidget {
  final double size;
  final double radius;
  final String imageUrl;
  final Color ringColor;
  final double ringWidth;
  final bool showCameraBadge;
  final VoidCallback? onCameraTap;

  const UserAvatar({
    super.key,
    required this.imageUrl,
    this.size = 56,
    this.radius = 16,
    this.ringColor = Colors.transparent,
    this.ringWidth = 0,
    this.showCameraBadge = false,
    this.onCameraTap,
  });

  /// Curated portrait URLs — stable, royalty-free, served over HTTPS.
  static const String customerAlex =
      'https://randomuser.me/api/portraits/men/32.jpg';
  static const String technicianJordan =
      'https://randomuser.me/api/portraits/men/75.jpg';

  @override
  Widget build(BuildContext context) {
    final inner = ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.network(
        imageUrl,
        width: size,
        height: size,
        fit: BoxFit.cover,
        gaplessPlayback: true,
        loadingBuilder: (ctx, child, progress) {
          if (progress == null) return child;
          return _ShimmerFallback(size: size, radius: radius);
        },
        errorBuilder: (_, __, ___) => _IconFallback(size: size, radius: radius),
      ),
    );

    final framed = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: ringWidth > 0
            ? Border.all(color: ringColor, width: ringWidth)
            : null,
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: inner,
    );

    if (!showCameraBadge) return framed;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          framed,
          Positioned(
            right: -2,
            bottom: -2,
            child: Material(
              color: Colors.white,
              shape: const CircleBorder(),
              elevation: 2,
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onCameraTap,
                child: const Padding(
                  padding: EdgeInsets.all(6),
                  child: Icon(
                    Icons.photo_camera_rounded,
                    color: AppColors.primary,
                    size: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShimmerFallback extends StatelessWidget {
  final double size;
  final double radius;
  const _ShimmerFallback({required this.size, required this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.18),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: const Center(
        child: SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation(Colors.white70),
          ),
        ),
      ),
    );
  }
}

class _IconFallback extends StatelessWidget {
  final double size;
  final double radius;
  const _IconFallback({required this.size, required this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Icon(
        Icons.person_rounded,
        color: Colors.white.withOpacity(0.9),
        size: size * 0.55,
      ),
    );
  }
}
