import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../core/app_export.dart';
import '../presentation/trips_screen/widgets/custom_icon_button.dart';

class TripCard extends StatefulWidget {
  final String? imageUrl;
  final String title;
  final String dateRange;
  final int unfinishedTasks;
  final List<String> avatarUrls;
  final VoidCallback? onCardTap;
  final VoidCallback? onMoreTap;
  final Function(String)? onStatusChanged; // Added callback for status changes

  const TripCard({
    super.key,
    this.imageUrl,
    required this.title,
    required this.dateRange,
    this.unfinishedTasks = 0,
    this.avatarUrls = const [],
    this.onCardTap,
    this.onMoreTap,
    this.onStatusChanged,
  });

  @override
  State<TripCard> createState() => _TripCardState();
}

class _TripCardState extends State<TripCard> {
  // State for the current status
  late String currentStatus;

  // Dropdown items list
  final List<String> dropdownItemList = [
    "Pending Approval",
    "Approved",
    "Rejected",
    "In Progress"
  ];

  @override
  void initState() {
    super.initState();
    currentStatus = dropdownItemList[0]; // Default to first item
  }


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onCardTap,
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
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildImageSection(), // Contains image, gradient, more button & dropdown
              Padding(
                padding: EdgeInsets.all(16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Removed _buildStatusDropdown() here since it's now in the image section
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
        // Base image
        CustomImageView(
          imagePath: widget.imageUrl ?? ImageConstant.imgRectangle1208,
          height: 188.h,
          width: double.infinity,
          radius: BorderRadius.only(
            topLeft: Radius.circular(16.h),
            topRight: Radius.circular(16.h),
          ),
          fit: BoxFit.cover,
        ),

        // Gradient overlay
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.h),
                topRight: Radius.circular(16.h),
              ),
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
          top: 12.h,
          right: 16.h,
          child: CustomIconButton(
            height: 32.h,
            width: 32.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            onTap: widget.onMoreTap,
            child: SvgPicture.asset(
              ImageConstant.imgMore,
              height: 32.h, // Reduced size to match the WebTripCard
              width: 32.h,
            ),
          ),
        ),

        // Interactive Status Dropdown
        Positioned(
          bottom: 16.h,
          left: 16.h,
          child: Container(
            padding: EdgeInsets.only(left: 12.h, right: 6.h, top: 6.h, bottom: 6.h),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFC25F30)),
              borderRadius: BorderRadius.circular(16.h),
              color: Color(0xFF1A1A1A).withOpacity(0.7),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: currentStatus,
                isDense: true,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                  size: 16.h,
                ),
                items: dropdownItemList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.fSize,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                }).toList(),
                dropdownColor: Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(8.h),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      currentStatus = newValue;
                    });
                    // Notify parent about status change
                    widget.onStatusChanged?.call(newValue);
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitleSection() {
    return Text(
      widget.title,
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
            widget.dateRange,
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
            "${widget.unfinishedTasks} unfinished tasks",
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
    int extraAvatars = widget.avatarUrls.length > maxVisibleAvatars
        ? widget.avatarUrls.length - maxVisibleAvatars
        : 0;

    return SizedBox(
      height: 24.h, // Reduced height
      width: widget.avatarUrls.isEmpty ? 0 : 60.h, // Reduced width
      child: Stack(
        alignment: Alignment.centerLeft, // Changed to left alignment
        children: [
          for (int i = 0; i < min(maxVisibleAvatars, widget.avatarUrls.length); i++)
            Positioned(
              left: i * 12.h, // Less overlap
              child: CustomImageView(
                imagePath: widget.avatarUrls[i],
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
              left: min(maxVisibleAvatars, widget.avatarUrls.length) * 12.h, // Position based on visible avatars
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