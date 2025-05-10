import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../models/trip_model.dart';
import '../../widgets/trip_card.dart';
import 'widgets/app_bar/appbar_leading_image.dart';
import 'widgets/app_bar/appbar_title_image.dart';
import 'widgets/app_bar/appbar_trailing_image.dart';
import 'widgets/app_bar/appbar_trailing_image_one.dart';
import 'widgets/app_bar/custom_app_bar.dart';
import 'widgets/mobile_navigation_drawer.dart';

class TripsScreen extends StatefulWidget {
  const TripsScreen({super.key});

  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  bool _isDrawerOpen = false;
  int _selectedNavIndex = 0; // Items selected by default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.black900,
      body: SafeArea(
        child: Row(
          children: [
            // Side navigation drawer (only shown if drawer is open)
            if (_isDrawerOpen)
              MobileNavigationDrawer(
                selectedIndex: _selectedNavIndex,
                onItemSelected: (index) {
                  setState(() {
                    _selectedNavIndex = index;
                    _isDrawerOpen = false; // Close drawer after selection
                  });
                },
                onClose: () {
                  setState(() {
                    _isDrawerOpen = false; // Close drawer when close button is pressed
                  });
                },
              ),

            // Main content
            Expanded(
              child: Scaffold(
                backgroundColor: appTheme.black900,
                appBar: _buildHeader(context),
                body: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: 16.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(height: 16.h),
                      _buildItemsRow(context),
                      SizedBox(height: 16.h),
                      _buildTripsList(context),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget - Header with CustomAppBar
  PreferredSizeWidget _buildHeader(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 40.h,
      // Only show the menu icon when drawer is closed
      leading: _isDrawerOpen
          ? null  // No leading widget when drawer is open
          : AppbarLeadingImage(
        imagePath: ImageConstant.imgLinearInterface,
        margin: EdgeInsets.only(left: 16.h),
        onTap: () {
          setState(() {
            _isDrawerOpen = true; // Open drawer
          });
        },
      ),
      title: SizedBox(
        width: double.maxFinite,
        child: AppbarTitleImage(
          imagePath: ImageConstant.imgLogoipsum3321,
          height: 40.h,
          width: 82.h,
          margin: EdgeInsets.only(left: _isDrawerOpen ? 0 : 16.h),
        ),
      ),
      actions: [
        AppbarTrailingImage(imagePath: ImageConstant.imgSettings),
        AppbarTrailingImage(
          imagePath: ImageConstant.imgNotification,
          margin: EdgeInsets.only(left: 12.h),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(12, 32, 0, 32),
          child: VerticalDivider(
            width: 1.h,
            thickness: 1.h,
            color: appTheme.gray800,
          ),
        ),
        AppbarTrailingImageOne(
          imagePath: ImageConstant.imgFrame77135,
          height: 32.h,
          width: 32.h,
          margin: EdgeInsets.only(left: 11.h, right: 15.h),
        ),
      ],
      styleType: Style.bgOutlineGray900,
    );
  }

  /// Section Widget - Fixed Items Row with responsive button
  Widget _buildItemsRow(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          // Determine if we should use a compact layout
          bool isCompact = constraints.maxWidth < 350;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "Items",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontFamily: 'Inter',
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 8.h),
              isCompact
                  ? IconButton(
                onPressed: () {},
                icon: Icon(Icons.add, color: Colors.black),
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0xFFFFC268),
                  shape: CircleBorder(),
                ),
              )
                  : ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 16,
                ),
                label: Text(
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
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          );
        }
    );
  }

  /// Section Widget
  Widget _buildTripsList(BuildContext context) {
    // Get dummy trips data
    final trips = TripModel.getDummyTrips();

    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
        physics: BouncingScrollPhysics(),
        itemCount: trips.length,
        separatorBuilder: (context, index) {
          return SizedBox(height: 16.h);
        },
        itemBuilder: (context, index) {
          final trip = trips[index];
          return TripCard(
            imageUrl: trip.imagePath,
            title: index == 0 ? "Item title" : trip.title,
            dateRange: index == 0 ? "5 Nights (Jan 16 - Jan 20, 2024)" : trip.dateRangeText,
            unfinishedTasks: index == 0 ? 4 : trip.unfinishedTasks,
            avatarUrls: trip.participantAvatars,
            onCardTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Tapped on ${trip.title}')),
              );
            },
            onMoreTap: () {
              _showOptionsMenu(context, trip);
            },
          );
        },
      ),
    );
  }

  void _showOptionsMenu(BuildContext context, TripModel trip) {
    showModalBottomSheet(
      context: context,
      backgroundColor: appTheme.gray90001,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.h)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.h),
                leading: Icon(Icons.edit, color: appTheme.whiteA700),
                title: Text('Edit Item', style: theme.textTheme.bodyMedium),
                onTap: () {
                  Navigator.pop(context);
                  // Handle edit action
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.h),
                leading: Icon(Icons.share, color: appTheme.whiteA700),
                title: Text('Share Item', style: theme.textTheme.bodyMedium),
                onTap: () {
                  Navigator.pop(context);
                  // Handle share action
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.h),
                leading: Icon(Icons.delete, color: Colors.red),
                title: Text('Delete Item', style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.fSize,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                )),
                onTap: () {
                  Navigator.pop(context);
                  // Handle delete action
                },
              ),
            ],
          ),
        );
      },
    );
  }
}