import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './movie_Detail.dart';

// create a function that fetches our list of movies from the
// MovieDb Api
Future<Map> fetchAllMovies() async {
  final String url =
      "http://api.themoviedb.org/3/discover/movie?api_key=98d4ab8983c3a5727df9ab4f565f5f4a";
  final response = await http.get(url);

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    print('response from server was ${response.body}');
    return json.decode(response.body);
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}

class MovieGrid extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MovieGridState();
  }
}

class MovieGridState extends State<MovieGrid> {
  var _movies;

  void _getData() async {
    var data = await fetchAllMovies();
    setState(() {
      _movies = data['results'];
    });
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      home: Scaffold(
          appBar: AppBar(
            title: Text(
              'Movies',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            backgroundColor: Colors.redAccent,
            centerTitle: true,
          ),
          body:
              _movies.length == null ? _circularIndicator() : _Movies(_movies)),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _Movies(var movies) {
    final String imageUrl = 'https://image.tmdb.org/t/p/w500/';
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: movies.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          margin: EdgeInsets.all(3),
          child: Hero(
              tag: movies[index]['title'],
              child: Material(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MovieDetail(movies[index])),
                    );
                    print("Clicked on ${movies[index]['title']}");
                  },
                  child: GridTile(
                      footer: Container(
                        color: Colors.black26,
                        child: ListTile(
                          leading: Text(movies[index]['title'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16.0)),
                        ),
                      ),
                      child: Image.network(
                          imageUrl + movies[index]['poster_path'],
                          fit: BoxFit.cover)),
                ),
              )),
        );
      },
    );
  }

  Widget _circularIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
