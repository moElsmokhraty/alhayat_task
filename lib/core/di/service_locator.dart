import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../features/domain/repo/home_repo.dart';
import '../../features/domain/usecases/upload_image_use_case.dart';
import '../../features/home/data/repo/home_repo.dart';
import '../config/api/api_config.dart';
import '../config/api/api_service.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(
      Dio(
        BaseOptions(
          baseUrl: APIConfig.baseUrl,
          connectTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          receiveDataWhenStatusError: true,
        ),
      ),
    ),
  );

  getIt.registerLazySingleton<HomeRepo>(
    () => HomeRepoImpl(getIt.get<ApiService>()),
  );

  getIt.registerLazySingleton<UploadImageUseCase>(
    () => UploadImageUseCase(getIt.get<HomeRepo>()),
  );
}
