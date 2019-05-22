import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class MovieDetail extends StatelessWidget {
  final String imageUrl = 'https://image.tmdb.org/t/p/w500/';
  var movie;

  MovieDetail(this.movie);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Detail',
      home: Scaffold(
        body: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Image.network(imageUrl + movie['poster_path'],
                fit: BoxFit.cover),
            new BackdropFilter(
              filter: new ui.ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
              child: new Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            new SingleChildScrollView(
              child: new Container(
                margin: EdgeInsets.all(20.0),
                child: new Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: new Container(width: 400.0, height: 400.0),
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: new DecorationImage(
                              image: NetworkImage(
                                  imageUrl + movie['poster_path']))),
                    )
                  ],
                ),
              ),
            ),
            new Container(
              margin: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 0.0),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: Text(movie['title'],style: TextStyle(color: Colors.white,fontSize: 30.0,fontFamily: 'Arvo')),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
