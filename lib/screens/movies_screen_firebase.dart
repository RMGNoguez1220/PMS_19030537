import 'package:flutter/material.dart';
import 'package:pmsn2024b/firebase/database_movies.dart';

class MoviesScreenFirebase extends StatefulWidget {
  const MoviesScreenFirebase({super.key});

  @override
  State<MoviesScreenFirebase> createState() => _MoviesScreenFirebaseState();
}

class _MoviesScreenFirebaseState extends State<MoviesScreenFirebase> {
  DatabaseMovies? databaseMovies;
  @override
  void initState() {
    databaseMovies = DatabaseMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: databaseMovies!.SELECT(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length, 
              itemBuilder: (context, index) {
                return Image.network(snapshot.data!.docs[index].get('imgMovie'));
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something was wrong'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
