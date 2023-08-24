import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/services_locator.dart';
import '../controller/cubit/movie_details_cubit.dart';
import '../widgets/movie_details_widget.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const route = 'NowPlayingMovieDetailsScreen';

  const MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as int;

    return BlocProvider(
      create: (context) => servicesLocator<MovieDetailsCubit>()
        ..getMovieDetails(movieId: id)
        ..getRecommendation(movieId: id),
      lazy: false,
      child: const Scaffold(
        body: MovieDetailsWidget(),
      ),
    );
  }
}
