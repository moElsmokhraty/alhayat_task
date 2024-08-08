import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/home/presentation/view/home_view.dart';
import 'package:alhayat_task/core/di/service_locator.dart';
import 'features/domain/usecases/upload_image_use_case.dart';
import 'features/home/presentation/cubit/upload_image_cubit.dart';

void main() {
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => UploadImageCubit(getIt.get<UploadImageUseCase>()),
        child: const HomeView(),
      ),
    );
  }
}
