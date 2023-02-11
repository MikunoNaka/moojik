import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import './../util/format_time.dart';

class CurrentlyPlayingScreen extends StatefulWidget {
  const CurrentlyPlayingScreen({super.key});

	@override
	State<CurrentlyPlayingScreen> createState() => _CurrentlyPlayingScreenState();
}

class _CurrentlyPlayingScreenState extends State<CurrentlyPlayingScreen> {
	final player = AudioPlayer();

	PlayerState state = PlayerState.paused;
	Duration duration = Duration.zero;
	Duration position = Duration.zero;

	// TODO: remember last values
	bool _repeatMode = false;
	bool _showTimeRemaining = true;

	@override
	void initState() {
		super.initState();

    player.setReleaseMode(_repeatMode ? ReleaseMode.loop : ReleaseMode.release);
		setAudio();

		// listen to state change (playing|paused|stopped)
		player.onPlayerStateChanged.listen((newState) {
			setState(() {
				state = newState;
			});
		});

		// listen to audio duration change
		player.onDurationChanged.listen((newDuration) {
			setState(() {
				duration = newDuration;
			});
		});

		// listen to audio position change
		player.onPositionChanged.listen((newPosition) {
			setState(() {
				position = newPosition;
			});
		});
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
						ClipRRect(
							borderRadius: BorderRadius.circular(20),
							child: Image.network(
								"https://vidhukant.xyz/images/vidhukant.webp",
								width: double.infinity,
								height: 350,
								fit: BoxFit.cover,
							)
						),
						const SizedBox(height: 32),//padding
						Text(
							"Song Title",
							style: TextStyle(
								fontSize: 24,
								fontWeight: FontWeight.bold,
								color: Theme.of(context).accentColor,
							),
						),
						Text(
							"Artist Name . Album",
							style: TextStyle(
								fontSize: 18,
								color: Theme.of(context).disabledColor,
							),
						),
						Slider(
							min: 0,
							max: duration.inSeconds.toDouble(),
							value: position.inSeconds.toDouble(),
							onChanged: (value) async {},
						),
						Row(
							mainAxisAlignment: MainAxisAlignment.spaceBetween,
							children: <Widget>[
								Text(formatTime(position)),
								GestureDetector(
									child: Text(_showTimeRemaining ? formatTime(duration - position) : formatTime(duration)),
									onTap: () {
							      setState(() {
							      	_showTimeRemaining = !_showTimeRemaining;
							      });
									},
								),
							],
						),
						CircleAvatar(
							radius: 35,
						  child: IconButton(
						  	icon: Icon(
									state == PlayerState.paused ? Icons.play_arrow : (state == PlayerState.playing ? Icons.pause : Icons.replay),
						  	),
								iconSize: 50,
						  	onPressed: () async {
									switch (state) {
										case PlayerState.playing:
										  await player.pause();
										  break;
										case PlayerState.paused:
										  await player.resume();
											break;
										default:
										// TODO: replay
											break;
									}
						  	},
						  ),
						)
          ],
        ),
			),
    );
  }
}
