import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallBack = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallBack searchMovies;

  SearchMovieDelegate({
    required this.searchMovies
  });

  @override
  String get searchFieldLabel => 'Buscar película';

  // Botón de la derecha. Sirve para poner por ejemplo un botón de borrar búsqueda
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      FadeIn(
        animate: query.isNotEmpty,
        duration: const Duration(milliseconds: 200),
        child: IconButton(
            onPressed: () => query = '', icon: const Icon(Icons.clear)),
      )
    ];
  }

  // Método delegado para manejar el evento back
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('Buildresults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: searchMovies(query),
      builder: (context, snapshot) {

        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index){
            final movie = movies[index];
            return ListTile(title: Text(movie.title));
          }
        );
      },
    );
  }
}
