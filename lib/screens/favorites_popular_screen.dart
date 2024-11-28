import 'package:flutter/material.dart';
import 'package:pmsn2024b/models/popular_moviedao.dart';
import 'package:pmsn2024b/network/popular_api.dart';
import 'package:provider/provider.dart';
import 'package:pmsn2024b/provider/test_provider.dart';

class FavoritesPopularScreen extends StatefulWidget {
  const FavoritesPopularScreen({super.key});

  @override
  State<FavoritesPopularScreen> createState() => _FavoritesPopularScreenState();
}

class _FavoritesPopularScreenState extends State<FavoritesPopularScreen> {
  PopularApi? api;

  @override
  void initState() {
    super.initState();
    api = PopularApi();
  }

  @override
  Widget build(BuildContext context) {
    final testProvider = Provider.of<TestProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis favoritos'),
      ),
      body: FutureBuilder<List<PopularMovieDao>>(
        future: api!.getPopularMovies(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Filtrar las películas favoritas
            final favoriteMovies = testProvider.favoriteMovies;
            final filteredMovies = snapshot.data!.where(
              (movie) {
                return favoriteMovies
                    .any((favorite) => favorite.id == movie.id);
              },
            ).toList();
            if (filteredMovies.isNotEmpty) {
              return GridView.builder(
                itemCount: filteredMovies.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return cardPopular(filteredMovies[index]);
                },
              );
            } else {
              return Center(
                child: Text(
                  'No favorite movies found.',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              );
            }
          } else {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        },
      ),
    );
  }

  Widget cardPopular(PopularMovieDao popular) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/detail', arguments: popular),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                  'https://image.tmdb.org/t/p/w500/${popular.posterPath}'),
            ),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Opacity(
                opacity: .7,
                child: Container(
                  color: Colors.black,
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text(
                      popular.title,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
