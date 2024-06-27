import 'package:hive/hive.dart';

class TripsBox {
  late Box<Map> tripsBox;

  // Future<void> initBox() async {
  //   Hive.registerAdapter(TripInfoAdapter());
  //   tripsBox = await Hive.openBox<Map>('tripsBox');
  }

  // Box<TripInfo> getBox() {
  //   return Hive.box<TripInfo>(tripsBox);
  // }

  //  Future<void> cacheData(String key, List<TripInfo> value) async {
  //   await tripsBox.put(key, value);
  // }

  // TripInfo? getCachedData(String key) {
  //   return tripsBox.get(key);
  // }

  // Future<void> clearCache(String key) async {
  //   await tripsBox.delete(key);
  // }

