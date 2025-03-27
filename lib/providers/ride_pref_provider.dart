import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:week_3_blabla_project/model/ride/ride_pref.dart';
import 'package:week_3_blabla_project/repository/mock/mock_ride_preferences_repository.dart';


class RidePrefProvider extends ChangeNotifier {
  MockRidePreferencesRepository ridePreferencesRepository =
       MockRidePreferencesRepository();
  RidePreference? _currentPreference;
   RidePreference? get currentPreference => _currentPreference;
  final List<RidePreference> _pastPreference = [];
   // return the list of past pref
   List<RidePreference> preferencesHistory() =>
       _pastPreference.reversed.toList();
 
   void setCurrentPreference(RidePreference ridePreference) {
       if (_currentPreference == ridePreference) {
       _insertRecentRidePrefToHistory(ridePreference)
           ? Logger().d('Past Preference add successfully')
           : Logger().d('Past Preference already exists');
     } else {
       _currentPreference = ridePreference;
       _insertRecentRidePrefToHistory(ridePreference)
           ? Logger().d('Past Preference add successfully')
           : Logger().d('Past Preference already exists');
     }
     notifyListeners();
   }
   bool _insertRecentRidePrefToHistory(RidePreference ridePref) {
     if (_pastPreference.contains(ridePref)) {
       _pastPreference.removeWhere((pastPref) => ridePref == pastPref);
       _pastPreference.add(ridePref);
       Logger().d('re index successfully');
       return false;
     } else {
       _pastPreference.add(ridePref);
       Logger().d('ride pref added');
       return true;
     }
   }
 
 
}