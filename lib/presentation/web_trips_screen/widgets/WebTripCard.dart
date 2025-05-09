import 'package:flutter/material.dart';

class WebTripCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String dateRange;
  final int unfinishedTasks;
  final List<String> avatarUrls;
  final VoidCallback? onCardTap;
  final VoidCallback? onMoreTap;

  const WebTripCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.dateRange,
    this.unfinishedTasks = 0,
    this.avatarUrls = const [],
    this.onCardTap,
    this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCardTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section with gradient overlay and more button
            Stack(
              children: [
                // Image
                Image.asset(
                  imageUrl,
                  height: 182,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

                // Gradient overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                        stops: const [0.6, 1.0],
                      ),
                    ),
                  ),
                ),

                // More button
                Positioned(
                  top: 12,
                  right: 12,
                  child: InkWell(
                    onTap: onMoreTap,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4D4D4D),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),

                // Status pill - positioned at bottom of image
                Positioned(
                  bottom: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFC25F30)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Pending Approval",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Title and date section
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 6),

                  // Date range
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        color: const Color(0xFF999999),
                        size: 14,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        dateRange,
                        style: const TextStyle(
                          color: Color(0xFF999999),
                          fontSize: 12,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Avatar stack and tasks count section (bottom section)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.black.withOpacity(0.3),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildAvatarStack(),
                  Text(
                    "$unfinishedTasks unfinished tasks",
                    style: const TextStyle(
                      color: Color(0xFF999999),
                      fontSize: 12,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarStack() {
    if (avatarUrls.isEmpty) return const SizedBox.shrink();

    // In this design, we show 2 avatars and then a counter
    const int visibleAvatars = 2;
    final int extraAvatars = avatarUrls.length > visibleAvatars ?
    avatarUrls.length - visibleAvatars : 0;

    return SizedBox(
      height: 24,
      width: 80, // Explicit width for the stack
      child: Stack(
        children: [
          for (int i = 0; i < _min(visibleAvatars, avatarUrls.length); i++)
            Positioned(
              left: i * 14.0, // Slightly closer overlap
              child: Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF1A1A1A), width: 1.5),
                  image: DecorationImage(
                    image: AssetImage(avatarUrls[i]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          if (extraAvatars > 0)
            Positioned(
              left: _min(visibleAvatars, avatarUrls.length) * 14.0,
              child: Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  color: const Color(0xFF333333),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF1A1A1A), width: 1.5),
                ),
                child: Center(
                  child: Text(
                    "+$extraAvatars",
                    style: const TextStyle(
                      color: Color(0xFFFFC062),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  int _min(int a, int b) => a < b ? a : b;
}

