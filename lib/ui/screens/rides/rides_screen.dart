import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_3_blabla_project/providers/ride_pref_provider.dart';
import '../../../model/ride/ride_filter.dart';
import 'widgets/ride_pref_bar.dart';

import '../../../model/ride/ride.dart';
import '../../../model/ride/ride_pref.dart';
import '../../../service/rides_service.dart';
import '../../theme/theme.dart';
import '../../../utils/animations_util.dart';
import 'widgets/ride_pref_modal.dart';
import 'widgets/rides_tile.dart';

///
///  The Ride Selection screen allow user to select a ride, once ride preferences have been defined.
///  The screen also allow user to re-define the ride preferences and to activate some filters.
///
class RidesScreen extends StatelessWidget {
   RidesScreen({super.key});

  


 final RideFilter currentFilter = RideFilter();

  List<Ride> matchingRides(RidePreference currentPreference) =>
      RidesService.instance.getRidesFor(currentPreference, currentFilter);

  void onBackPressed(BuildContext context) {
    // 1 - Back to the previous view
    Navigator.of(context).pop();
  }

  void onRidePrefSelected(
       RidePreference newPreference, BuildContext context) async {
       }

  void onPreferencePressed(
       BuildContext context, RidePreference ridePref) async {
    // Open a modal to edit the ride preferences
    RidePreference? newPreference = await Navigator.of(
      context,
    ).push<RidePreference>(
      AnimationUtils.createTopToBottomRoute(
        RidePrefModal(initialPreference: ridePref),
      ),
    );

    if (newPreference != null) {
      // 1 - Update the current preference
      context.read<RidePrefProvider>().setCurrentPreference(newPreference);

   
    }
  }

  void onFilterPressed() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  body: SafeArea(
         child: Padding(
           padding: const EdgeInsets.only(
             left: BlaSpacings.m,
             right: BlaSpacings.m,
             top: BlaSpacings.s,
           ),
           child: Consumer<RidePrefProvider>(
             builder: (context, ridePref, child) => Column(
               children: [
                 // Top search Search bar
                 RidePrefBar(
                   ridePreference: ridePref.currentPreference!,
                   onBackPressed: () => onBackPressed(context),
                   onPreferencePressed: () =>
                       onPreferencePressed(context, ridePref.currentPreference!),
                   onFilterPressed: onFilterPressed,
                 ),
         
                 Expanded(
                   child: ListView.builder(
                     itemCount: matchingRides(ridePref.currentPreference!).length,
                     itemBuilder: (ctx, index) => RideTile(
                         ride: matchingRides(ridePref.currentPreference!)[index],
                         onPressed: () {}),
                   ),
                 ),
               ],
              ),
            ),
         ),
        ),
      );
  }
}
