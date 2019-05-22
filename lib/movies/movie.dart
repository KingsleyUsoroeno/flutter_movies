
class Movie {
  final int movieTitle;
  final int voteAverage;
  final String posterPath;
  final String movieOverView;

  Movie({this.movieTitle, this.voteAverage, this.posterPath, this.movieOverView});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      movieTitle: json['title'],
      voteAverage: json['vote_average'],
      posterPath: json['poster_path'],
      movieOverView: json['overview'],
    );
  }
}
