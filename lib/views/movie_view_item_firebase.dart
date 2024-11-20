import 'package:flutter/material.dart';
import 'package:pmsn2024b/firebase/firebase_database.dart';
import 'package:pmsn2024b/models/moviesdao.dart';
import 'package:pmsn2024b/views/movie_view_firebase.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class MovieViewItemFirebase extends StatefulWidget {
  MovieViewItemFirebase(
      {super.key, required this.moviesDAO, required this.Uid});

  final MoviesDAO moviesDAO;
  final Uid;

  @override
  State<MovieViewItemFirebase> createState() => _MovieViewItemFirebaseState();
}

class _MovieViewItemFirebaseState extends State<MovieViewItemFirebase> {
  FirebaseDatabase? dbFirebase;

  @override
  void initState() {
    super.initState();
    dbFirebase = FirebaseDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(68, 138, 255, 1),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Image.network(
              //   widget.moviesDAO.imgMovie!,
              //   height: 100,
              //   width: 100,
              //   fit: BoxFit.cover,
              //   errorBuilder: (BuildContext context, Object error,
              //       StackTrace? stacktrace) {
              //     return Image.asset(
              //       'assets/default_avatart.jpg',
              //       height: 100,
              //       width: 100,
              //       fit: BoxFit.cover,
              //     );
              //   },
              // )
              isValidUrl(widget.moviesDAO.imgMovie!)
                  ? Image.network(
                      widget.moviesDAO.imgMovie!,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        return const Center(
                          child: Text(
                            'URL inválida',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      },
                    )
                  : Container(
                    height: 100,
                    width: 100,
                    color: Colors.grey,
                    alignment: Alignment.center,
                    child: const Text(
                      'URL inválida',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
              Expanded(
                child: ListTile(
                  title: Text(widget.moviesDAO.nameMovie!),
                  subtitle: Text(widget.moviesDAO.releaseDate!),
                ),
              ),
              IconButton(
                  onPressed: () {
                    WoltModalSheet.show(
                      context: context,
                      pageListBuilder: (context) => [
                        WoltModalSheetPage(
                          child: MovieViewFirebase(
                              moviesDAO: widget.moviesDAO, Uid: widget.Uid),
                        )
                      ],
                    );
                  },
                  icon: const Icon(Icons.edit)),
              IconButton(
                  onPressed: () {
                    dbFirebase!.DELETE(widget.Uid).then((value) {
                      if (value) {
                        // GlobalValues.banUpdListMovies.value =
                        //     !GlobalValues.banUpdListMovies.value;
                        return QuickAlert.show(
                            context: context,
                            type: QuickAlertType.success,
                            text: 'Transaction completed successfully!',
                            autoCloseDuration: const Duration(seconds: 3),
                            showConfirmBtn: true);
                      } else {
                        return QuickAlert.show(
                            context: context,
                            type: QuickAlertType.error,
                            text: 'Something was wrong',
                            autoCloseDuration: const Duration(seconds: 3),
                            showConfirmBtn: false);
                      }
                    });
                  },
                  icon: const Icon(Icons.delete))
            ],
          ),
          const Divider(),
          Text(widget.moviesDAO.overview!),
        ],
      ),
    );
  }

  bool isValidUrl(String url) {
    final uri = Uri.tryParse(url);
    return uri != null &&
        uri.isAbsolute &&
        (url.startsWith('http') || url.startsWith('https'));
  }
}

// class MovieViewItem extends StatefulWidget {
//   MovieViewItem({super.key, required this.moviesDAO});

//   MoviesDAO moviesDAO;

//   @override
//   State<MovieViewItem> createState() => _MovieViewItemState();
// }

// class _MovieViewItemState extends State<MovieViewItem> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Text(widget.moviesDAO.imgMovie!),
//     );
//   }
// }

// class MovieViewItem extends StatelessWidget {
//   MovieViewItem({super.key, required this.moviesDAO});

//   MoviesDAO moviesDAO;

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
