import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_app_api/model/todo_model.dart';
import 'package:todo_app_api/services/todo_services.dart';

class TodoProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  TodoServices todoServices = TodoServices();

  List<TodoModel> todoList = [];

  bool isLoading = false;

  get index => null;

  Future<void> getTodo() async {
    isLoading = true;
    notifyListeners();
    try {
      todoList = await todoServices.getTodo();
      notifyListeners();
    } catch (e) {
      log("error $e");
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> addTodo() async {
    isLoading = true;
    notifyListeners();
    try {
      await todoServices.addTodo(
        TodoModel(
          name: nameController.text,
          description: descriptionController.text,
        ),
      );
      notifyListeners();
      nameController.clear();
      descriptionController.clear();
      getTodo();
    } catch (e) {
      log("error $e");
    }
  }

  Future updateTodo(name, description, String id) async {
    try {
      await todoServices.updateTodo(
        TodoModel(
          name: name,
          description: description,
        ),
        id,
      );
      await getTodo();
    } catch (e) {
      log("error $e");
    }
  }

  Future deleteTodo(String id) async {
    try {
      await todoServices.deleteTodo(id);
      await getTodo();
      notifyListeners();
    } catch (e) {
      log("error $e");
    }
  }
}
