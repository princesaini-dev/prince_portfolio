import 'package:prince_portfolio/data/about_me_data_model.dart';
import 'package:prince_portfolio/data/projects_data_model.dart';
import 'package:prince_portfolio/data/technology_data_model.dart';

class PortfolioDataModel {
  final AboutMeDataModel? aboutMeDataModel;
  final List<ProjectsDataModel>? projectsDataModel;
  final List<TechnologyDataModel>? technologiesDataModel;

  PortfolioDataModel({
    required this.aboutMeDataModel,
    required this.projectsDataModel,
    required this.technologiesDataModel,
  });

  factory PortfolioDataModel.fromMap({
    required List<dynamic>? aboutMeList,
    required List<dynamic>? projectsList,
    required List<dynamic>? technologiesList,
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
    );
  }

  List<ProjectsDataModel> getProjectList() {
    var list = projectsDataModel ?? [];
    list.sort((a, b) => (a.index).compareTo(b.index));
    return list;
  }
}
