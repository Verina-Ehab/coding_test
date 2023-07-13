import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/strings/shpref_keys.dart';
import '../model/class_model.dart';

abstract class ClassLocalDataSource{
  Future<Unit> cacheClasses(List<ClassModel> classModels);
  Future<List<ClassModel>> getCachedClasses();
}

class ClassLocalDataSourceImp implements ClassLocalDataSource{

  final SharedPreferences sharedPreferences;
  ClassLocalDataSourceImp({required this.sharedPreferences});
  

  @override
  Future<Unit> cacheClasses(List<ClassModel> classModels) {
    List classModelsToJson = classModels
        .map<Map<String, dynamic>>((classModel) => classModel.toJson())
        .toList();
    sharedPreferences.setString(CACHED_CLASSES, json.encode(classModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<ClassModel>> getCachedClasses() {
    final jsonString = sharedPreferences.getString(CACHED_CLASSES);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<ClassModel> jsonToClassModels = decodeJsonData
          .map<ClassModel>((jsonClassModel) => ClassModel.fromJson(jsonClassModel))
          .toList();
      return Future.value(jsonToClassModels);
    } else {
      throw EmptyCacheException();
    }
  }

}