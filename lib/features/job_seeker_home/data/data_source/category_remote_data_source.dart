import 'package:cv_frontend/core/constants/constants.dart';
import 'package:cv_frontend/core/errors/exceptions.dart';
import 'package:cv_frontend/features/job_seeker_home/data/models/categorie_selection_model.dart';
import 'package:http/http.dart' as https;

abstract class CategoryRemoteDataSource {
  Future<List<CategorySelectionModel>> getJobCategorys();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final https.Client client;

  CategoryRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CategorySelectionModel>> getJobCategorys() async {
    try {
      final response = await https.get(
        Uri.https(url, jobcategoryData),
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer ${TokenManager.token}",
        },
      ).catchError((e) {
        throw ServerException();
      });

      if (response.statusCode == 200) {
        return categorySelectionModelFromJson(response.body);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
