import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import './screens/home.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
	const App({Key? key}) : super(key: key);

	@override
	State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  static final _defaultLightColorScheme =
    ColorScheme.fromSwatch(primarySwatch: Colors.blue);

  static final _defaultDarkColorScheme = ColorScheme.fromSwatch(
    primarySwatch: Colors.blue, brightness: Brightness.dark);

	@override
	Widget build(BuildContext context) {
		return DynamicColorBuilder(
			builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
				return MaterialApp(
					title: "Moojik",
					themeMode: ThemeMode.system,
					//home: CurrentlyPlayingScreen(),
					home: HomeScreen(),
					theme: ThemeData(
						colorScheme: lightDynamic ?? _defaultLightColorScheme,
						useMaterial3: true,
					),
					darkTheme: ThemeData(
						colorScheme: darkDynamic ?? _defaultDarkColorScheme,
						useMaterial3: true,
					),
				);
			}
		);
	}
}
