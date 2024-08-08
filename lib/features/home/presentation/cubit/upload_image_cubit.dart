import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../domain/usecases/upload_image_use_case.dart';

part 'upload_image_state.dart';

class UploadImageCubit extends Cubit<UploadImageState> {
  UploadImageCubit(this._uploadImageUseCase) : super(UploadImageInitial());

  final UploadImageUseCase _uploadImageUseCase;

  final ImagePicker picker = ImagePicker();

  XFile? image;

  Future<void> getLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (!response.isEmpty) {
      final List<XFile>? files = response.files;
      if (files!.isNotEmpty) {
        image = files.first;
        emit(ImagePicked());
        return;
      }
    }
  }

  Future<void> pickImage() async {
    getLostData();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = pickedImage;
      emit(ImagePicked());
    }
  }

  Future<void> uploadItemImage() async {
    if (image == null) {
      emit(UploadImageFailure(errMessage: 'Please select an image'));
      return;
    }
    var result = await _uploadImageUseCase.call(image!);
    result.fold(
      (failure) {
        emit(UploadImageFailure(errMessage: failure.errMessage));
      },
      (response) {
        emit(UploadImageSuccess());
      },
    );
  }
}
