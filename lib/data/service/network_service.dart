import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/data/model/movies.dart';
import 'package:movies/data/model/network_response.dart';
import 'package:movies/data/model/now_playing.dart';
import 'package:movies/data/model/popular_movie.dart';

class NetworkService {
  final String _apiKey = "98d4ab8983c3a5727df9ab4f565f5f4a";
  final String _baseUrl = "http://api.themoviedb.org/";

  Future<NetworkResponse> getMovieCategories() async {
    print("getMovieCategories() Called");
    //"http://api.themoviedb.org/3/discover/movie?api_key=98d4ab8983c3a5727df9ab4f565f5f4a";
    try {
      final String url =
          "http://api.themoviedb.org/3/discover/movie?api_key=$_apiKey";

      final response = await http.get(url);
      if (response.statusCode == 200) {
        final parsedJson = await jsonDecode(response.body);
        // If server returns an OK response, parse the JSON
        //print("getMovieCategories $parsedJson");
        final movieResponse = Movies.fromJson(parsedJson);
        //print(movieResponse.results);
        return NetworkingResponseData<Movies>(movieResponse);
      } else {
        print("inside null");
        return null;
      }
    } catch (e) {
      print(e);
      return NetworkingException(e.toString());
    }
  }

  Future<NetworkResponse> getNowPlaying({bool loadMore = false}) async {
    // https://api.themoviedb.org/3/movie/now_playing?api_key=98d4ab8983c3a5727df9ab4f565f5f4a&language=en-US&page=1
    try {
      final String url =
          "https://api.themoviedb.org/3/movie/now_playing?api_key=$_apiKey";

      final response = await http.get(url);
      if (response.statusCode == 200) {
        final parsedJson = await jsonDecode(response.body);
        // If server returns an OK response, parse the JSON
        //print("getNowPlaying $parsedJson");
        final nowPlaying = NowPlayingResponse.fromJson(parsedJson);
        //print(nowPlaying.results);
        return NetworkingResponseData<NowPlayingResponse>(nowPlaying);
      } else {
        return null;
      }
    } catch (e) {
      return NetworkingException(e.toString());
    }
  }

  Future<NetworkResponse> getPopularMovies() async {
    //https://api.themoviedb.org/3/movie/popular?api_key=98d4ab8983c3a5727df9ab4f565f5f4a&language=en-US&page=1
    try {
      final String url =
          "https://api.themoviedb.org/3/movie/popular?api_key=$_apiKey";

      final response = await http.get(url);
      if (response.statusCode == 200) {
        final parsedJson = await jsonDecode(response.body);
        // If server returns an OK response, parse the JSON
        print("getPopularMovies $parsedJson");
        final popularMovies = PopularMovie.fromJson(parsedJson);
        print(popularMovies.results);
        return NetworkingResponseData<PopularMovie>(popularMovies);
      } else {
        return null;
      }
    } catch (e) {
      return NetworkingException(e.toString());
    }
  }
}