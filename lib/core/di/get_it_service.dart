import 'package:clothes_ecommerce_app/core/const/app_const.dart';
import 'package:clothes_ecommerce_app/feature/auth/data/repo/auth_repository_impl.dart';
import 'package:clothes_ecommerce_app/feature/auth/data/service/auth_service.dart';
import 'package:clothes_ecommerce_app/feature/auth/domain/repo/auth_repository.dart';
import 'package:clothes_ecommerce_app/feature/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await Supabase.initialize(
    url: AppConst.supabaseUrl,
    anonKey: AppConst.supabaseKey,
  );

  // External dependencies
  getIt.registerLazySingleton<SupabaseClient>(
    () => Supabase.instance.client,
  );

  getIt.registerLazySingleton<GoogleSignIn>(
    () => GoogleSignIn(
      scopes: [
        'email',
        'profile',
        'openid',
      ],
      serverClientId: AppConst.googleClientId,
    ),
  );

  // Services
  getIt.registerLazySingleton<AuthService>(
    () => AuthService(
      supabaseClient: getIt(),
      googleSignIn: getIt(),
    ),
  );

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authService: getIt(),
    ),
  );

  // Cubits
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(
      authRepository: getIt(),
    ),
  );
}

// Helper function to reset all dependencies (useful for testing)
Future<void> resetDependencies() async {
  await getIt.reset();
  await initDependencies();
}
