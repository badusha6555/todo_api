import 'package:flutter/material.dart';
import 'package:todo_app_api/controller/todo_provider.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_api/view/add_todo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void initState() {
    Provider.of<TodoProvider>(context, listen: false).getTodo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Consumer<TodoProvider>(
        builder: (context, value, child) => ListView.separated(
          itemCount: value.todoList.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.list),
              title: Text('Name : ${value.todoList[index].name}'),
              subtitle: Text(
                'Description : ${value.todoList[index].description}',
                style: TextStyle(
                  fontSize: 18,
                  color: const Color.fromARGB(255, 185, 39, 39),
                ),
              ),
              trailing: Consumer<TodoProvider>(
                builder: (context, value, child) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditBox(
                                context,
                                value.todoList[index].id,
                                value.todoList[index].name.toString(),
                                value.todoList[index].description.toString(),
                              ),
                            ));
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        Provider.of<TodoProvider>(context, listen: false)
                            .deleteTodo(value.todoList[index].id.toString());
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: Colors.black,
              thickness: 1,
              height: 1,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddTodo(),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  EditBox(
    context,
    id,
    String title,
    String description,
  ) {
    final TextEditingController titleController =
        TextEditingController(text: title);
    final TextEditingController descriptionController =
        TextEditingController(text: description);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("EDIT TODO"),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: "Title"),
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: "Description"),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    String newTitle = titleController.text.trim();
                    String newDescription = descriptionController.text.trim();
                    Provider.of<TodoProvider>(context, listen: false)
                        .updateTodo(newTitle, newDescription, id);
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.update),
                  label: const Text("UPDATE"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
