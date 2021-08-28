class Todo {
  String? id;
  String title;
  String description;
  DateTime createdOn;
  DateTime? completedOn;

  Todo({
    this.id,
    required this.title,
    required this.description,
    required this.createdOn,
    this.completedOn,
  });

  @override
  String toString() {
    return 'Todo(id: $id, title: $title, description: $description, createdOn: $createdOn, completedOn: $completedOn)';
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['title'] = title;
    data['description'] = description;
    data['createdOn'] = createdOn.toIso8601String();
    if (completedOn != null) {
      data['completedOn'] = completedOn!.toIso8601String();
    }
    return data;
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      createdOn: DateTime.parse(map['createdOn']),
      completedOn: map['completedOn'] != null ? DateTime.parse(map['completedOn']) : null,
    );
  }
}
