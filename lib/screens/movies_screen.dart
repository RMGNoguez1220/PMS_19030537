import 'package:flutter/material.dart';
import 'package:pmsn2024b/database/movies_database.dart';
import 'package:pmsn2024b/models/moviesdao.dart';
import 'package:pmsn2024b/views/movie_view_item.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  late MoviesDatabase moviesDB;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moviesDB = MoviesDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies_list'),
        actions: [
          IconButton(
            onPressed: () {
              WoltModalSheet.show(
                context: context,
                pageListBuilder: (context) => [
                  WoltModalSheetPage(
                    child: const Text('Aquí debe de aparecer el modal'),
                  )
                ],
              );
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: FutureBuilder(
          future: moviesDB.SELECT(),
          builder: (context, AsyncSnapshot<List<MoviesDAO>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return const Text('Hola');
                  // return MovieViewItem(
                  //   moviesDAO: snapshot.data![index],
                  // );
                },
              );
            } else {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Something was wrong! :)'),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
          }),
    );
  }

  // Widget MovieViewList (){
  //   return Text('data');
  // }
}
