import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pmsn2024b/firebase/firebase_database.dart';
import 'package:pmsn2024b/models/moviesdao.dart';
import 'package:pmsn2024b/settings/global_values.dart';
import 'package:quickalert/quickalert.dart';

class MovieViewFirebase extends StatefulWidget {
  final String? Uid;
  final MoviesDAO? moviesDAO;
  MovieViewFirebase({super.key, this.moviesDAO, this.Uid});

  @override
  State<MovieViewFirebase> createState() => _MovieViewFirebaseState();
}

class _MovieViewFirebaseState extends State<MovieViewFirebase> {
  TextEditingController conName = TextEditingController();
  TextEditingController conOverview = TextEditingController();
  TextEditingController conImgMovie = TextEditingController();
  TextEditingController conRelease = TextEditingController();
  FirebaseDatabase dbMovies = FirebaseDatabase();

  @override
  void initState() {
    super.initState();
    dbMovies;
    if (widget.moviesDAO != null) {
      conName.text = widget.moviesDAO!.nameMovie ?? '';
      conOverview.text = widget.moviesDAO!.overview ?? '';
      conImgMovie.text = widget.moviesDAO!.imgMovie ?? '';
      conRelease.text = widget.moviesDAO!.releaseDate ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final txtNameMovie = TextFormField(
      controller: conName,
      decoration: const InputDecoration(
        hintText: 'Nombre de la película',
      ),
    );
    final txtOverview = TextFormField(
      controller: conOverview,
      maxLines: 5,
      decoration: const InputDecoration(
        hintText: 'Sinopsis',
      ),
    );
    final txtImgMovie = TextFormField(
      controller: conImgMovie,
      decoration: const InputDecoration(
        hintText: 'Poster de la película',
      ),
    );
    final txtRelease = TextFormField(
      readOnly: true,
      controller: conRelease,
      decoration: const InputDecoration(
        hintText: 'Fecha de lanzamiento',
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2025),
        );
        if (pickedDate != null) {
          String formatDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          conRelease.text = formatDate;
          setState(() {});
        }
      },
    );

    final btnSave = ElevatedButton(
      onPressed: () {
        if (widget.moviesDAO == null) {
          dbMovies.INSERT({
            'nameMovie': conName.text,
            'overview': conOverview.text,
            'imgMovie': conImgMovie.text,
            'releaseDate': conRelease.text
          }).then((value) {
            if (value) {
              return QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                text: 'Transaction completed successfully!',
                autoCloseDuration: const Duration(seconds: 2),
                showConfirmBtn: false,
              ).then((_) {
                Navigator.of(context).pop();
              });
            } else {
              return QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  text: 'Something was wrong',
                  autoCloseDuration: const Duration(seconds: 2),
                  showConfirmBtn: false);
            }
          });
        } else {
          dbMovies.UPDATE(
            {
              'nameMovie': conName.text,
              'overview': conOverview.text,
              'imgMovie': conImgMovie.text,
              'releaseDate': conRelease.text
            },
            '${widget.Uid}',
          ).then((value) {
            final String msj;
            QuickAlertType type = QuickAlertType.success;
            if (value) {
              GlobalValues.banUpdListMovies.value =
                  !GlobalValues.banUpdListMovies.value;
              type = QuickAlertType.success;
              msj = 'Transaction completed Successfully!';
            } else {
              type = QuickAlertType.error;
              msj = 'Something was wrong!';
            }
            return QuickAlert.show(
              context: context,
              type: type,
              text: msj,
              autoCloseDuration: const Duration(seconds: 3),
              showConfirmBtn: false,
            ).then((_) {
              Navigator.of(context).pop();
            });
          });
        }
        Navigator.of(context).pop();
      },
      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[200]),
      child: const Text('Guardar'),
    );

    return ListView(
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
      children: [
        txtNameMovie,
        txtOverview,
        txtImgMovie,
        txtRelease,
        btnSave,
      ],
    );
  }
}
