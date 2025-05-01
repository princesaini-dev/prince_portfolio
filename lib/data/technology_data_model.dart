class TechnologyDataModel {
  final int id;
  final DateTime createdAt;
  final String name;

  TechnologyDataModel({
    required this.id,
    required this.createdAt,
    required this.name,
  });

  factory TechnologyDataModel.fromMap(Map<String, dynamic> map) {
    return TechnologyDataModel(
      id: map['id'],
      createdAt: DateTime.parse(map['created_at']),
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'name': name,
    };
  }

  static List<TechnologyDataModel> fromList(List<dynamic> list) {
    return list.map((item) => TechnologyDataModel.fromMap(item)).toList();
  }
}
