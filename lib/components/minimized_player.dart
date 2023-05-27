import 'package:flutter/material.dart';
import '../services/audioService.dart';
import 'package:provider/provider.dart';

class MinimizedPlayer extends StatefulWidget {
  final String? audioTitle;
  final String? audioAuthor;
  const MinimizedPlayer({
    super.key,
    required this.audioTitle,
    required this.audioAuthor,
  });

  // ignore: library_private_types_in_public_api
  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _MinimizedPlayerState createState() => _MinimizedPlayerState();
}

class _MinimizedPlayerState extends State<MinimizedPlayer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var audioPlayer = Provider.of<AudioService>(context);
    return Visibility(
      visible: audioPlayer.audioSourcePresent,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            widget.audioAuthor!,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 107, 96, 61),
                              fontSize: 13.0,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.audioTitle!,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 107, 96, 61),
                              fontSize: 17.0,
                            ),
                          ),
                        ]),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(audioPlayer.isPlaying == true
                            ? Icons.pause
                            : Icons.play_arrow),
                        onPressed: () {
                          audioPlayer.playPause();
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          audioPlayer.reset();
                        },
                      ),
                    ],
                  ),
                ],
              ),
              LinearProgressIndicator(
                value: audioPlayer.totalDuration > 0
                    ? audioPlayer.currentPosition / audioPlayer.totalDuration
                    : 0,
                color: const Color.fromARGB(255, 72, 162, 101),
                backgroundColor: const Color.fromARGB(255, 200, 227, 209),
                minHeight: 5.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
