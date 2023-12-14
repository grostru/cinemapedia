import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_respository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Proveedor de información que notifica cuando cambia el estado
final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;

  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPopular;

  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final topRaderMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getTopRader;

  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final upComingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getUpcoming;

  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});


// Definición del caso de uso
typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  bool isLoading = false;
  MovieCallback fetchMoreMovies;

  MoviesNotifier({
    required this.fetchMoreMovies,
  }) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;
    // Para que no haga peticiones tontas
    isLoading = true;

    currentPage++;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];
    
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false; // cuando ha terminado se pone a false
  }
}
