part of 'upload_image_cubit.dart';

@immutable
sealed class UploadImageState {}

final class UploadImageInitial extends UploadImageState {}

final class UploadImageLoading extends UploadImageState {}

final class UploadImageSuccess extends UploadImageState {}

final class UploadImageFailure extends UploadImageState {
  final String errMessage;

  UploadImageFailure({required this.errMessage});
}
final class ImagePicked extends UploadImageState {}
