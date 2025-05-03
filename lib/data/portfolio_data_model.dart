import 'package:prince_portfolio/data/about_me_data_model.dart';
import 'package:prince_portfolio/data/projects_data_model.dart';
import 'package:prince_portfolio/data/social_media_data_model.dart';
import 'package:prince_portfolio/data/technology_data_model.dart';

class PortfolioDataModel {
  final AboutMeDataModel? aboutMeDataModel;
  final List<ProjectsDataModel>? projectsDataModel;
  final List<TechnologyDataModel>? technologiesDataModel;
  final String? resumesURL;
  final List<SocialMediaDataModel>? socialMediaDataModel;

  PortfolioDataModel({
    required this.aboutMeDataModel,
    required this.projectsDataModel,
    required this.technologiesDataModel,
    required this.resumesURL,
    required this.socialMediaDataModel,
  });

  factory PortfolioDataModel.fromMap({
    required List<dynamic>? aboutMeList,
    required List<dynamic>? projectsList,
    required List<dynamic>? technologiesList,
    required List<dynamic>? resumesList,
    required List<dynamic>? socialMediaList,
  }) {
    return PortfolioDataModel(
      aboutMeDataModel: aboutMeList != null && aboutMeList.isNotEmpty
          ? AboutMeDataModel.fromMap(aboutMeList.first)
          : null,
      projectsDataModel:
          projectsList?.map((item) => ProjectsDataModel.fromMap(item)).toList(),
      technologiesDataModel: technologiesList
          ?.map((item) => TechnologyDataModel.fromMap(item))
          .toList(),
      resumesURL: resumesList != null && resumesList.isNotEmpty
          ? resumesList.first['url']
          : null,
      socialMediaDataModel: socialMediaList
          ?.map((item) => SocialMediaDataModel.fromMap(item))
          .toList(),
    );
  }

  List<ProjectsDataModel> getProjectList() {
    var list = projectsDataModel ?? [];
    list.sort((a, b) => (a.index).compareTo(b.index));
    return list;
  }
}
