import 'package:flutter/material.dart';
import '../../../core/utils/image_constant.dart';
import '../../../widgets/custom_image_view.dart';

class AppHeader extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onNavItemTap;

  const AppHeader({
    super.key,
    required this.selectedIndex,
    required this.onNavItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      decoration: const BoxDecoration(
        color: Colors.black,
        border: Border(bottom: BorderSide(color: Color(0xFF262626), width: 1)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: Row(
        children: [
          // Logo on the left
          CustomImageView(
            imagePath: ImageConstant.imgLogoipsum3321,
            height: 34,
            width: 76,
          ),

          // Large spacer to push everything to the right
          Spacer(),

          // Navigation items now positioned on the right
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildNavItem('Items', selectedIndex == 0, 0),
              SizedBox(width: 32),
              _buildNavItem('Pricing', selectedIndex == 1, 1),
              SizedBox(width: 32),
              _buildNavItem('Info', selectedIndex == 2, 2),
              SizedBox(width: 32),
              _buildNavItem('Tasks', selectedIndex == 3, 3),
              SizedBox(width: 32),
              _buildNavItem('Analytics', selectedIndex == 4, 4),
            ],
          ),

          // Small spacer between nav items and icons
          SizedBox(width: 32),

          // Vertical separator line
          Container(height: 24, width: 1, color: Color(0xFF333333)),

          // Right side icons
          SizedBox(width: 32),
          IconButton(
            onPressed: () {},
            color: Colors.white,
            icon: Icon(Icons.settings_outlined),
          ),
          SizedBox(width: 24),
          IconButton(
            onPressed: () {},
            color: Colors.white,
            icon: Icon(Icons.notifications_none_outlined),
          ),
          SizedBox(width: 24),
          // Vertical separator line
          Container(height: 24, width: 1, color: Color(0xFF333333)),
          SizedBox(width: 24),
          // Profile section
          CircleAvatar(
            radius: 16,
            backgroundImage: AssetImage(ImageConstant.imgFrame77135),
          ),
          SizedBox(width: 8),
          Text(
            'John Doe',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Inter',
            ),
          ),
          SizedBox(width: 4),
          Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 16),
        ],
      ),
    );
  }

  Widget _buildNavItem(String title, bool isSelected, int index) {
    return InkWell(
      onTap: () => onNavItemTap(index),
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: SizedBox(
        height: 76, // Full header height
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Text centered vertically
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF999999),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),

            // Orange indicator at the bottom
            Positioned(
              bottom: 0, // Exactly at the bottom
              child: Container(
                height: 2,
                width: isSelected ? 40 : 0,
                color:
                    isSelected ? const Color(0xFFFFC268) : Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
