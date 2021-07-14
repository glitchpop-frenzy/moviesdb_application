import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'model/extracting_poster.dart';
import 'model/extracting_movies.dart';
import './pages/movie_detail_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.landscapeLeft])
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoviesDB Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('MoviesDB Application'),
      ),
      body: FutureBuilder<List<OverviewMovies>?>(
          future: ExtractingTopRatedMovies().extractMovies(),
          builder: (context, ss) => ss.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.teal,
                  ),
                )
              : ss.hasError
                  ? Center(
                      child: Column(
                        children: [
                          Text('Error fetching details!! Please try again.'),
                          SizedBox(height: 20),
                          TextButton(
                              onPressed: () {
                                setState(() {});
                              },
                              child: Text(
                                'Refresh',
                                style: TextStyle(color: Colors.deepPurple),
                              ))
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        List<OverviewMovies>? extractedMovies = ss.data!;
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => MovieDetailPage(
                                    selectedMovie: extractedMovies[index]),
                              ),
                            );
                            print('This is tapper');
                          },
                          child: Card(
                            color: Colors.orange[100],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 5,
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: Column(children: [
                              DecoratedBox(
                                decoration: BoxDecoration(
                                    color: Colors.orange[100],
                                    border: Border.all(),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10))),
                                child: ExtractingPoster().extractImage(
                                    extractedMovies[index].poster),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  extractedMovies[index].originalTitle,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ]),
                          ),
                        );
                      },
                      itemCount: (ss.data == null) ? 0 : ss.data!.length,
                    )),
    );
  }
}
