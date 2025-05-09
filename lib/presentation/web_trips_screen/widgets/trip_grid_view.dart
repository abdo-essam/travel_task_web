import 'package:flutter/material.dart';
import 'package:travel_task_web/core/app_export.dart';
import '../../../models/trip_model.dart';
import '../../../widgets/empty_state_widget.dart';
import '../../../widgets/trip_card.dart';

class TripGridView extends StatelessWidget {
  final List<TripModel> trips;
  final Function(TripModel)? onTripTap;
  final Function(TripModel)? onMoreTap;
  final VoidCallback? onAddNewTrip;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback? onRetry;
  final int? columnCount;

  const TripGridView({
    super.key,
    required this.trips,
    this.onTripTap,
    this.onMoreTap,
    this.onAddNewTrip,
    this.isLoading = false,
    this.errorMessage,
    this.onRetry,
    this.columnCount,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(color: appTheme.orange200),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 48.h),
            SizedBox(height: 16.h),
            Text(
              errorMessage!,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              SizedBox(height: 16.h),
              ElevatedButton(onPressed: onRetry, child: Text('Retry')),
            ],
          ],
        ),
      );
    }

    if (trips.isEmpty) {
      return EmptyStateWidget(
        title: 'No Trips Found',
        message: 'Start by adding your first trip',
        buttonText: 'Add New Trip',
        onButtonPressed: onAddNewTrip,
        icon: Icons.hiking_outlined,
      );
    }

    // Calculate responsive column count if not provided
    int columns = columnCount ?? _calculateColumns(context);

    return GridView.builder(
      padding: EdgeInsets.all(16.h),
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        childAspectRatio: 0.85,
        crossAxisSpacing: 16.h,
        mainAxisSpacing: 16.h,
      ),
      itemCount: trips.length,
      itemBuilder: (context, index) {
        final trip = trips[index];
        return TripCard(
          imageUrl: trip.imagePath,
          title: trip.title,
          dateRange: trip.dateRangeText,
          unfinishedTasks: trip.unfinishedTasks,
          avatarUrls: trip.participantAvatars,
          onCardTap: () => onTripTap?.call(trip),
          onMoreTap: () => onMoreTap?.call(trip),
        );
      },
    );
  }

  int _calculateColumns(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > 1600) {
      return 5;
    } else if (screenWidth > 1400) {
      return 4;
    } else if (screenWidth > 1000) {
      return 3;
    } else if (screenWidth > 700) {
      return 2;
    } else {
      return 1;
    }
  }
}
