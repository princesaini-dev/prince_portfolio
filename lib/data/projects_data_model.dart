class ProjectsDataModel {
  final int id;
  final int index;
  final DateTime createdAt;
  final String title;
  final String description;
  final String? imageUrl;
  final String? liveUrl;

  ProjectsDataModel({
    required this.id,
    required this.index,
    required this.createdAt,
    required this.title,
    required this.description,
    this.imageUrl,
    this.liveUrl,
  });

  factory ProjectsDataModel.fromMap(Map<String, dynamic> map) {
    return ProjectsDataModel(
      id: map['id'],
      index: map['index'],
      createdAt: DateTime.parse(map['created_at']),
      title: map['title'],
      description: map['description'],
      imageUrl: map['image_url'],
      liveUrl: map['live_url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'index': index,
      'created_at': createdAt.toIso8601String(),
      'title': title,
      'description': description,
      'image_url': imageUrl,
      'live_url': liveUrl,
    };
  }

  static List<ProjectsDataModel> fromList(List<dynamic> list) {
    return list.map((item) => ProjectsDataModel.fromMap(item)).toList();
  }
}
