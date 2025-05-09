import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../models/trip_model.dart';
import '../../widgets/trip_card.dart';
import 'widgets/app_bar/appbar_leading_image.dart';
import 'widgets/app_bar/appbar_title_image.dart';
import 'widgets/app_bar/appbar_trailing_image.dart';
import 'widgets/app_bar/appbar_trailing_image_one.dart';
import 'widgets/app_bar/custom_app_bar.dart';

class TripsScreen extends StatelessWidget {
  const TripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.black900,
      appBar: _buildHeader(context),
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 16.h), // Updated from 12.h to 16.h
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 16.h),
            _buildItemsRow(context),
            SizedBox(height: 16.h), // Updated from 18.h to 16.h
            _buildTripsList(context),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildHeader(BuildContext context) {
    return CustomAppBar(
      height: 72.h,
      leadingWidth: 56.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgLinearInterface, // Menu/hamburger icon
      ),
      title: AppbarTitleImage(
        imagePath: ImageConstant.imgLogoipsum3321, // Logo image
        height: 40.h,
      ),
      centerTitle: false,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16.h),
          child: Row(
            children: [
              AppbarTrailingImage(
                imagePath: ImageConstant.imgSearch, // Settings gear icon
                height: 24.h,
                width: 24.h,
              ),
              SizedBox(width: 16.h),
              AppbarTrailingImage(
                imagePath: ImageConstant.imgIcons, // Bell/notification icon
                height: 24.h,
                width: 24.h,
              ),
              SizedBox(width: 16.h),
              // Vertical divider
              Container(
                height: 32.h,
                width: 1.h,
                color: appTheme.gray800,
              ),
              SizedBox(width: 16.h),
              // Profile image
              AppbarTrailingImageOne(
                imagePath: ImageConstant.imgFrame77135, // Profile image
                height: 36.h,
                width: 36.h,
                radius: BorderRadius.circular(18.h),
              ),
            ],
          ),
        ),
      ],
      styleType: Style.bgOutlineGray900,
    );
  }

  /// Section Widget
  Widget _buildItemsRow(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Items",
            style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontFamily: 'Inter',
            ),
          ),
          Container(
            height: 48.h,
            width: 48.h,
            decoration: BoxDecoration(
              color: Color(0xFF1E1E1E),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: CustomImageView(
                imagePath: ImageConstant.imgLinearInterfaceWhiteA700,
                height: 24.h,
                width: 24.h,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
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
            title: index == 0 ? "Item title" : trip.title, // Make the first card match the image
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
          padding: EdgeInsets.symmetric(vertical: 16.h), // Updated from 20.h to 16.h
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.h), // Added consistent padding
                leading: Icon(Icons.edit, color: appTheme.whiteA700),
                title: Text('Edit Trip', style: theme.textTheme.bodyMedium),
                onTap: () {
                  Navigator.pop(context);
                  // Handle edit action
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.h), // Added consistent padding
                leading: Icon(Icons.share, color: appTheme.whiteA700),
                title: Text('Share Trip', style: theme.textTheme.bodyMedium),
                onTap: () {
                  Navigator.pop(context);
                  // Handle share action
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.h), // Added consistent padding
                leading: Icon(Icons.delete, color: Colors.red),
                title: Text('Delete Trip', style: TextStyle(
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