import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/audioService.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAudioPlayer extends StatefulWidget {
  final String audioFile;
  final String audioCover;
  final String audioTitle;
  final String audioAuthor;

  const CustomAudioPlayer({
    Key? key,
    required this.audioFile,
    required this.audioCover,
    required this.audioTitle,
    required this.audioAuthor,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomAudioPlayerState createState() => _CustomAudioPlayerState();
}

class _CustomAudioPlayerState extends State<CustomAudioPlayer> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // Initialize the audio source in the audio service
      context.read<AudioService>().setAudioSource(
          widget.audioFile, widget.audioTitle, widget.audioAuthor);
    });
  }

  @override
  Widget build(BuildContext context) {
    var audioService = Provider.of<AudioService>(context);
    const String folderPath = 'assets/skipbackward.svg';
    final Widget skipBackward = SvgPicture.asset(
      folderPath,
      width: 55,
      height: 55,
    );

    const String path = 'assets/skipforward.svg';
    final Widget skipForward = SvgPicture.asset(
      path,
      width: 55,
      height: 55,
    );
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Center(
            child: Image.network(
              widget.audioCover,
              fit: BoxFit.cover,
              height: 185.0,
              width: 185.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.audioTitle,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 53, 70, 23),
                  fontSize: 20.0),
            ),
          ),
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: const Color.fromARGB(222, 88, 169, 113),
            inactiveTrackColor: const Color.fromARGB(255, 212, 230, 215),
            trackShape: const RectangularSliderTrackShape(),
            trackHeight: 15.0,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0.0),
          ),
          child: Slider(
            value: audioService.currentPosition,
            max: audioService.totalDuration,
            onChanged: (value) {
              audioService.seek(Duration(seconds: value.toInt()));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(_formatDuration(
                  Duration(seconds: audioService.currentPosition.toInt()))),
              Text(_formatDuration(
                  Duration(seconds: audioService.totalDuration.toInt()))),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0, top: 20.0),
          child: Stack(
            children: <Widget>[
              // This centers the control buttons
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        audioService.seek(Duration(
                            seconds:
                                (audioService.currentPosition - 15).toInt()));
                      },
                      child: skipBackward,
                    ),
                    Transform.scale(
                      scale:
                          2, // Increase the scale factor to enlarge the play button
                      child: IconButton(
                        icon: Icon(audioService.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow),
                        onPressed: () {
                          audioService.playPause();
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        audioService.seek(Duration(
                            seconds:
                                (audioService.currentPosition + 30).toInt()));
                      },
                      child: skipForward,
                    ),
                  ],
                ),
              ),

              // This aligns the playback multiplier button to the far right
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 10.0), // You can adjust this as needed
                  child: Transform.scale(
                    scale:
                        1.2, // Increase the scale factor to enlarge the playback speed button
                    child: IconButton(
                      icon: Text('${audioService.playbackRate}X'),
                      onPressed: () {
                        double playbackRate = audioService.playbackRate;
                        if (playbackRate == 1.0) {
                          playbackRate = 1.5;
                        } else if (playbackRate == 1.5) {
                          playbackRate = 2.0;
                        } else if (playbackRate == 2.0) {
                          playbackRate = 0.5;
                        } else if (playbackRate == 0.5) {
                          playbackRate = 1.0;
                        }
                        audioService.setPlaybackRate(playbackRate);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void dispose() {
    super.dispose();
  }
}
