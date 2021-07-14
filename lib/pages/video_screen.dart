import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:video_player/video_player.dart';
// import '../widgets/video_player_widget.dart';

class VideoScreen extends StatefulWidget {
  final String? id;

  const VideoScreen({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late YoutubePlayerController _controller;
  late VideoPlayerController _playerController;
  late TextEditingController _idController;
  late TextEditingController _seekController;

  PlayerState? _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  @override
  void initState() {
    String? _vidId = widget.id;
    _controller = YoutubePlayerController(initialVideoId: _vidId!)
      ..addListener(listener);

    // _playerController =
    //     VideoPlayerController.network('www.youtube.com/watch?v=$_vidId')
    //       ..addListener(() => setState(() {}))
    //       ..setLooping(false)
    //       ..initialize().then((_) => _playerController.play());
    // _controller.toggleFullScreenMode();
    print('www.youtube.com/watch?v=$_vidId');

    _idController = TextEditingController();
    _seekController = TextEditingController();
    _videoMetaData = YoutubeMetaData();
    _playerState = PlayerState.unknown;
    super.initState();
  }

  void listener() {
    if (_isPlayerReady && mounted) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          aspectRatio: 16 / 9,
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueGrey,
          topActions: <Widget>[
            IconButton(
                onPressed: () {
                  SystemChrome.setPreferredOrientations(
                      [DeviceOrientation.portraitUp]);
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                )),
            SizedBox(width: 8),
            Expanded(
                child: Text(
              '${_controller.metadata.title}',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(color: Colors.white, fontSize: 18),
            )),
          ],
          onReady: () => _isPlayerReady = true,
          onEnded: (ytMeta) {
            Navigator.of(context).pop();
          },
        ),
        builder: (context, player) {
          // SystemChrome.setPreferredOrientations(
          //     [DeviceOrientation.landscapeLeft]);
          return Scaffold(
            body: player,
          );
        });
  }
}
