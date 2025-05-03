class AboutMeDataModel {
  final int id;
  final DateTime createdAt;
  final String fullName;
  final String email;
  final String location;
  final String title;
  final String description;
  final String welcomeText;
  final String introTitle;
  final String objective;

  AboutMeDataModel({
    required this.id,
    required this.createdAt,
    required this.fullName,
    required this.email,
    required this.location,
    required this.title,
    required this.description,
    required this.welcomeText,
    required this.introTitle,
    required this.objective,
  });

  factory AboutMeDataModel.fromMap(Map<String, dynamic> data) {
    return AboutMeDataModel(
      id: data['id'],
      createdAt: DateTime.parse(data['created_at']),
      fullName: data['full_name'] ?? '',
      email: data['email'] ?? '',
      location: data['location'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      welcomeText: data['welcome_text'] ?? '',
      introTitle: data['intro_title'] ?? '',
      objective: data['objective'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'full_name': fullName,
      'title': title,
      'description': description,
      'welcome_text': welcomeText,
      'intro_title': introTitle,
      'objective': objective,
    };
  }

  static AboutMeDataModel fromList(List<dynamic> list) {
    if (list.isNotEmpty) {
      return AboutMeDataModel.fromMap(list.first);
    } else {
      throw Exception("About Me list is empty");
    }
  }
}
