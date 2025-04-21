class ProjectsDataModel {
  final List<Map<String, dynamic>> projectList;

  ProjectsDataModel({
    required this.projectList,
  });

  factory ProjectsDataModel.fromMap(Map<String, dynamic> data) {
    return ProjectsDataModel(
      projectList: List<Map<String, dynamic>>.from(
        data['projectList'],
      ),
    );
  }

  // Convert ProjectsDataModel to a map for serialization
  Map<String, dynamic> toJson() {
    return {
      'projectList': projectList,
    };
  }
}
