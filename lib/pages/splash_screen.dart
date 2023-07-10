import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/utils/app_nav_name.dart';
import 'package:tmdb_app/widgets/progress_indicator.dart';

import '../cubit/splash/splash_cubit.dart';
import '../cubit/splash/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: BlocListener<SplashCubit, SplashState>(
        listener: (BuildContext context, state) {
          if (state == SplashState.homePage) {
            Navigator.of(context).pushReplacementNamed(AppNavPath.homePage);
          }
        },
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
                child: Image.asset(
                  'assets/images/tmdb_logo.jpeg',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const LoadingIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
