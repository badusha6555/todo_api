import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_api/controller/todo_provider.dart';

class AddTodo extends StatelessWidget {
  const AddTodo({super.key});

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Todo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: todoProvider.nameController,
              decoration: const InputDecoration(
                hintText: "Enter Todo Name",
              ),
            ),
            TextField(
              controller: todoProvider.descriptionController,
              decoration: const InputDecoration(
                hintText: "Enter Todo Description",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                todoProvider.addTodo();
                Navigator.pop(context);
              },
              child: const Text("Add Todo"),
            ),
          ],
        ),
      ),
    );
  }
}
