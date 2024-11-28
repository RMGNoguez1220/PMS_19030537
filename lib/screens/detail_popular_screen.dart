import 'package:flutter/material.dart';
import 'package:pmsn2024b/models/popular_moviedao.dart';
import 'package:pmsn2024b/models/actordao.dart';
import 'package:pmsn2024b/provider/test_provider.dart';
import 'package:pmsn2024b/network/popular_api.dart';
import 'package:pmsn2024b/settings/colors_settings.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:provider/provider.dart';

class DetailPopularScreen extends StatefulWidget {
  const DetailPopularScreen({super.key});

  @override
  State<DetailPopularScreen> createState() => _DetailPopularScreenState();
}

class _DetailPopularScreenState extends State<DetailPopularScreen> {
  YoutubePlayerController? _controller;
  bool _isVideoLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = null;
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _playVideo(String videoKey) {
    setState(() {
      _isVideoLoading = true; // Muestra el indicador de carga
      _controller = YoutubePlayerController(
        initialVideoId: videoKey,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      );
    });

    //Tiempo de carga
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isVideoLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final popular =
        ModalRoute.of(context)!.settings.arguments as PopularMovieDao;
    final testProvider = Provider.of<TestProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(popular.title),
        actions: [
          IconButton(
            icon: Icon(
              testProvider.isFavorite(popular.id)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: ColorsSettings.navColor,
            ),
            onPressed: () {
              testProvider.toggleFavorite(popular.id, popular.title);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Fondo de la pantalla con la imagen difuminada
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                opacity: .3,
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500/${popular.posterPath}'),
              ),
            ),
          ),
          // Contenedor para la descripción de la película
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Colors.black45,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    popular.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Description:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    popular.overview,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Release Date: ${popular.releaseDate}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Botón para reproducir el tráiler
                  ElevatedButton(
                    onPressed: () {
                      if (popular.trailers.isNotEmpty) {
                        _playVideo(popular.trailers[0].key);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Video no disponible o Sin video'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: const Text('Ver Trailer'),
                  ),
                  if (_controller != null) ...[
                    if (_isVideoLoading)
                      const Center(
                          child:
                              CircularProgressIndicator()), // Indicador de carga
                    YoutubePlayer(
                      controller: _controller!,
                      showVideoProgressIndicator: true,
                      bottomActions: [
                        const CurrentPosition(),
                        const ProgressBar(isExpanded: true),
                        const PlaybackSpeedButton(),
                        IconButton(
                          icon: Icon(
                            _controller!.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                          ),
                          onPressed: () {
                            setState(() {
                              _controller!.value.isPlaying
                                  ? _controller!.pause()
                                  : _controller!.play();
                            });
                          },
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ],
                  const SizedBox(height: 20),
                  // Aquí agregamos el widget de rating con estrellas
                  Row(
                    children: [
                      Text(
                        'Rating:',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(width: 10),
                      buildRatingStars(popular.voteAverage),
                      const SizedBox(width: 5),
                      Text(
                        '${popular.voteAverage}/10',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Sección para los actores
                  Text(
                    'Actors:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 10),
                  FutureBuilder<List<ActorDAO>>(
                    future: fetchActors(popular.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text(
                          'Error: ${snapshot.error}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Text(
                          'No actors found',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        );
                      }
                      final actors = snapshot.data!;
                      return SizedBox(
                        height: 180, // Altura del contenedor para las tarjetas
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: actors.length,
                          itemBuilder: (context, index) {
                            final actor = actors[index];
                            return Container(
                              width: 120,
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.black54,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      actor.profilePath.isNotEmpty
                                          ? 'https://image.tmdb.org/t/p/w200/${actor.profilePath}'
                                          : 'https://placehold.co/600x400.png?text=Sin+imagen',
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    actor.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    actor.character,
                                    style: const TextStyle(
                                      color: Colors.white54,
                                      fontSize: 10,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  // FutureBuilder<List<ActorDAO>>(
                  //   future: fetchActors(popular.id),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.connectionState == ConnectionState.waiting) {
                  //       return const Center(child: CircularProgressIndicator());
                  //     } else if (snapshot.hasError) {
                  //       return Text(
                  //         'Error: ${snapshot.error}',
                  //         style: TextStyle(
                  //           color: Theme.of(context).colorScheme.onSurface,
                  //         ),
                  //       );
                  //     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  //       return Text(
                  //         'No actors found',
                  //         style: TextStyle(
                  //           color: Theme.of(context).colorScheme.onSurface,
                  //         ),
                  //       );
                  //     }
                  //     final actors = snapshot.data!;
                  //     return Column(
                  //       children: actors.map((actor) {
                  //         return ListTile(
                  //           title: Text(
                  //             actor.name,
                  //             style: TextStyle(
                  //               color: Theme.of(context).colorScheme.onSurface,
                  //               fontWeight: FontWeight.bold
                  //             ),
                  //           ),
                  //           subtitle: Text(
                  //             'as ${actor.character}',
                  //             style: TextStyle(
                  //               color: Theme.of(context).colorScheme.onSurface,
                  //               fontStyle: FontStyle.italic
                  //             ),
                  //           ),
                  //         );
                  //       }).toList(),
                  //     );
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
      //   floatingActionButton: FloatingActionButton(
      //     onPressed: () => testProvider.name = 'Homeroooooo homerooooo',
      //   ),
      //   body: Container(
      //     decoration: BoxDecoration(
      //       image: DecorationImage(
      //         opacity: .3,
      //         fit: BoxFit.fill,
      //         image: NetworkImage(
      //             'https://image.tmdb.org/t/p/w500/${popular.posterPath}'),
      //       ),
      //     ),
      //   ),
    );
  }

  Future<List<ActorDAO>> fetchActors(int movieId) async {
    final popularApi = PopularApi();
    return await popularApi.getActors(movieId);
  }

  Widget buildRatingStars(double rating) {
    int fullStars = rating ~/ 2;
    int halfStars = (rating % 2 >= 1) ? 1 : 0;
    int emptyStars = 5 - fullStars - halfStars;
    return Row(
      children: [
        for (int i = 0; i < fullStars; i++) ...[
          const Icon(Icons.star, color: Colors.yellow)
        ],
        for (int i = 0; i < halfStars; i++) ...[
          const Icon(Icons.star_half, color: Colors.yellow)
        ],
        for (int i = 0; i < emptyStars; i++) ...[
          const Icon(Icons.star_border, color: Colors.yellow)
        ],
      ],
    );
  }
}
