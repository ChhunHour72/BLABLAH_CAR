import 'package:blabla/model/ride/ride.dart';

import '../lib/data/dummy_data.dart';
import '../lib/model/ride_pref/ride_pref.dart';

abstract class RidePreferencesListener {
  void onRidePreferenceSelected(RidePref selectedRidePreference);
}

class RidePrefsService {
  RidePref? selectedRidePref; 
  static List<RidePref> ridePrefsHistory = fakeRidePrefs;
  final List<RidePreferencesListener> _listener = [];

  RidePrefsService({this.selectedRidePref});

  void addListener(RidePreferencesListener listener) {
    _listener.add(listener);
  }

  void setRidePref(RidePref newRidePref) {
    if (newRidePref != selectedRidePref) {
      selectedRidePref = newRidePref;
      _notifyListener();
    }
  }

  void _notifyListener() {
    for (RidePreferencesListener listener in _listener) {
      listener.onRidePreferenceSelected(selectedRidePref!);
    }
  }
}

class ConsoleLogger extends RidePreferencesListener {
  ConsoleLogger(this.myRidePrefs) {
    myRidePrefs.addListener(this);
  }

  final RidePrefsService myRidePrefs;

  @override
  void onRidePreferenceSelected(RidePref selectedRidePreference) {
    print('My ride: ${selectedRidePreference.toString()}');
  }
}

void main() {
  RidePrefsService myRide = new RidePrefsService();
  ConsoleLogger consoleLogger = ConsoleLogger(myRide);

  for (var pref in RidePrefsService.ridePrefsHistory) {
    myRide.setRidePref(pref);
  }
}
