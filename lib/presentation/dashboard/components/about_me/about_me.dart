import 'package:flutter/material.dart';
import 'package:prince_portfolio/presentation/base/custom_text_widget.dart';
import 'package:prince_portfolio/presentation/dashboard/components/about_me/question_mark_animation.dart';
import 'package:prince_portfolio/presentation/resources/color_manager.dart';
import 'package:prince_portfolio/presentation/resources/string_manager.dart';
import 'package:prince_portfolio/utils/extention_context.dart';
import 'package:prince_portfolio/utils/responsive.dart';

class AboutMe extends StatelessWidget {
  AboutMe({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CustomTextWidget(
          text: StringManager.aboutMe,
          latterSpacing: 4,
          fontSize: 42,
          fontWeight: FontWeight.w500,
        ),
        const CustomTextWidget(
          text: StringManager.getToKnowMe,
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
        const SizedBox(
          height: 25,
        ),
        Responsive.isDesktop(context)
            ? _desktopWidget(context)
            : _mobileTabWidget(context),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }

  ///
  /// Desktop Widget for about me section
  ///
  Widget _desktopWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: context.width * .3,
          child: QuestionMarkAnimation(
            width: context.width * .2,
          ),
        ),
        SizedBox(
          width: context.width * .7,
          child: Padding(
            padding: const EdgeInsets.only(left: 18, right: 28),
            child: _descriptionWidget(context),
          ),
        )
      ],
    );
  }

  ///
  /// Mobile and tab Widget for about me section
  ///
  Widget _mobileTabWidget(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          right: 0,
          top: 0,
          left: 0,
          child: Opacity(
            opacity: 0.2,
            child: QuestionMarkAnimation(
              width: context.width * .5,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: _descriptionWidget(context),
        ),
      ],
    );
  }

  ///
  /// This function will return the wideget for description view
  ///
  Widget _descriptionWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        const CustomTextWidget(
          text: StringManager.whoAmI,
          color: Colors.red,
          fontSize: 18,
        ),
        const SizedBox(
          height: 20,
        ),
        const CustomTextWidget(
          text: StringManager.myInto,
          fontSize: 24,
        ),
        const SizedBox(
          height: 25,
        ),
        const CustomTextWidget(
          text: StringManager.myObjective,
          latterSpacing: 2,
          fontSize: 15,
          fontWeight: FontWeight.w200,
        ),
        const SizedBox(
          height: 16,
        ),
        Divider(
          color: ColorManager.blackColor(context).withOpacity(.5),
        ),
        const SizedBox(
          height: 16,
        ),
        const CustomTextWidget(
          text: StringManager.technologyWorkedWith,
          color: Colors.red,
          latterSpacing: 2,
          fontSize: 18,
        ),
        const SizedBox(
          height: 12,
        ),
        _technologyWidget()
      ],
    );
  }

  ///
  /// This function will return the list of technology
  ///
  Widget _technologyWidget() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: technologyList.map((item) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.forward,
                size: 20,
                color: Colors.red,
              ),
              const SizedBox(
                width: 10,
              ),
              CustomTextWidget(
                text: item,
                latterSpacing: 2,
                fontSize: 14,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  ///
  /// This list will store the list of technology
  ///
  final List<String> technologyList = [
    StringManager.flutter,
    StringManager.dart,
    StringManager.git,
    StringManager.android,
    StringManager.kotlin,
    StringManager.firebase,
  ];
}
