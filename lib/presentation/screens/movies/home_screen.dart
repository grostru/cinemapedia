import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_slideshow_provider.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home_screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView({
    super.key,
  });

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRaderMoviesProvider.notifier).loadNextPage();
    ref.read(upComingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    // Usamos este initial loading provider para esperar y mostrar una pantalla
    // con circular progress hasta que todos los providers traigan datos
    final initialLoading = ref.watch(initialLoadingProvider);

    if (initialLoading) return const FullScreenLoader();

    // Una vez que todos traigan datos entonces leemos los providers
    // y entonces mostramos todos los datos
    final slideshowMovies = ref.watch(moviesSlideshowProvider);
    final nowPlayingmovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRaderMovies = ref.watch(topRaderMoviesProvider);
    final upComingMovies = ref.watch(upComingMoviesProvider);

    return CustomScrollView(
      slivers: [
        // Con este sliverApp bar hacemos el parallax de kotlin y aparece el menu cuando hacemos scroll
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
          ),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                MoviesSlideshow(movies: slideshowMovies),
                MovieHorizontalListview(
                  movies: nowPlayingmovies,
                  title: 'En cines',
                  subTitle: 'Lunes 20',
                  loadNextPage: () {
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                  },
                ),
                MovieHorizontalListview(
                  movies: upComingMovies,
                  title: 'Próximamente',
                  subTitle: 'En este mes',
                  loadNextPage: () {
                    ref.read(upComingMoviesProvider.notifier).loadNextPage();
                  },
                ),
                MovieHorizontalListview(
                  movies: popularMovies,
                  title: 'Populares',
                  loadNextPage: () {
                    ref.read(popularMoviesProvider.notifier).loadNextPage();
                  },
                ),
                MovieHorizontalListview(
                  movies: topRaderMovies,
                  title: 'Mejor calificadas',
                  subTitle: 'De todos los tiempos',
                  loadNextPage: () {
                    ref.read(topRaderMoviesProvider.notifier).loadNextPage();
                  },
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            );
          }, childCount: 1),
        )
      ],
    );
  }
}
