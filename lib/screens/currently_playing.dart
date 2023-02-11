import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';


class CurrentlyPlayingScreen extends StatefulWidget {
  const CurrentlyPlayingScreen({super.key});

	@override
	State<CurrentlyPlayingScreen> createState() => _CurrentlyPlayingScreenState();
}

class _CurrentlyPlayingScreenState extends State<CurrentlyPlayingScreen> {
	final player = AudioPlayer();
	bool isPlaying = false;
	bool repeatMode = false;
	Duration duration = Duration.zero;
	Duration position = Duration.zero;

	@override
	void initState() {
		super.initState();

    player.setReleaseMode(repeatMode ? ReleaseMode.loop : ReleaseMode.release);
		setAudio();

		// listen to state change (playing|paused|stopped)
		player.onPlayerStateChanged.listen((state) {
			setState(() {
				isPlaying = state == PlayerState.playing;
			});
		});

		// listen to audio duration change
		player.onDurationChanged.listen((newDuration) {
			setState(() {
				duration = newDuration;
			});
		});

		// listen to audio position change
		//player.onAudioPositionChanged.listen((newPosition) {
		//	setState(() {
		//		position = newPosition;
		//	});
		//});
	}

	@override
	void dispose() {
		player.dispose();
		super.dispose();
	}

	Future setAudio() async {
		// load audio from URL
		String url = "https://gand-ko-khatra.weeb-developerz.xyz/audio.mp3";
		player.setSourceUrl(url);

		// final file = File(...);
		// player.seturl(file.path, isLocal: true);
	}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Currently Playing")),
      body: Container(
				margin: const EdgeInsets.only(left: 10.0, right: 10.0),
				child: Column(
				  mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Demo Song',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
						ElevatedButton (
							child: Text(isPlaying ? "Pause" : "Play"),
							onPressed: () async {
								if (isPlaying) {
									await player.pause();
								} else {
									await player.resume();
								}
							},
						),
          ],
        ),
			),
    );
  }
}
