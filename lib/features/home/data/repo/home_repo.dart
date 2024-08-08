import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/config/api/api_config.dart';
import '../../../../core/errors/server_failure.dart';
import '../../../domain/repo/home_repo.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/config/api/api_service.dart';
import 'package:alhayat_task/core/errors/failure.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiService _apiService;

  HomeRepoImpl(this._apiService);

  @override
  Future<Either<Failure, void>> uploadImage(XFile image) async {
    try {
      FormData formData = FormData.fromMap({
        'medical_files': [
          {
            "chronic_diseases": [
              {"name": "Diabetes", "date": "2020-01-01"}
            ],
            "medications_taken": [
              {"name": "Insulin", "date": "2020-02-01"}
            ],
            'vaccinations_date': [
              {
                'img': await MultipartFile.fromFile(
                  image.path,
                  filename: image.path.split('/').last,
                  contentType: MediaType('image', image.path.split('.').last),
                ),
                'date': '2024-08-18',
              },
            ],
          }
        ]
      });
      var date = await _apiService.sendFormData(
        endpoint: APIConfig.uploadImage,
        token: '205|OuolgCzfqCv3ixmg2kU3DU9rdBHw8zdKPDPej8S42726bf99',
        formData: formData,
      );
      print(date);
      return const Right(null);
    } on Exception catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
