import 'package:equatable/equatable.dart';

import '../../../../core/utils/enums.dart';
import '../../../domain/entities/movie.dart';

class MoviesState extends Equatable {
  final List<Movie> nowPlayingMovies;
  final RequestState nowPlayingState;
  final String nowPlayingMessageError;

  final List<Movie> popularMovies;
  final RequestState popularState;
  final String popularMessageError;

  final List<Movie> topRatedMovies;
  final RequestState topRatedState;
  final String topRatedMessageError;

  final List<Movie> upcomingMovies;
  final RequestState upcomingState;
  final String upcomingMessageError;

  const MoviesState({
    this.nowPlayingMovies = const [],
    this.nowPlayingState = RequestState.loading,
    this.nowPlayingMessageError = '',
    this.popularMovies = const [],
    this.popularState = RequestState.loading,
    this.popularMessageError = '',
    this.topRatedMovies = const [],
    this.topRatedState = RequestState.loading,
    this.topRatedMessageError = '',
    this.upcomingMovies = const [],
    this.upcomingState = RequestState.loading,
    this.upcomingMessageError = '',
  });

  MoviesState copyWith({
    List<Movie>? nowPlayingMovies,
    RequestState? nowPlayingState,
    String? nowPlayingMessageError,
    List<Movie>? popularMovies,
    RequestState? popularState,
    String? popularMessageError,
    List<Movie>? topRatedMovies,
    RequestState? topRatedState,
    String? topRatedMessageError,
    List<Movie>? upcomingMovies,
    RequestState? upcomingState,
    String? upcomingMessageError,
  }) {
    return MoviesState(
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      nowPlayingState: nowPlayingState ?? this.nowPlayingState,
      nowPlayingMessageError:
          nowPlayingMessageError ?? this.nowPlayingMessageError,
      popularMovies: popularMovies ?? this.popularMovies,
      popularState: popularState ?? this.popularState,
      popularMessageError: popularMessageError ?? this.popularMessageError,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      topRatedState: topRatedState ?? this.topRatedState,
      topRatedMessageError: topRatedMessageError ?? this.topRatedMessageError,
      upcomingMovies: upcomingMovies ?? this.upcomingMovies,
      upcomingState: upcomingState ?? this.upcomingState,
      upcomingMessageError: upcomingMessageError ?? this.upcomingMessageError,
    );
  }

  @override
  List<Object> get props => [
        nowPlayingMovies,
        nowPlayingState,
        nowPlayingMessageError,
        popularMovies,
        popularState,
        popularMessageError,
        topRatedMovies,
        topRatedState,
        topRatedMessageError,
        upcomingMovies,
        upcomingState,
        upcomingMessageError,
      ];
}
