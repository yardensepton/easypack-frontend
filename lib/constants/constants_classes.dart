class BaseConstants {
  static const String baseUrl = "http://localhost:8000";
    static const String baseUrlMobile = "http://192.168.1.197:8000";

  static const int itemsPerPage = 20;
}

class Timeline {
  static const String future = "future";
    static const String past = "past";
}
class Boxes {
  static const String tripsBox = "tripsBox";
  static const String currentUserBox = "currentUserBox";
  static const String cacheFutureTripKey = 'plannedTrips_future';
  static const String cachePastTripKey = 'plannedTrips_past';

}