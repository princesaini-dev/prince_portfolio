class AboutMeDataModel {
  final String fullName;
  final String title;
  final String description;
  final String welcomeText;
  final String introTitle;
  final String objective;
  final List<String> technologies;

  AboutMeDataModel({
    required this.fullName,
    required this.title,
    required this.description,
    required this.welcomeText,
    required this.introTitle,
    required this.objective,
    required this.technologies,
  });

  factory AboutMeDataModel.fromMap(Map<String, dynamic> data) {
    return AboutMeDataModel(
      fullName: data['full_name'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      welcomeText: data['welcome_text'] ?? '',
      introTitle: data['intro_title'] ?? '',
      objective: data['objective'] ?? '',
      technologies: List<String>.from(data['technologies'] ?? []),
    );
  }

  // Convert AboutMeDataModel to a map for serialization
  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'title': title,
      'description': description,
      'welcome_text': welcomeText,
      'intro_title': introTitle,
      'objective': objective,
      'technologies': technologies,
    };
  }
}
