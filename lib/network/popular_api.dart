import 'package:dio/dio.dart';
import 'package:pmsn2024b/models/popular_moviedao.dart';
import 'package:pmsn2024b/models/actordao.dart';
import 'package:pmsn2024b/models/videodao.dart';

class PopularApi {
  final dio = Dio();
  Future<List<PopularMovieDao>> getPopularMovies() async {
    final response = await dio.get(
        'https://api.themoviedb.org/3/movie/popular?api_key=166e585d3aa77225a41b2c79f877b523&language=es-MX&page=1');
    final res = response.data["results"] as List;

    List<PopularMovieDao> popularMovies = [];

    for (var popular in res) {
      PopularMovieDao movie = PopularMovieDao.fromMap(popular);

      movie.actors = await getActors(movie
          .id); //Obtiene el conjunto de actores para la pelicula especificada por el id

      movie.trailers = await getTrailers(movie
          .id); //Obtiene el conjunto de trailers para la pelicula especificada por el id

      popularMovies.add(movie);
    }

    return popularMovies;
  }

  Future<List<ActorDAO>> getActors(int movieId) async {
    final response = await dio.get(
        'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=166e585d3aa77225a41b2c79f877b523');
    final List<dynamic> actorJson = response.data['cast'];
    return actorJson.map((json) => ActorDAO.fromJson(json)).toList();
  }

  Future<List<VideoDAO>> getTrailers(int movieId) async {
    final response = await dio.get(
        'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=166e585d3aa77225a41b2c79f877b523&language=es-MX');
    final List<dynamic> videoJson = response.data['results'];
    return videoJson.map((json) => VideoDAO.fromJson(json)).toList();
  }
}
