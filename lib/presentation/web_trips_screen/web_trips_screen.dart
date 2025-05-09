import 'package:flutter/material.dart';
import 'package:travel_task_web/presentation/web_trips_screen/widgets/WebTripCard.dart';
import '../../core/utils/image_constant.dart';
import 'widgets/app_header.dart';

class WebTripsScreen extends StatefulWidget {
  const WebTripsScreen({super.key});

  @override
  State<WebTripsScreen> createState() => _WebTripsScreenState();
}

class _WebTripsScreenState extends State<WebTripsScreen> {
  int _selectedNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            AppHeader(
              selectedIndex: _selectedNavIndex,
              onNavItemTap: (index) {
                setState(() {
                  _selectedNavIndex = index;
                });
              },
            ),

            // Content
            Expanded(
              child: _buildContent(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and add button
          Padding(
            padding: const EdgeInsets.only(top: 32, bottom: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Items',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Row(
                  children: [
                    // Filter button
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Color(0xFF111111),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.tune,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Add button
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 20,
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
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        minimumSize: Size(170, 48),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Grid of trips
          Expanded(
            child: _buildTripGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildTripGrid() {
    final trips = [
      {
        'title': 'Item title',
        'image': 'assets/images/img_rectangle_1208.png',
        'dateRange': '5 Nights (Jan 16 - Jan 20, 2024)',
        'unfinishedTasks': 4,
        'avatars': [
          ImageConstant.imgEllipse1054,
          ImageConstant.imgEllipse1055,
          ImageConstant.imgEllipse1056,
        ]
      },
      {
        'title': 'Long item title highlighted',
        'image': 'assets/images/img_rectangle_1208_182x342.png',
        'dateRange': '5 Nights (Jan 16 - Jan 20, 2024)',
        'unfinishedTasks': 4,
        'avatars': [
          ImageConstant.imgEllipse1054,
          ImageConstant.imgEllipse1055,
        ]
      },
      {
        'title': 'Item title',
        'image': 'assets/images/img_rectangle_1208.png',
        'dateRange': '5 Nights (Jan 16 - Jan 20, 2024)',
        'unfinishedTasks': 4,
        'avatars': [
          ImageConstant.imgEllipse1054,
          ImageConstant.imgEllipse1055,
          ImageConstant.imgEllipse1056,
        ]
      },
      {
        'title': 'Item title',
        'image': 'assets/images/img_rectangle_1208_182x342.png',
        'dateRange': '5 Nights (Jan 16 - Jan 20, 2024)',
        'unfinishedTasks': 4,
        'avatars': [
          ImageConstant.imgEllipse1054,
          ImageConstant.imgEllipse1055,
          ImageConstant.imgEllipse1056,
        ]
      },
      {
        'title': 'Item title',
        'image': 'assets/images/img_rectangle_1208.png',
        'dateRange': '5 Nights (Jan 16 - Jan 20, 2024)',
        'unfinishedTasks': 4,
        'avatars': [
          ImageConstant.imgEllipse1054,
          ImageConstant.imgEllipse1055,
          ImageConstant.imgEllipse1056,
        ]
      },
      {
        'title': 'Item title',
        'image': 'assets/images/img_rectangle_1208.png',
        'dateRange': '5 Nights (Jan 16 - Jan 20, 2024)',
        'unfinishedTasks': 4,
        'avatars': [
          ImageConstant.imgEllipse1054,
          ImageConstant.imgEllipse1055,
          ImageConstant.imgEllipse1056,
        ]
      },
      {
        'title': 'Item title',
        'image': 'assets/images/img_rectangle_1208_182x342.png',
        'dateRange': '5 Nights (Jan 16 - Jan 20, 2024)',
        'unfinishedTasks': 4,
        'avatars': [
          ImageConstant.imgEllipse1054,
          ImageConstant.imgEllipse1055,
        ]
      },
      {
        'title': 'Item title',
        'image': 'assets/images/img_rectangle_1208.png',
        'dateRange': '5 Nights (Jan 16 - Jan 20, 2024)',
        'unfinishedTasks': 4,
        'avatars': [
          ImageConstant.imgEllipse1054,
          ImageConstant.imgEllipse1055,
          ImageConstant.imgEllipse1056,
        ]
      },
    ];

    // Determine number of columns based on screen width
    double screenWidth = MediaQuery.of(context).size.width;
    int columns = 4;

    if (screenWidth < 1400) columns = 3;
    if (screenWidth < 1100) columns = 2;
    if (screenWidth < 700) columns = 1;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        childAspectRatio: 0.85, // Slightly taller than wide for proper card proportions
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      padding: EdgeInsets.zero,
      itemCount: trips.length,
      itemBuilder: (context, index) {
        final trip = trips[index];
        return WebTripCard(
          imageUrl: trip['image'] as String,
          title: trip['title'] as String,
          dateRange: trip['dateRange'] as String,
          unfinishedTasks: trip['unfinishedTasks'] as int,
          avatarUrls: (trip['avatars'] as List<String>),
          onCardTap: () {
            print('Tapped on ${trip['title']}');
          },
          onMoreTap: () {
            print('More options for ${trip['title']}');
          },
        );
      },
    );
  }
}