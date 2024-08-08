import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../core/errors/failure.dart';
import '../repo/home_repo.dart';

class UploadImageUseCase extends UseCase<void, XFile> {
  final HomeRepo _homeRepo;

  UploadImageUseCase(this._homeRepo);

  @override
  Future<Either<Failure, void>> call(param) async {
    return await _homeRepo.uploadImage(param);
  }
}
