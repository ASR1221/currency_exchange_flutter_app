import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'provider/provider_controller.dart';

void main() async {
  // load the shared preferences from disk before the app is started
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  runApp(ChangeNotifierProvider(
    create: (context) => ProviderController(prefs),
    child: const MyApp(),
  ));
}

// TODO: search bar in list page
// TODO: converter page
// TODO: new details page
// TODO: currency details page
// TODO: about app page