import 'package:flutter/material.dart';
import 'package:prince_portfolio/data/portfolio_data_model.dart';
import 'package:prince_portfolio/data/projects_data_model.dart';
import 'package:prince_portfolio/presentation/base/custom_text_widget.dart';
import 'package:prince_portfolio/presentation/dashboard/components/projects/project_list.dart';
import 'package:prince_portfolio/presentation/resources/image_manager.dart';
import 'package:prince_portfolio/presentation/resources/string_manager.dart';
import 'package:prince_portfolio/utils/app_utills.dart';
import 'package:prince_portfolio/utils/extention_context.dart';

class Projects extends StatelessWidget {
  final PortfolioDataModel portfolioDataModel;

  const Projects({required this.portfolioDataModel, super.key});

  @override
  Widget build(BuildContext context) {
    var projectList = portfolioDataModel.getProjectList();
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: context.width * 0.04, vertical: 25),
      child: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          const CustomTextWidget(
            text: StringManager.projects,
            latterSpacing: 4,
            fontSize: 42,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(
            height: 25,
          ),
          SizedBox(
            height: 310,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    _projectItemView(projectList[index], context),
                    const SizedBox(
                      width: 26,
                    )
                  ],
                );
              },
              itemCount: projectList.length,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }

  Widget _projectItemView(ProjectsDataModel project, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (project.liveUrl != null && project.liveUrl!.isNotEmpty) {
          _onProjectClick(project.liveUrl!);
        } else {}
      },
      child: Card(
        elevation: 4,
        child: Stack(children: [
          SizedBox(
            width: 400,
            child: Opacity(
              opacity: 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: project.imageUrl != null && project.imageUrl!.isNotEmpty
                    ? Image.network(
                        project.imageUrl!,
                        fit: BoxFit.fill,
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ),
          SizedBox(
            width: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 12,
                ),
                CustomTextWidget(
                  text: project.title,
                  latterSpacing: 2,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: CustomTextWidget(
                    text: project.description,
                    latterSpacing: 2,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }

  void _onProjectClick(String url) {
    if (url.isNotEmpty) {
      AppUtills.loadUrl(url);
    }
  }
}
