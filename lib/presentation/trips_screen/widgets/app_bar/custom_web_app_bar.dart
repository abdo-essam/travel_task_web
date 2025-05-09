import 'package:flutter/material.dart';
import 'package:travel_task_web/core/app_export.dart';

import '../../../../core/utils/image_constant.dart';
import '../../../../theme/theme_helper.dart';
import '../../../../widgets/custom_image_view.dart';

class CustomWebAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<String> menuItems;
  final VoidCallback? onAddNewItemPressed;
  final String? profileImagePath;
  final String? userName;
  final VoidCallback? onProfilePressed;

  const CustomWebAppBar({
    super.key,
    this.menuItems = const ["Items", "Pricing", "Info", "Tasks", "Analytics"],
    this.onAddNewItemPressed,
    this.profileImagePath,
    this.userName = "John Doe",
    this.onProfilePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 12.h),
      decoration: BoxDecoration(
        color: appTheme.black900,
        border: Border(
          bottom: BorderSide(color: appTheme.gray900, width: 1.h),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgLogoipsum3321,
                height: 40.h,
                width: 82.h,
              ),
              SizedBox(width: 64.h),
              _buildNavigationMenu(),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.settings, color: appTheme.whiteA700),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.notifications_none, color: appTheme.whiteA700),
                onPressed: () {},
              ),
              SizedBox(width: 16.h),
              VerticalDivider(color: appTheme.gray800, width: 1.h, thickness: 1.h),
              SizedBox(width: 16.h),
              _buildProfileSection(),
              SizedBox(width: 24.h),
              _buildAddNewItemButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationMenu() {
    return Row(
      children: menuItems.map((item) {
        bool isActive = item == "Items";
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                item,
                style: TextStyle(
                  color: isActive ? appTheme.whiteA700 : appTheme.gray500,
                  fontSize: 14.fSize,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 8.h),
              if (isActive)
                Container(
                  width: 24.h,
                  height: 2.h,
                  decoration: BoxDecoration(
                    color: appTheme.whiteA700,
                    borderRadius: BorderRadius.circular(1.h),
                  ),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildProfileSection() {
    return InkWell(
      onTap: onProfilePressed,
      child: Row(
        children: [
          CustomImageView(
            imagePath: profileImagePath ?? ImageConstant.imgFrame77135,
            height: 32.h,
            width: 32.h,
            radius: BorderRadius.circular(16.h),
          ),
          SizedBox(width: 8.h),
          Text(
            userName ?? "John Doe",
            style: TextStyle(
              color: appTheme.whiteA700,
              fontSize: 14.fSize,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(width: 4.h),
          Icon(
            Icons.keyboard_arrow_down,
            color: appTheme.whiteA700,
            size: 16.h,
          ),
        ],
      ),
    );
  }

  Widget _buildAddNewItemButton() {
    return ElevatedButton.icon(
      onPressed: onAddNewItemPressed,
      icon: Icon(Icons.add, size: 16.h),
      label: Text("Add a New Item"),
      style: ElevatedButton.styleFrom(
        backgroundColor: appTheme.orange200,
        foregroundColor: appTheme.black900,
        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 12.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.h),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 72.h);
}