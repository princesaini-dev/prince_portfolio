import 'package:prince_portfolio/data/about_me_data_model.dart';

class PortfolioDataModel {
  final AboutMeDataModel? aboutMeDataModel;

  PortfolioDataModel({
    required this.aboutMeDataModel,
  });

  factory PortfolioDataModel.fromMap(AboutMeDataModel? aboutMeDataModel) {
    return PortfolioDataModel(
      aboutMeDataModel: aboutMeDataModel,
    );
  }

  // Convert PortfolioDataModel to a map for serialization
  Map<String, dynamic> toJson() {
    return {
      'aboutMeDataModel': aboutMeDataModel?.toJson(), // Handle the null case
    };
  }
}
