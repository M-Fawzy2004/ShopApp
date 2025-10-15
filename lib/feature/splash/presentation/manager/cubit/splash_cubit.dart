import 'dart:async';
import 'package:bloc/bloc.dart';
part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Timer? _timer;
  final List<String> _letters = ['S', 'H', 'O', 'P'];

  void startAnimation() {
    int currentIndex = 0;
    List<double> opacities = [0.0, 0.0, 0.0, 0.0];

    _timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      if (currentIndex < _letters.length) {
        opacities[currentIndex] = 1.0;
        emit(SplashAnimating(List.from(opacities)));
        currentIndex++;
      } else {
        timer.cancel();
        Future.delayed(const Duration(milliseconds: 500), () {
          if (!isClosed) {
            emit(SplashComplete());
          }
        });
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
