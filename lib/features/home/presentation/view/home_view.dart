import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alhayat_task/core/helpers/app_toast.dart';
import 'package:alhayat_task/features/home/presentation/cubit/upload_image_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Flutter Demo Home Page'),
      ),
      body: BlocConsumer<UploadImageCubit, UploadImageState>(
        listener: (context, state) {
          if (state is UploadImageSuccess) {
            showToast(context, 'Image Uploaded Successfully');
          } else if (state is UploadImageFailure) {
            showToast(context, state.errMessage);
          }
        },
        builder: (context, state) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  await context.read<UploadImageCubit>().pickImage();
                },
                child: const Text('Select Image'),
              ),
              context.read<UploadImageCubit>().image != null
                  ? Image.file(
                      File(context.read<UploadImageCubit>().image!.path))
                  : const SizedBox(),
              ElevatedButton(
                onPressed: () async {
                  await context.read<UploadImageCubit>().uploadItemImage();
                },
                child: state is UploadImageLoading
                    ? const Center(child: CircularProgressIndicator.adaptive())
                    : const Text('Upload Image'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
