import 'package:flutter/material.dart';
import "./currently_playing.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
				margin: const EdgeInsets.only(left: 10.0, right: 10.0),
				child: Column(
				  mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Moojik',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              'Horrible name for a music player',
            ),
						ElevatedButton (
							child: const Text("Currently Playing"),
							onPressed: () {
								Navigator.push(context,MaterialPageRoute(builder: (context) => const CurrentlyPlayingScreen()));
							},
						),
          ],
        ),
			),
    );
  }
}
