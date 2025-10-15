part of 'splash_cubit.dart';

abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashAnimating extends SplashState {
  final List<double> letterOpacities;
  
  SplashAnimating(this.letterOpacities);
}

class SplashComplete extends SplashState {}