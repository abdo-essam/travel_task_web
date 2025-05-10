import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travel_task_web/core/app_export.dart';


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
    return SizedBox(
      width: 243, // Fixed width as requested
      child: InkWell(
        onTap: onCardTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF111111),
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // Make column wrap content
            children: [
              // Image section with gradient overlay and more button
              Stack(
                children: [
                  // Image
                  Image.asset(
                    imageUrl,
                    height: 250 ,
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
                            Colors.black.withOpacity(0.5),
                            Colors.black.withOpacity(0.9),
                          ],
                          stops: const [0.4, 0.75, 1.0],
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
                          color: const Color(0xFF333333),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          ImageConstant.imgMore,
                          height: 32.h,
                          width: 32.h,
                        ),
                      ),
                    ),
                  ),

                  // Status pill
                  Positioned(
                    bottom: 16,
                    left: 16,
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

              // Content area
              Padding(
                padding: const EdgeInsets.all(16),
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

                    const SizedBox(height: 8),

                    // Date range
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          color: const Color(0xFF999999),
                          size: 14,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            dateRange,
                            style: const TextStyle(
                              color: Color(0xFF999999),
                              fontSize: 12,
                              fontFamily: 'Inter',
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Avatar stack and tasks count
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildAvatarStack(),
                        Flexible(
                          child: Text(
                            "$unfinishedTasks unfinished tasks",
                            style: const TextStyle(
                              color: Color(0xFF999999),
                              fontSize: 12,
                              fontFamily: 'Inter',
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
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

  Widget _buildAvatarStack() {
    if (avatarUrls.isEmpty) return const SizedBox.shrink();

    // For displaying the avatars in the format shown in the image
    const double avatarSize = 24;
    const double avatarOffset = 14; // overlap amount
    const int maxDisplayedAvatars = 3;

    List<Widget> avatars = [];
    int overflowCount = 0;

    if (avatarUrls.length <= maxDisplayedAvatars) {
      // If we have 3 or fewer avatars, show them all
      for (int i = 0; i < avatarUrls.length; i++) {
        avatars.add(
          Positioned(
            left: i * avatarOffset,
            child: _buildAvatarCircle(avatarUrls[i]),
          ),
        );
      }
    } else {
      // If we have more than 3 avatars, show the first 2 and the count
      for (int i = 0; i < 2; i++) {
        avatars.add(
          Positioned(
            left: i * avatarOffset,
            child: _buildAvatarCircle(avatarUrls[i]),
          ),
        );
      }

      overflowCount = avatarUrls.length - 2;
      avatars.add(
        Positioned(
          left: 2 * avatarOffset,
          child: Container(
            width: avatarSize,
            height: avatarSize,
            decoration: BoxDecoration(
              color: Color(0xFF333333),
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xFF111111), width: 2),
            ),
            child: Center(
              child: Text(
                "+$overflowCount",
                style: TextStyle(
                  color: Color(0xFFFFC268),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Width calculation for the stack
    double stackWidth = avatarUrls.length <= maxDisplayedAvatars
        ? (avatarUrls.length - 1) * avatarOffset + avatarSize
        : 2 * avatarOffset + avatarSize;

    return SizedBox(
      width: stackWidth,
      height: avatarSize,
      child: Stack(
        children: avatars,
      ),
    );
  }

  Widget _buildAvatarCircle(String imageUrl) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Color(0xFF111111), width: 2),
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}