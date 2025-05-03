class SocialMediaDataModel {
  final String imageUrl;
  final String name;
  final String link;

  SocialMediaDataModel({
    required this.imageUrl,
    required this.name,
    required this.link,
  });

  factory SocialMediaDataModel.fromMap(Map<String, dynamic> map) {
    return SocialMediaDataModel(
      imageUrl: map['image_url'],
      name: map['name'],
      link: map['link'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image_url': imageUrl,
      'name': name,
      'link': link,
    };
  }
}
