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
            children: [
              _buildImageSection(),
              Padding(
                padding: EdgeInsets.all(16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
    return Container(
      width: 160.h,  // Wider to match your design
      height: 36.h,  // Taller height
      decoration: BoxDecoration(
        color: Color(0xFF1A1A1A),  // Dark background with slight transparency
        borderRadius: BorderRadius.circular(24.h),  // Very rounded corners (pill shape)
        border: Border.all(
          color: Color(0xFFC25F30),  // Orange border color
          width: 1,  // Visible border
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h),  // More horizontal padding
          child: DropdownButton<String>(
            icon: SvgPicture.asset(
              ImageConstant.imgLinearArrowChevrondown,
              height: 20.h,
              width: 20.h,
              color: appTheme.whiteA700,
            ),
            dropdownColor: Color(0xFF1A1A1A),  // Match the background
            borderRadius: BorderRadius.circular(16.h),
            style: TextStyle(
              color: appTheme.whiteA700,
              fontFamily: 'Inter',
              fontSize: 16,  // Larger text size
              fontWeight: FontWeight.w400,  // Medium weight
            ),
            isExpanded: true,
            isDense: true,
            hint: Text(
              "Pending Approval",
              style: TextStyle(
                color: appTheme.whiteA700,
                fontFamily: 'Inter',
                fontSize: 16,  // Larger text
                fontWeight: FontWeight.w400,  // Medium weight
              ),
            ),
            items: dropdownItemList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(
                    color: appTheme.whiteA700,
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              // Update your state here
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      style: theme.textTheme.bodyLarge,
    );
  }

  Widget _buildDateSection() {
    return Row(
      children: [
        Icon(
          Icons.calendar_today_outlined,
          color: appTheme.gray500,
          size: 16.h,
        ),
        SizedBox(width: 6.h),
        Text(
          dateRange,
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildBottomSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildAvatarStack(),
        Text(
          "$unfinishedTasks unfinished tasks",
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildAvatarStack() {
    const maxVisibleAvatars = 3;
    int extraAvatars = avatarUrls.length > maxVisibleAvatars
        ? avatarUrls.length - maxVisibleAvatars
        : 0;

    return SizedBox(
      height: 32.h, // Increased height to match the image
      width: avatarUrls.isEmpty ? 0 : 62.h,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          for (int i = 0; i < min(maxVisibleAvatars, avatarUrls.length); i++)
            Positioned(
              left: i * 12.h,
              child: CustomImageView(
                imagePath: avatarUrls[i],
                height: 24.h,
                width: 24.h,
                radius: BorderRadius.circular(12.h),
                border: Border.all(
                  color: Colors.black, // Dark border around avatar
                  width: 1.h,
                ),
                fit: BoxFit.cover, // Ensure proper image fit

              ),
            ),
          if (extraAvatars > 0)
            Positioned(
              right: 0,
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
                      color: Color(0xFFFFC062), // Orange-yellow color from the image
                      fontSize: 16,
                      fontWeight: FontWeight.w600, // Semi-bold
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