import 'package:flutter/material.dart';
import 'package:flutter_youtube_view/flutter_youtube_view.dart';

class YoutubeCustomWidget extends StatefulWidget {
  YoutubeCustomWidget({required this.video});
  final String? video;
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<YoutubeCustomWidget>
    implements YouTubePlayerListener {
  double _volume = 50;
  double _videoDuration = 0.0;
  double _currentVideoSecond = 0.0;
  String _playerState = "";
  late FlutterYoutubeViewController _controller;
  YoutubeScaleMode _mode = YoutubeScaleMode.none;
  PlaybackRate _playbackRate = PlaybackRate.RATE_1;
  bool _isMuted = false;

  @override
  void onCurrentSecond(double second) {
    // print("onCurrentSecond second = $second");
    _currentVideoSecond = second;
  }

  @override
  void onError(String error) {
    print("onError error = $error");
  }

  @override
  void onReady() {
    print("onReady");
  }

  @override
  void onStateChange(String state) {
    print("onStateChange state = $state");
    setState(() {
      _playerState = state;
    });
  }

  @override
  void onVideoDuration(double duration) {
    print("onVideoDuration duration = $duration");
  }

  void _onYoutubeCreated(FlutterYoutubeViewController controller) {
    this._controller = controller;
  }

  bool play = true;
  void _play() {
    setState(() {
      print('vvvvv');
      if (play == false) {
        _controller.play().whenComplete(() => play = true);
      } else {
        _controller.pause().whenComplete(() => play = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _play();
      },
      child: Container(
        // color: Colors.red,
        height: 200,
        width: MediaQuery.of(context).size.width / 1.4,
        child: Stack(
          children: <Widget>[
            Container(
                child: FlutterYoutubeView(
              scaleMode: _mode,
              onViewCreated: _onYoutubeCreated,
              listener: this,
              params: YoutubeParam(
                videoId: '${widget.video}',
                showUI: true,
                startSeconds: 0.0,
                autoPlay: true,
                showYoutube: true,
                showFullScreen: false,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
