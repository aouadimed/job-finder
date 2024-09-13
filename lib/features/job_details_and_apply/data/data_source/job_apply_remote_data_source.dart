import 'package:cv_frontend/core/constants/constants.dart';
import 'package:cv_frontend/features/job_details_and_apply/domain/usecases/job_apply_use_case.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class JobApplyRemoteDataSource {
  Future<void> jobApply(JobApplyParams params);
}

class JobApplyRemoteDataSourceImpl implements JobApplyRemoteDataSource {
  final http.Client client;

  JobApplyRemoteDataSourceImpl({required this.client});

  @override
  Future<void> jobApply(JobApplyParams params) async {
    final baseurl = Uri.http(url, jobApplyurl);
    final headers = {
      'Content-Type': params.userProfile == false
          ? 'multipart/form-data'
          : 'application/json',
      'Authorization': 'Bearer ${TokenManager.token}',
    };

    if (params.userProfile == false) {
      final request = http.MultipartRequest('POST', baseurl)
        ..headers.addAll(headers)
        ..fields['jobId'] = params.jobId
        ..fields['useProfile'] = params.userProfile.toString()
        ..fields['motivationLetter'] = params.motivationLetter ?? '';

      if (params.cvUpload != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'cvUpload',
          params.cvUpload!,
        ));
      }
      final streamedResponse = await client.send(request);
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode != 201) {
        throw Exception(
            'Failed to apply for job. Status code: ${response.statusCode}');
      }
    } else {
      final body = jsonEncode({
        'jobId': params.jobId,
        'useProfile': params.userProfile ?? false,
      });

      final response = await client.post(baseurl, headers: headers, body: body);

      if (response.statusCode != 201) {
        throw Exception(
            'Failed to apply for job. Status code: ${response.statusCode}');
      }
    }
  }
}
