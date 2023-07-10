import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_app/model/movie_model.dart';
import 'package:tmdb_app/utils/app_string.dart';
import 'package:tmdb_app/widgets/movie_icon_widget.dart';

import '../widgets/navigation_button.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final MovieModel model =
        ModalRoute.of(context)!.settings.arguments as MovieModel;
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        leading: const NavigationBackWidget(),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SizedBox(
            child: CachedNetworkImage(
              imageUrl:
                  AppString.TMDB_IMAGE_PREFIX + model.posterPath.toString(),
              fit: BoxFit.cover,
              placeholder: (_, url) => const MovieIconWidget(),
              errorWidget: (_, __, ___) => const Icon(Icons.error_rounded),
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 90,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        height: size.height * 0.6,
                        child: CachedNetworkImage(
                          imageUrl: AppString.TMDB_IMAGE_PREFIX +
                              model.posterPath.toString(),
                          fit: BoxFit.cover,
                          errorWidget: (_, __, ___) => const Center(
                            child: Icon(Icons.error_rounded),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: size.width * 0.6,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        model.title.toString(),
                        textAlign: TextAlign.center,
                        style: theme.textTheme.displayMedium!
                            .copyWith(fontSize: 15),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      height: 100,
                      width: size.width * 0.8,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      'Release',
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.displayMedium!
                                          .copyWith(fontSize: 15),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      model.releaseDate.toString(),
                                      style: theme.textTheme.displayMedium!
                                          .copyWith(fontSize: 18),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      'Rating',
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.displayMedium!
                                          .copyWith(fontSize: 15),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        CircularProgressIndicator(
                                          value: (double.parse(model.voteAverage
                                                  .toString()) /
                                              10.0),
                                          strokeWidth: 3,
                                          backgroundColor:
                                              Colors.white.withOpacity(0.5),
                                          valueColor:
                                              const AlwaysStoppedAnimation<
                                                  Color>(
                                            Colors.orange,
                                          ),
                                        ),
                                        Text(
                                          model.voteAverage!
                                              .toStringAsFixed(1)
                                              .toString(),
                                          style: theme.textTheme.displayMedium!
                                              .copyWith(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Overview',
                            style: theme.textTheme.displayMedium!
                                .copyWith(fontSize: 15),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            model.overview.toString(),
                            textAlign: TextAlign.justify,
                            style: theme.textTheme.displayMedium!.copyWith(
                              fontSize: 15,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.normal,
                              color: Colors.white.withOpacity(0.8),
                            ),
                            maxLines: 7,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
