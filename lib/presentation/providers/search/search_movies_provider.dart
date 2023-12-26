import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchMoviesProvider = StateNotifierProvider<SearchMoviesNotifier, List<Movie>>((ref){
  final movieRepository = ref.read(movieRepositoryProvider);

  return SearchMoviesNotifier(
    searchMovie: movieRepository.searchMovies, 
    ref: ref
  );
});

typedef SearchMoviesCallBack = Future<List<Movie>> Function(String query);

class SearchMoviesNotifier extends StateNotifier<List<Movie>> {
  SearchMoviesCallBack searchMovie;
  final Ref ref;

  SearchMoviesNotifier({required this.searchMovie, required this.ref})
      : super([]);

  Future<List<Movie>> searchMoviesByQuery(String query) async {
    final List<Movie> movies = await searchMovie(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);

    state = movies;

    return movies;
  }
}
