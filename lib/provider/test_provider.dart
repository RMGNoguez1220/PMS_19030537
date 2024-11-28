import 'package:flutter/material.dart';
import 'favorite_movie.dart';

class TestProvider extends ChangeNotifier {
  String _name = 'Rick Garcia Noguez';
  final List<FavoriteMovie> _favoriteMovies = [];
  String get name => _name;
  List<FavoriteMovie> get favoriteMovies => _favoriteMovies; // Getter para favoritos

  set name(String value) {
    _name = value;
    notifyListeners();
  }

  //Método que verificar si una película es favorita
  bool isFavorite(int movieId) {
    return _favoriteMovies.any((movie) => movie.id == movieId);
  }

  // Método para alternar el estado de favorito
  void toggleFavorite(int movieId, String title) {
    if (isFavorite(movieId)) {
      _favoriteMovies.removeWhere((movie) => movie.id == movieId);
      //print("Removed from favorites: $movieId");
    } else {
      _favoriteMovies.add(FavoriteMovie(movieId, title));
      //print("Added to favorites: $movieId");
    }
    notifyListeners();
  }
}
