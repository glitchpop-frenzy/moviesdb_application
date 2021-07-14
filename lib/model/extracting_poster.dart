import 'package:flutter/material.dart';

class ExtractingPoster {
  Image extractImage(String posterPath) {
    return Image.network(
      'https://image.tmdb.org/t/p/w500/$posterPath',
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProcess) {
        if (loadingProcess == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        );
      },
    );
  }
}
