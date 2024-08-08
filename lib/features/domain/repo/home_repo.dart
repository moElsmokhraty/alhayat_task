import 'package:dartz/dartz.dart';
import '/core/errors/failure.dart';
import 'package:image_picker/image_picker.dart';

abstract class HomeRepo {
  Future<Either<Failure, void>> uploadImage(XFile image);
}