import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../models/trip_model.dart';
import '../../widgets/trip_card.dart';
import 'widgets/app_bar/appbar_leading_image.dart';
import 'widgets/app_bar/appbar_title_image.dart';
import 'widgets/app_bar/appbar_trailing_image.dart';
import 'widgets/app_bar/appbar_trailing_image_one.dart';
import 'widgets/app_bar/custom_app_bar.dart';
import 'widgets/custom_icon_button.dart';

class TripsScreen extends StatelessWidget {
  const TripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.black900,
      appBar: _buildHeader(context),
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 16.h),
            _buildItemsRow(context),
            SizedBox(height: 18.h),
            _buildTripsList(context),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildHeader(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 40.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgLinearInterface,
        margin: EdgeInsets.only(left: 16.h),
      ),
      title: SizedBox(
        width: double.maxFinite,
        child: AppbarTitleImage(
          imagePath: ImageConstant.imgLogoipsum3321,
          height: 40.h,
          width: 82.h,
          margin: EdgeInsets.only(left: 16.h),
        ),
      ),
      actions: [
        AppbarTrailingImage(imagePath: ImageConstant.imgSearch),
        AppbarTrailingImage(
          imagePath: ImageConstant.imgIcons,
          margin: EdgeInsets.only(left: 12.h),
        ),
        Padding(
          padding: EdgeInsets.only(left: 12.h),
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

  /// Section Widget
  Widget _buildItemsRow(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Items", style: theme.textTheme.headlineSmall),
          CustomIconButton(
            height: 40.h,
            width: 40.h,
            padding: EdgeInsets.all(10.h),
            decoration: IconButtonStyleHelper.none,
            child: CustomImageView(
              imagePath: ImageConstant.imgLinearInterfaceWhiteA700,
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
      child: Padding(
        padding: EdgeInsets.only(right: 6.h),
        child: ListView.separated(
          padding: EdgeInsets.zero,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return SizedBox(height: 16.h);
          },
          itemCount: trips.length,
          itemBuilder: (context, index) {
            final trip = trips[index];
            return TripCard(
              imageUrl: trip.imagePath,
              title: trip.title,
              dateRange: trip.dateRangeText,
              unfinishedTasks: trip.unfinishedTasks,
              avatarUrls: trip.participantAvatars,
              onCardTap: () {
                // Handle card tap
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Tapped on ${trip.title}')),
                );
              },
              onMoreTap: () {
                // Handle more options
                _showOptionsMenu(context, trip);
              },
            );
          },
        ),
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
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.edit, color: appTheme.whiteA700),
                title: Text('Edit Trip', style: theme.textTheme.bodyMedium),
                onTap: () {
                  Navigator.pop(context);
                  // Handle edit action
                },
              ),
              ListTile(
                leading: Icon(Icons.share, color: appTheme.whiteA700),
                title: Text('Share Trip', style: theme.textTheme.bodyMedium),
                onTap: () {
                  Navigator.pop(context);
                  // Handle share action
                },
              ),
              ListTile(
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