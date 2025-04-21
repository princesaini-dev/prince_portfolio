import 'package:prince_portfolio/data/about_me_data_model.dart';
import 'package:prince_portfolio/data/projects_data_model.dart';

class PortfolioDataModel {
  final AboutMeDataModel? aboutMeDataModel;
  final ProjectsDataModel? projectsDataModel;

  PortfolioDataModel({
    required this.aboutMeDataModel,
    required this.projectsDataModel,
  });

  factory PortfolioDataModel.fromMap(AboutMeDataModel? aboutMeDataModel,
      ProjectsDataModel? projectsDataModel) {
    return PortfolioDataModel(
      aboutMeDataModel: aboutMeDataModel,
      projectsDataModel: projectsDataModel,
    );
  }

  // Convert PortfolioDataModel to a map for serialization
  Map<String, dynamic> toJson() {
    return {
      'aboutMeDataModel': aboutMeDataModel?.toJson(), // Handle the null case
      'projectsDataModel': projectsDataModel?.toJson(),
    };
  }
}
