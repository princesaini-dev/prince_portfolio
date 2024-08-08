import 'package:flutter/material.dart';
import 'package:prince_portfolio/presentation/base/custom_text_widget.dart';
import 'package:prince_portfolio/presentation/resources/color_manager.dart';
import 'package:prince_portfolio/presentation/resources/string_manager.dart';
import 'package:prince_portfolio/utils/extention_context.dart';
import 'package:prince_portfolio/utils/responsive.dart';

class ContactMe extends StatelessWidget {
  ContactMe({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: context.width * 0.08, vertical: 25),
      child: GridView.count(
        crossAxisCount: Responsive.isMobile(context) ? 1 : 2,
        shrinkWrap: true,
        crossAxisSpacing: 25,
        childAspectRatio: (1 / .6),
        mainAxisSpacing: 25,
        children: _contactMenuList.asMap().entries.map((item) {
          return _contectItemView(_contactMenuList[item.key], context);
        }).toList(),
      ),
    );
  }

  ///
  /// Contact Item View for contact me section
  ///
  Widget _contectItemView(ContactMenu contactMenu, BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            contactMenu.icon,
            color: ColorManager.redColor(context),
            size: 32,
          ),
          const SizedBox(
            height: 12,
          ),
          CustomTextWidget(
            text: contactMenu.title,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(
            height: 12,
          ),
          CustomTextWidget(
            text: contactMenu.description,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  ///
  /// Contact Menu list for contact me section
  ///
  final List<ContactMenu> _contactMenuList = [
    const ContactMenu(
        title: StringManager.email,
        description: StringManager.emailDescription,
        icon: Icons.email),
    const ContactMenu(
        title: StringManager.phone,
        description: StringManager.phoneDescription,
        icon: Icons.phone),
    const ContactMenu(
        title: StringManager.location,
        description: StringManager.locationDescription,
        icon: Icons.location_on),
  ];
}

///
/// Contact Menu class for contact me section
///
class ContactMenu {
  final String title;
  final String description;
  final IconData icon;

  const ContactMenu(
      {required this.title, required this.description, required this.icon});
}
