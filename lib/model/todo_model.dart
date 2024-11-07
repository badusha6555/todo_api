class TodoModel {
  String? id;
  String? name;
  String? description;

  TodoModel({
    this.id,
    required this.name,
    required this.description,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["description"] = description;
    return data;
  }
}
