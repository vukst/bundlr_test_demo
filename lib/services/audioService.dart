import 'package:flutter/foundation.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioService extends ChangeNotifier {
  late AudioPlayer _audioPlayer;
  double _currentPosition = 0;
  double _totalDuration = 0;
  double _playbackRate = 1.0;
  bool _isPlaying = false;
  String? _audioSource;
  String audioTitle = '';
  String audioAuthor = '';

  AudioService() {
    _audioPlayer = AudioPlayer();
  }

  double get currentPosition => _currentPosition;
  double get totalDuration => _totalDuration;
  double get playbackRate => _playbackRate;
  bool get isPlaying => _isPlaying;
  bool get audioSourcePresent => _audioSource != null;

  Future<void> setAudioSource(
      String audioFile, String audioTitle, String audioAuthor) async {
    this.audioTitle = audioTitle;
    this.audioAuthor = audioAuthor;
    try {
      await _audioPlayer.setSourceUrl(audioFile);
      _audioSource = audioFile;

      _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
        _isPlaying = state == PlayerState.playing;
        notifyListeners();
      });

      _audioPlayer.onDurationChanged.listen((Duration duration) {
        _totalDuration = duration.inSeconds.toDouble();
        notifyListeners();
      });

      _audioPlayer.onPositionChanged.listen((Duration position) {
        _currentPosition = position.inSeconds.toDouble();
        notifyListeners();
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  void reset() async {
    await _audioPlayer.stop();
    _currentPosition = 0;
    _totalDuration = 0;
    _playbackRate = 1.0;
    _isPlaying = false;
    _audioSource = null;
    notifyListeners();
  }

  void playPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.resume();
      await _audioPlayer.setPlaybackRate(_playbackRate);
    }
  }

  void seek(Duration position) async {
    await _audioPlayer.seek(position);
    notifyListeners();
  }

  void setPlaybackRate(double rate) async {
    bool wasPlaying = _isPlaying;
    _playbackRate = rate;

    if (wasPlaying) {
      await _audioPlayer.setPlaybackRate(_playbackRate);
    }

    notifyListeners();
  }

  void disposeAudioPlayer() async {
    await _audioPlayer.dispose();
  }

  @override
  void dispose() {
    disposeAudioPlayer();
    super.dispose();
  }
}
