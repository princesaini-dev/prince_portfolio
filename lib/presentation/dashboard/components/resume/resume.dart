import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:prince_portfolio/presentation/base/custom_text_widget.dart';
import 'package:prince_portfolio/presentation/resources/color_manager.dart';
import 'package:prince_portfolio/presentation/resources/string_manager.dart';
import 'package:prince_portfolio/utils/app_utills.dart';
import 'package:prince_portfolio/utils/extention_context.dart';
import 'package:prince_portfolio/utils/responsive.dart';

class MyResume extends StatelessWidget {
  const MyResume({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 25,
          ),
          const CustomTextWidget(
            text: StringManager.resume,
            latterSpacing: 4,
            fontSize: 42,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(
            height: 25,
          ),
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.file_copy,
                        color: ColorManager.redColor(context),
                        size: 26,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const CustomTextWidget(
                        text: StringManager.myResume,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )
                    ],
                  ),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                        elevation: 10,
                        shadowColor: ColorManager.redColor(context),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        backgroundColor: ColorManager.redColor(context),
                        foregroundColor: ColorManager.blackColor(context)),
                    onPressed: () {
                      showAlertDialog(context);
                    },
                    label: const CustomTextWidget(
                      text: StringManager.downloadResume,
                      fontSize: 16,
                    ),
                    icon: Icon(
                      Icons.file_download,
                      color: ColorManager.blackColor(context),
                      size: 22,
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }

  void showAlertDialog(BuildContext context) {
    AwesomeDialog(
      dialogBackgroundColor: ColorManager.greyColor(context),
      width: Responsive.isDesktop(context) ? 500 : context.width * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.bottomSlide,
      title: StringManager.resumeAlertTitle,
      desc: StringManager.resumeAlertDescription,
      btnOk: TextButton(
          style: TextButton.styleFrom(
              padding: const EdgeInsets.all(12),
              backgroundColor: ColorManager.redColor(context)),
          onPressed: () {
            Navigator.pop(context);
            downloadResume();
          },
          child: CustomTextWidget(
            text: StringManager.downloadResume,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: ColorManager.blackColor(context),
          )),
      btnCancel: TextButton(
          style: TextButton.styleFrom(
              padding: const EdgeInsets.all(12),
              backgroundColor: ColorManager.blackColor(context)),
          onPressed: () {
            Navigator.pop(context);
          },
          child: CustomTextWidget(
            text: StringManager.cancel,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: ColorManager.whiteColor(context),
          )),
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
    ).show();
  }

  Future<void> downloadResume() async {
    AppUtills.loadUrl(StringManager.resumeDownloadUrl);
  }
}
