class TripModel {
  final String id;
  final String title;
  final String imagePath;
  final String status;
  final String startDate;
  final String endDate;
  final int nights;
  final int unfinishedTasks;
  final List<String> participantAvatars;

  TripModel({
    required this.id,
    required this.title,
    required this.imagePath,
    this.status = "Pending Approval",
    required this.startDate,
    required this.endDate,
    required this.nights,
    this.unfinishedTasks = 0,
    this.participantAvatars = const [],
  });

  String get dateRangeText {
    return '$nights Nights ($startDate - $endDate)';
  }

  static List<TripModel> getDummyTrips() {
    return [
      TripModel(
        id: '1',
        title: 'Los Angeles Trip',
        imagePath: 'assets/images/img_rectangle_1208.png',
        startDate: 'Jan 16',
        endDate: 'Jan 20, 2024',
        nights: 5,
        unfinishedTasks: 4,
        participantAvatars: [
          'assets/images/img_ellipse_1054.png',
          'assets/images/img_ellipse_1055.png',
          'assets/images/img_ellipse_1056.png',
          'assets/images/img_frame_77135.png',
          'assets/images/img_ellipse_1054.png',
          'assets/images/img_ellipse_1055.png',
        ],
      ),
      TripModel(
        id: '2',
        title: 'Chicago Skyline View',
        imagePath: 'assets/images/img_rectangle_1208_182x342.png',
        startDate: 'Jan 16',
        endDate: 'Jan 20, 2024',
        nights: 5,
        unfinishedTasks: 4,
        participantAvatars: [
          'assets/images/img_ellipse_1054.png',
          'assets/images/img_ellipse_1055.png',
          'assets/images/img_ellipse_1056.png',
        ],
      ),
      TripModel(
        id: '3',
        title: 'Beach Paradise',
        imagePath: 'assets/images/img_grid.png',
        status: 'Approved',
        startDate: 'Jan 16',
        endDate: 'Jan 20, 2024',
        nights: 5,
        unfinishedTasks: 4,
        participantAvatars: [
          'assets/images/img_ellipse_1054.png',
          'assets/images/img_ellipse_1055.png',
        ],
      ),
      TripModel(
        id: '4',
        title: 'Mountain Retreat',
        imagePath: 'assets/images/img_rectangle_1208.png',
        startDate: 'Jan 16',
        endDate: 'Jan 20, 2024',
        nights: 5,
        unfinishedTasks: 4,
        participantAvatars: [
          'assets/images/img_ellipse_1054.png',
        ],
      ),
      TripModel(
        id: '5',
        title: 'City Explorer',
        imagePath: 'assets/images/img_rectangle_1208_182x342.png',
        startDate: 'Jan 16',
        endDate: 'Jan 20, 2024',
        nights: 5,
        unfinishedTasks: 4,
        participantAvatars: [],
      ),
      TripModel(
        id: '6',
        title: 'Countryside Escape',
        imagePath: 'assets/images/img_rectangle_1208.png',
        startDate: 'Jan 16',
        endDate: 'Jan 20, 2024',
        nights: 5,
        unfinishedTasks: 4,
        participantAvatars: [
          'assets/images/img_ellipse_1054.png',
          'assets/images/img_ellipse_1055.png',
          'assets/images/img_ellipse_1056.png',
          'assets/images/img_frame_77135.png',
        ],
      ),
      TripModel(
        id: '7',
        title: 'Desert Adventure',
        imagePath: 'assets/images/img_rectangle_1208_182x342.png',
        status: 'In Progress',
        startDate: 'Jan 16',
        endDate: 'Jan 20, 2024',
        nights: 5,
        unfinishedTasks: 4,
        participantAvatars: [
          'assets/images/img_ellipse_1054.png',
          'assets/images/img_ellipse_1055.png',
        ],
      ),
      TripModel(
        id: '8',
        title: 'Snowy Retreat',
        imagePath: 'assets/images/img_grid.png',
        startDate: 'Jan 16',
        endDate: 'Jan 20, 2024',
        nights: 5,
        unfinishedTasks: 4,
        participantAvatars: [
          'assets/images/img_ellipse_1054.png',
        ],
      ),
    ];
  }
}