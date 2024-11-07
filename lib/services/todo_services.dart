import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:todo_app_api/model/todo_model.dart';

class TodoServices {
  final Dio dio = Dio();
  final String baseUrl =
      "https://672865dd270bd0b975553b91.mockapi.io/Description";

  Future<List<TodoModel>> getTodo() async {
    try {
      Response response = await dio.get(baseUrl);
      log("response ${response.data}");
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((e) => TodoModel.fromJson(e))
            .toList();
      } else {
        throw Exception("Error ");
      }
    } catch (e) {
      throw Exception("Failed to get data $e");
    }
  }

  Future addTodo(TodoModel todoModel) async {
    try {
      await dio.post(baseUrl, data: todoModel.toJson());
    } catch (e) {
      throw Exception("Failed to get data $e");
    }
  }

  Future updateTodo(TodoModel todoModel, String id) async {
    try {
      await dio.put("$baseUrl/$id", data: todoModel.toJson());
    } catch (e) {
      throw Exception("Failed to get data $e");
    }
  }

  Future deleteTodo(String id) async {
    try {
      await dio.delete("$baseUrl/$id");
    } catch (e) {
      throw Exception("Failed to get data $e");
    }
  }
}
