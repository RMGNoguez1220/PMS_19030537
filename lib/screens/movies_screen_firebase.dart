import 'package:flutter/material.dart';
import 'package:pmsn2024b/firebase/firebase_database.dart';
import 'package:pmsn2024b/models/moviesdao.dart';
import 'package:pmsn2024b/views/movie_view_firebase.dart';
import 'package:pmsn2024b/views/movie_view_item_firebase.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class MoviesScreenFirebase extends StatefulWidget {
  const MoviesScreenFirebase({super.key});

  @override
  State<MoviesScreenFirebase> createState() => _MoviesScreenFirebaseState();
}

class _MoviesScreenFirebaseState extends State<MoviesScreenFirebase> {
  late FirebaseDatabase databaseMovies;

  @override
  void initState() {
    super.initState();
    databaseMovies = FirebaseDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de películas'),
        actions: [
          IconButton(
            onPressed: () {
              WoltModalSheet.show(
                context: context,
                pageListBuilder: (context) => [
                  WoltModalSheetPage(
                    child: MovieViewFirebase(),
                  ),
                ],
              );
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: StreamBuilder(
        stream: databaseMovies.SELECT(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something was wrong'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No hay peliculas disponibles'));
          } else {
            var movies = snapshot.data!.docs;
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                var movieData = movies[index];
                return MovieViewItemFirebase(
                  moviesDAO: MoviesDAO.fromMap(
                    {
                      'idMovie': movieData.id,
                      'imgMovie': movieData.get('imgMovie'),
                      'nameMovie': movieData.get('nameMovie'),
                      'overview': movieData.get('overview'),
                      'releaseDate': movieData.get('releaseDate').toString(),
                    },
                  ),
                  Uid: movieData.id,
                );
              },
            );
          }
        },
      ),
    );
  }
}
