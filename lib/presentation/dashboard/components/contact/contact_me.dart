import 'package:flutter/material.dart';
import 'package:prince_portfolio/domain/database_services.dart';
import 'package:prince_portfolio/presentation/base/custom_text_widget.dart';
import 'package:prince_portfolio/presentation/resources/color_manager.dart';
import 'package:prince_portfolio/presentation/resources/string_manager.dart';
import 'package:prince_portfolio/utils/extention_context.dart';
import 'package:prince_portfolio/utils/responsive.dart';

class ContactMe extends StatefulWidget {
  ContactMe({super.key});

  @override
  State<ContactMe> createState() => _ContactMeState();
}

class _ContactMeState extends State<ContactMe> {
  TextEditingController? _nameController;
  TextEditingController? _emailController;
  TextEditingController? _subjectController;
  TextEditingController? _messageController;

  String nameValidationError = '';
  String emailValidationError = '';
  String subjectValidationError = '';
  String messageValidationError = '';

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _subjectController = TextEditingController();
    _messageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController!.dispose();
    _emailController!.dispose();
    _subjectController!.dispose();
    _messageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: context.width * 0.08, vertical: 25),
      child: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          const CustomTextWidget(
            text: StringManager.contact,
            latterSpacing: 4,
            fontSize: 42,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(
            height: 25,
          ),
          _contactMeFormView()
        ],
      ),
    );
  }

  ///
  /// Contact me form view
  ///
  Widget _contactMeFormView() {
    var width =
        Responsive.isMobile(context) ? double.infinity : context.width * .5;
    return SizedBox(
      width: width,
      child: Column(
        spacing: 35,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _textFieldDecoration(
            hintText: 'Full Name',
            controller: _nameController!,
            errorText: nameValidationError,
            inputType: TextInputType.name,
            onChange: () => nameValidationError = '',
          ),
          _textFieldDecoration(
            hintText: 'Email',
            controller: _emailController!,
            errorText: emailValidationError,
            inputType: TextInputType.emailAddress,
            onChange: () => emailValidationError = '',
          ),
          _textFieldDecoration(
            hintText: 'Subject',
            controller: _subjectController!,
            errorText: subjectValidationError,
            inputType: TextInputType.text,
            onChange: () => subjectValidationError = '',
          ),
          _textFieldDecoration(
              hintText: 'Message',
              controller: _messageController!,
              errorText: messageValidationError,
              inputType: TextInputType.text,
              onChange: () => messageValidationError = '',
              lines: 8),
          ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.redColor(context),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                foregroundColor: ColorManager.blackColor(context),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                child: Text(
                  'Submit',
                  style: TextStyle(
                      color: ColorManager.blackColor(context),
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ))
        ],
      ),
    );
  }

  ///
  /// Text field decoration
  ///
  Widget _textFieldDecoration(
      {required String hintText,
      required TextInputType inputType,
      required TextEditingController controller,
      required String errorText,
      required Function() onChange,
      int lines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: lines,
      onChanged: (value) {
        onChange();
        setState(() {});
      },
      decoration: InputDecoration(
          fillColor: ColorManager.blackColor(context).withAlpha(25),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                  color: errorText.isEmpty
                      ? ColorManager.blackColor(context)
                      : ColorManager.redColor(context),
                  width: 1)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          hintText: hintText,
          filled: true,
          errorText: errorText.isNotEmpty ? errorText : null,
          enabledBorder: null,
          errorStyle: TextStyle(
            fontSize: 12,
            color: ColorManager.redColor(context),
          ),
          hintStyle: TextStyle(
              fontSize: 15,
              color: ColorManager.blackColor(context).withAlpha(200),
              fontWeight: FontWeight.w400)),
      cursorColor: ColorManager.blackColor(context),
      style: TextStyle(
          fontSize: 16,
          color: ColorManager.blackColor(context),
          fontWeight: FontWeight.w500),
      keyboardType: inputType,
    );
  }

  ///
  /// This function is used to submit the form.
  ///
  Future<void> _submitForm() async {
    if (_validateForm()) {
      await DatabaseServices().insertContactFormDetail(
          name: _nameController?.text ?? "",
          email: _emailController?.text ?? "",
          subject: _subjectController?.text ?? "",
          message: _messageController?.text ?? "");
      _nameController?.clear();
      _emailController?.clear();
      _subjectController?.clear();
      _messageController?.clear();
    }
    setState(() {});
  }

  ///
  /// this function is used to validate form fields.
  ///
  bool _validateForm() {
    if (_nameController!.text.isEmpty) {
      nameValidationError = StringManager.nameValidationError;
      return false;
    }
    if (_emailController!.text.isEmpty) {
      emailValidationError = StringManager.emailValidationError;
      return false;
    }
    if (_subjectController!.text.isEmpty) {
      subjectValidationError = StringManager.subjectValidationError;
      return false;
    }
    if (_messageController!.text.isEmpty) {
      messageValidationError = StringManager.messageValidationError;
      return false;
    } else {
      return true;
    }
  }
}
