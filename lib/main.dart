import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playerprofile/Authentication/Manager.dart';
import 'package:playerprofile/Authentication/login.dart';
import 'package:playerprofile/Dashboard/ClubInformation/clubController.dart';
import 'package:provider/provider.dart';

import 'Authentication/auth.dart';
import 'Authentication/user.dart';
import 'Dashboard/MainScreens/dashboard.dart';
import 'Dashboard/MainScreens/dashboardController.dart';
import 'Dashboard/PlayerInformation/playerController.dart';
import 'Dashboard/Trophies/trophyController.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //firebase initialization
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      initialData: null,
      value: AuthanticateUser().user,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: DashboardController()),
          ChangeNotifierProvider.value(value: ClubData()),
          ChangeNotifierProvider.value(value: PlayerData()),
          ChangeNotifierProvider.value(value: TrophyData()),
          ChangeNotifierProvider.value(value: UserType()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: "com",

          ),
          home: Wrapper(),
        ),
      ),
    );
  }
}

