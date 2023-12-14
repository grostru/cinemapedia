import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository_implementation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Este repositorio es inmutable, su objetivo es proporcionar
// la informacion al resto de providers la información
final movieRepositoryProvider = Provider((ref){
  return MovieRepositoryImplementation(MoviedbDataSource());
});