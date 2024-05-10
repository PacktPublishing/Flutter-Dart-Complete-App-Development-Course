import 'package:been_here_go/pages/details_screen.dart';
import 'package:been_here_go/pages/get_started.dart';
import 'package:been_here_go/pages/home_screen.dart';
import 'package:been_here_go/pages/mapview_places.dart';
import 'package:been_here_go/pages/places_screen.dart';
import 'package:been_here_go/providers/auth_provider.dart';
import 'package:been_here_go/providers/location_provider.dart';
import 'package:been_here_go/providers/places_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => PlacesProvider(),
      ),
      ChangeNotifierProvider(create: (context) => AuthProvider()),
      ChangeNotifierProvider(create: (context) => LocationProvider())
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/home': (context) => const HomePage(),
          '/places': (context) => const PlacesScreen(),
          '/details': (context) => const DetailsScreen(),
          '/places-maps': (context) => const PlacesMapView()
        },
        home: Consumer<AuthProvider>(builder: (context, value, child) {
          if (value.user == null) {
            return const GetStarted();
          } else {
            return const HomePage(); //change back to HomePage
          }
        }));
  }
}
