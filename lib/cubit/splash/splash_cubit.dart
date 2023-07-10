import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_app/cubit/splash/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState.splashPage) {
    _navigateToHomePage();
  }

  void _navigateToHomePage() async {
    await Future.delayed(
      const Duration(seconds: 2),
      () {
        emit(SplashState.homePage);
      },
    );
  }
}
