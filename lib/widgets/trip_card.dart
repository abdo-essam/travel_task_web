import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../core/app_export.dart';
import '../presentation/trips_screen/widgets/custom_icon_button.dart';
import 'custom_drop_down.dart';

class TripCard extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final String dateRange;
  final int unfinishedTasks;
  final List<String> avatarUrls;
  final VoidCallback? onCardTap;
  final VoidCallback? onMoreTap;

  TripCard({
    super.key,
    this.imageUrl,
    required this.title,
    required this.dateRange,
    this.unfinishedTasks = 0,
    this.avatarUrls = const [],
    this.onCardTap,
    this.onMoreTap,
  });

  final List<String> dropdownItemList = [
    "Pending Approval",
    "Approved",
    "Rejected",
    "In Progress"
  ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCardTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        margin: EdgeInsets.zero,
        color: appTheme.gray90001,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusStyle.circleBorder16,
        ),
        child: Container(
          decoration: AppDecoration.outlineBlack.copyWith(
            borderRadius: BorderRadiusStyle.circleBorder16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // Add this to prevent overflowing
            children: [
              _buildImageSection(),
              Padding(
                padding: EdgeInsets.all(16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min, // Add this to prevent overflowing
                  children: [
                    _buildStatusDropdown(),
                    SizedBox(height: 16.h),
                    _buildTitleSection(),
                    SizedBox(height: 6.h),
                    _buildDateSection(),
                    SizedBox(height: 12.h),
                    Divider(color: appTheme.gray900),
                    SizedBox(height: 10.h),
                    _buildBottomSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Stack(
      children: [
        CustomImageView(
          imagePath: imageUrl ?? ImageConstant.imgRectangle1208,
          height: 188.h,
          width: double.infinity,
          radius: BorderRadius.only(
            topLeft: Radius.circular(16.h),
            topRight: Radius.circular(16.h),
          ),
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 12.h,
          right: 16.h,
          child: CustomIconButton(
            height: 32.h,
            width: 32.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            onTap: onMoreTap,
            child: SvgPicture.asset(
              ImageConstant.imgMore,
              height: 32.h,
              width: 32.h,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusDropdown() {
    return CustomDropDown(
      width: 158.h,
      icon: Container(
        margin: EdgeInsets.only(left: 6.h),
        child: Icon(
          Icons.keyboard_arrow_down,
          color: appTheme.whiteA700,
          size: 16.h,
        ),
      ),
      iconSize: 16.h,
      hintText: "Pending Approval",
      items: dropdownItemList,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 12.h,
        vertical: 4.h,
      ),
      // Use OutlineInputBorder instead of BoxDecoration
      borderDecoration: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.h),
        borderSide: BorderSide(
          color: Color(0xFFC25F30),
          width: 1,
        ),
      ),
      fillColor: Color(0xFF1A1A1A),
      onChanged: (value) {
        // Handle dropdown change
      },
    );
  }

  Widget _buildTitleSection() {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      maxLines: 1, // Add this to prevent text overflow
      style: theme.textTheme.bodyLarge,
    );
  }

  Widget _buildDateSection() {
    return Row(
      mainAxisSize: MainAxisSize.min, // Add this to prevent row overflow
      children: [
        Icon(
          Icons.calendar_today_outlined,
          color: appTheme.gray500,
          size: 16.h,
        ),
        SizedBox(width: 6.h),
        Flexible( // Wrap in Flexible to handle long text
          child: Text(
            dateRange,
            style: theme.textTheme.bodySmall,
            overflow: TextOverflow.ellipsis, // Add this
            maxLines: 1, // Limit to one line
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Wrap in Flexible to give it room to shrink if needed
        Flexible(
          child: _buildAvatarStack(),
        ),
        // Ensure this text can be smaller if needed
        Flexible(
          child: Text(
            "$unfinishedTasks unfinished tasks",
            style: theme.textTheme.bodySmall,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  Widget _buildAvatarStack() {
    const maxVisibleAvatars = 2; // Reduced from 3 to 2
    int extraAvatars = avatarUrls.length > maxVisibleAvatars
        ? avatarUrls.length - maxVisibleAvatars
        : 0;

    return SizedBox(
      height: 24.h, // Reduced height
      width: avatarUrls.isEmpty ? 0 : 60.h, // Reduced width
      child: Stack(
        alignment: Alignment.centerLeft, // Changed to left alignment
        children: [
          for (int i = 0; i < min(maxVisibleAvatars, avatarUrls.length); i++)
            Positioned(
              left: i * 12.h, // Less overlap
              child: CustomImageView(
                imagePath: avatarUrls[i],
                height: 24.h, // Smaller avatars
                width: 24.h,
                radius: BorderRadius.circular(12.h),
                border: Border.all(
                  color: Colors.black,
                  width: 1.h,
                ),
                fit: BoxFit.cover,
              ),
            ),
          if (extraAvatars > 0)
            Positioned(
              left: min(maxVisibleAvatars, avatarUrls.length) * 12.h, // Position based on visible avatars
              child: Container(
                height: 24.h,
                width: 24.h,
                decoration: BoxDecoration(
                  color: appTheme.gray900,
                  borderRadius: BorderRadius.circular(12.h),
                  border: Border.all(
                    color: appTheme.gray900,
                    width: 0.6.h,
                  ),
                ),
                child: Center(
                  child: Text(
                    "+$extraAvatars",
                    style: TextStyle(
                      color: Color(0xFFFFC062),
                      fontSize: 10, // Smaller font size
                      fontWeight: FontWeight.w600,
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

  int min(int a, int b) => a < b ? a : b;
}