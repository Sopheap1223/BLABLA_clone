import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_3_blabla_project/providers/ride_pref_provider.dart';
import 'repository/mock/mock_locations_repository.dart';
import 'repository/mock/mock_rides_repository.dart';
import 'service/locations_service.dart';
import 'service/rides_service.dart';

import 'repository/mock/mock_ride_preferences_repository.dart';
import 'ui/screens/ride_pref/ride_pref_screen.dart';

import 'ui/theme/theme.dart';



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
       providers: [
         ChangeNotifierProvider(create: (context) => RidePrefProvider())
       ],
       child: MaterialApp(
         debugShowCheckedModeBanner: false,
         theme: appTheme,
         home: Scaffold(body: RidePrefScreen()),
       ),
    );
  }
}
