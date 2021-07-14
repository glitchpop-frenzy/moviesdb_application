import 'package:flutter/material.dart';
import '../model/extract_yt_code.dart';
import 'package:moviesdb_application/pages/video_screen.dart';

class PlayButton extends StatefulWidget {
  final int? id;
  const PlayButton({Key? key, this.id}) : super(key: key);

  @override
  _PlayButtonState createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.indigo[100])),
      onPressed: () async {
        String? url;
        setState(() {
          _isLoading = true;
        });
        url = await ExtractTrailerCode().extractTrailer(widget.id!);
        if (url != null) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => VideoScreen(id: url)));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Error fetching video!! Please try agan later.')));
        }
        setState(() {
          _isLoading = false;
        });

        Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        );
      },
      child: Container(
        width: 150,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: _isLoading
            ? CircularProgressIndicator(color: Colors.black)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.play_circle,
                    color: Colors.black,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Play Trailer',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  )
                ],
              ),
      ),
    );
  }
}
