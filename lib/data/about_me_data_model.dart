class AboutMeDataModel {
  final String fullName;
  final String title;
  final String description;
  final String welcomeText;

  AboutMeDataModel({
    required this.fullName,
    required this.title,
    required this.description,
    required this.welcomeText,
  });

  factory AboutMeDataModel.fromMap(Map<String, dynamic> data) {
    return AboutMeDataModel(
      fullName: data['full_name'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      welcomeText: data['welcome_text'] ?? '',
    );
  }

  // Convert AboutMeDataModel to a map for serialization
  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'title': title,
      'description': description,
      'welcome_text': welcomeText,
    };
  }
}
