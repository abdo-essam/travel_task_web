import 'package:flutter/material.dart';
import '../../core/app_export.dart';

class WebTripsScreen extends StatefulWidget {
  const WebTripsScreen({super.key});

  @override
  State<WebTripsScreen> createState() => _WebTripsScreenState();
}

class _WebTripsScreenState extends State<WebTripsScreen> {
  int _selectedNavIndex = 1; // Trips section selected by default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Row(
          children: [
            // Main content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  _buildHeader(),
                  // Content
                  Expanded(
                    child: _buildContent(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 76,
      padding: const EdgeInsets.symmetric(horizontal: 32), // Use proper padding
      decoration: const BoxDecoration(
        color: Colors.black,
        border: Border(
          bottom: BorderSide(color: Color(0xFF262626), width: 1),
        ),
      ),
      child: Row(
        children: [
          // Logo
          CustomImageView(
            imagePath: ImageConstant.imgLogoipsum3321,
            height: 40,
            width: 82,
          ),

          const Spacer(),

          // Navigation with orange underline for selected item
          Container(
            color: Colors.pink,
            child: Row(
              children: [
                _buildNavItem('Items', _selectedNavIndex == 0, 0),
                const SizedBox(width: 28),
                _buildNavItem('Pricing', _selectedNavIndex == 1, 1),
                const SizedBox(width: 28),
                _buildNavItem('Info', _selectedNavIndex == 2, 2),
                const SizedBox(width: 28),
                _buildNavItem('Tasks', _selectedNavIndex == 3, 3),
                const SizedBox(width: 28),
                _buildNavItem('Analytics', _selectedNavIndex == 4, 4),
              ],
            ),
          ),
          const SizedBox(width: 28),

          // Right icons with proper spacing - using MaterialIcons directly since SVG paths might be wrong
          Icon(
            Icons.settings_outlined,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(width: 18),
          Icon(
            Icons.notifications_none_outlined,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(width: 18),

          // Profile
          Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundImage: AssetImage(ImageConstant.imgFrame77135),
              ),
              const SizedBox(width: 8),
              const Text(
                'John Doe',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
                size: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }

// Helper method to build clickable navigation items with correct underline position
  Widget _buildNavItem(String title, bool isSelected, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedNavIndex = index;
        });
      },
      hoverColor: Colors.transparent,
      // No hover color
      splashColor: Colors.transparent,
      // No splash effect
      highlightColor: Colors.transparent,
      // No highlight effect
      child: SizedBox(
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF999999),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
            // Using Spacer to push the underline to the bottom
            Spacer(),
            // Orange underline at the bottom
            Container(
              height: 2,
              width: isSelected ? 40 : 0, // Only show when selected
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFFFC268) : Colors
                    .transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and add button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Items',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),

              // Add button
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 16,
                ),
                label: const Text(
                  'Add a New Item',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFC268),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Grid of trips
          Expanded(
            child: _buildSimpleGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleGrid() {
    // Create a basic list of trip data
    final trips = [
      {
        'title': 'Los Angeles Trip',
        'image': 'assets/images/img_rectangle_1208.png'
      },
      {
        'title': 'Chicago Skyline View',
        'image': 'assets/images/img_rectangle_1208_182x342.png'
      },
      {
        'title': 'Mountain Retreat',
        'image': 'assets/images/img_rectangle_1208.png'
      },
      {
        'title': 'City Explorer',
        'image': 'assets/images/img_rectangle_1208_182x342.png'
      },
      {
        'title': 'Countryside Escape',
        'image': 'assets/images/img_rectangle_1208.png'
      },
      {
        'title': 'Desert Adventure',
        'image': 'assets/images/img_rectangle_1208_182x342.png'
      },
    ];

    // Determine the number of columns based on screen width
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    int columns = 4;

    if (screenWidth < 1200) {
      columns = 3;
    }
    if (screenWidth < 900) {
      columns = 2;
    }
    if (screenWidth < 600) {
      columns = 1;
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        childAspectRatio: 1.1,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: trips.length,
      itemBuilder: (context, index) {
        return _buildSimpleTripCard(
          title: trips[index]['title'] ?? '',
          imagePath: trips[index]['image'] ?? '',
        );
      },
    );
  }

  Widget _buildSimpleTripCard(
      {required String title, required String imagePath}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF171717),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Image.asset(
                  imagePath,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade600,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFC25F30)),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Pending Approval',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Inter',
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                        size: 16,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Title
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Inter',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 6),

                // Date
                const Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      color: Color(0xFF999999),
                      size: 14,
                    ),
                    SizedBox(width: 6),
                    Text(
                      '5 Nights (Jan 16 - Jan 20, 2024)',
                      style: TextStyle(
                        color: Color(0xFF999999),
                        fontSize: 12,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                const Divider(color: Color(0xFF262626)),
                const SizedBox(height: 12),

                // Tasks
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '4 unfinished tasks',
                      style: TextStyle(
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
        ],
      ),
    );
  }
}