import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../../core/errors/exceptions.dart';
import '../../../../core/strings/urls.dart';
import '../model/class_model.dart';

abstract class ClassRemoteDataSource {
  Future<List<ClassModel>> getAllClasses();
}

class ClassRemoteDataSourceImp implements ClassRemoteDataSource {
  final http.Client client;
  ClassRemoteDataSourceImp({required this.client});

  @override
  Future<List<ClassModel>> getAllClasses() async {
    final response = await client.get(
      Uri.parse(PHOTOSCLASSES_URL),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      final List<ClassModel> postModels = decodedJson
          .map<ClassModel>((jsonPostModel) => ClassModel.fromJson(jsonPostModel))
          .toList();

      return postModels;
    } else {
      throw ServerException();
    }
  }
 
}
