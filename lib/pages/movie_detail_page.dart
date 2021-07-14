import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/extracting_movies.dart';
import '../model/extracting_poster.dart';
import '../widgets/play_button.dart';

class MovieDetailPage extends StatelessWidget {
  final OverviewMovies? selectedMovie;

  const MovieDetailPage({Key? key, this.selectedMovie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              )),
          backgroundColor: Colors.black87,
          title: Text(
            '${selectedMovie!.originalTitle}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Container(
          color: Colors.purple[50],
          height: MediaQuery.of(context).size.height * 0.95,
          child: SingleChildScrollView(
            child: Column(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ExtractingPoster().extractImage(selectedMovie!.poster),
                ),
                // SizedBox(height: 10),
                ListTile(
                  leading: Text(
                    'Title : ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  title: Text('${selectedMovie!.originalTitle}'),
                ),
                // SizedBox(height: 10),
                ListTile(
                  leading: Text(
                    'Overview : ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  title: Text('${selectedMovie!.overview}'),
                ),
                // SizedBox(height: 10),
                ListTile(
                  leading: Text(
                    'Release Date : ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  title: Text('${selectedMovie!.releaseDate}'),
                ),
                // SizedBox(height: 10),
                ListTile(
                  leading: Text(
                    'Adult : ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  title: Text(selectedMovie!.adult == false ? 'No' : 'Yes'),
                ),
                // SizedBox(height: 10),
                ListTile(
                  leading: Text(
                    'Popularity : ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  title: Text('${selectedMovie!.popularity.toString()}'),
                ),
                // SizedBox(height: 10),
                ListTile(
                  leading: Text(
                    'Total Votes : ${selectedMovie!.voteCount.toString()}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  trailing: Text(
                    'Average Rating : ${selectedMovie!.voteAvg.toString()}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 60),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: PlayButton(
          id: selectedMovie!.movieId,
        ));
  }
}
