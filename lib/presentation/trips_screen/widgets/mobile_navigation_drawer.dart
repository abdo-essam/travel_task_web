import 'package:flutter/material.dart';
import 'package:travel_task_web/core/app_export.dart';

class MobileNavigationDrawer extends StatelessWidget {
  final int selectedIndex;
  final Function(int)? onItemSelected;
  final VoidCallback onClose; // Added close callback

  const MobileNavigationDrawer({
    super.key,
    this.selectedIndex = 0,
    this.onItemSelected,
    required this.onClose, // Make this required
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240.h,
      decoration: BoxDecoration(
        color: appTheme.gray90001,
        border: Border(
          right: BorderSide(color: appTheme.gray900, width: 1.h),
        ),
      ),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildNavItem(
                  icon: Icons.inventory_2_outlined,
                  title: 'Items',
                  index: 0,
                ),
                _buildNavItem(
                  icon: Icons.attach_money_outlined,
                  title: 'Pricing',
                  index: 1,
                ),
                _buildNavItem(
                  icon: Icons.info_outlined,
                  title: 'Info',
                  index: 2,
                ),
                _buildNavItem(
                  icon: Icons.task_alt_outlined,
                  title: 'Tasks',
                  index: 3,
                ),
                _buildNavItem(
                  icon: Icons.analytics_outlined,
                  title: 'Analytics',
                  index: 4,
                ),
                _buildDivider(),
                _buildNavItem(
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  index: 5,
                ),
                _buildNavItem(
                  icon: Icons.help_outline,
                  title: 'Help',
                  index: 6,
                ),
              ],
            ),
          ),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: appTheme.gray900, width: 1.h),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomImageView(
              imagePath: ImageConstant.imgLogoipsum3321,
              height: 40.h,
              width: 82.h,
            ),
          ),
          // Add a close drawer button
          IconButton(
            icon: Icon(
              Icons.menu_open,
              color: Colors.white,
              size: 24.h,
            ),
            onPressed: onClose,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
        ],
      ),
    );
  }

  // Rest of the code remains the same...
  Widget _buildNavItem({
    required IconData icon,
    required String title,
    required int index,
  }) {
    final bool isSelected = selectedIndex == index;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onItemSelected?.call(index),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.h,
            vertical: 12.h,
          ),
          decoration: BoxDecoration(
            color: isSelected ? appTheme.deepOrange800.withOpacity(0.1) : Colors.transparent,
            border: Border(
              left: BorderSide(
                color: isSelected ? appTheme.orange200 : Colors.transparent,
                width: 4.h,
              ),
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected ? appTheme.orange200 : appTheme.gray500,
                size: 20.h,
              ),
              SizedBox(width: 16.h),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? appTheme.orange200 : appTheme.whiteA700,
                    fontSize: 14.fSize,
                    fontFamily: 'Inter',
                    fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (title == 'Tasks')
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.h,
                    vertical: 2.h,
                  ),
                  decoration: BoxDecoration(
                    color: appTheme.deepOrange800,
                    borderRadius: BorderRadius.circular(10.h),
                  ),
                  child: Text(
                    '4',
                    style: TextStyle(
                      color: appTheme.whiteA700,
                      fontSize: 12.fSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Divider(
        color: appTheme.gray900,
        height: 1.h,
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: appTheme.gray900, width: 1.h),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16.h,
            backgroundImage: AssetImage(ImageConstant.imgFrame77135),
          ),
          SizedBox(width: 12.h),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'John Doe',
                  style: TextStyle(
                    color: appTheme.whiteA700,
                    fontSize: 14.fSize,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'john.doe@example.com',
                  style: TextStyle(
                    color: appTheme.gray500,
                    fontSize: 12.fSize,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.logout,
              color: appTheme.gray500,
              size: 20.h,
            ),
            onPressed: () {
              // Log out functionality
            },
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
        ],
      ),
    );
  }
}