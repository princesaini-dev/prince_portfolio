import 'package:flutter/material.dart';
import 'package:prince_portfolio/domain/contact_form_service.dart';
import 'package:prince_portfolio/presentation/resources/color_manager.dart';
import 'package:prince_portfolio/presentation/resources/string_manager.dart';
import 'package:prince_portfolio/utils/app_utills.dart';
import 'package:prince_portfolio/utils/extention_context.dart';
import 'package:prince_portfolio/utils/responsive.dart';

class ContactMe extends StatefulWidget {
  const ContactMe({super.key});

  @override
  State<ContactMe> createState() => _ContactMeState();
}

class _ContactMeState extends State<ContactMe>
    with SingleTickerProviderStateMixin {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _subjectController;
  late TextEditingController _messageController;
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;

  String nameValidationError = '';
  String emailValidationError = '';
  String subjectValidationError = '';
  String messageValidationError = '';

  bool isFormSubmiting = false;
  bool _isSubmitHovered = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _subjectController = TextEditingController();
    _messageController = TextEditingController();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: ColorManager.backgroundGradient(context),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.isMobile(context) ? 20 : context.width * 0.1,
          vertical: 80,
        ),
        child: Column(
          children: [
            _buildSectionHeader(context),
            const SizedBox(height: 60),
            _contactMeFormView(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: ColorManager.accentPrimary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'CONTACT',
              style: TextStyle(
                color: ColorManager.accentPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
          ),
          const SizedBox(height: 16),
          ShaderMask(
            shaderCallback: (bounds) =>
                ColorManager.primaryGradient(context).createShader(bounds),
            child: Text(
              StringManager.contact,
              style: TextStyle(
                color: Colors.white,
                fontSize: Responsive.isMobile(context) ? 32 : 42,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Let's work together on your next project",
            style: TextStyle(
              color: ColorManager.blackColor(context).withOpacity(0.6),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _contactMeFormView() {
    var width =
        Responsive.isMobile(context) ? double.infinity : context.width * .5;
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        width: width,
        padding: EdgeInsets.all(Responsive.isMobile(context) ? 24 : 40),
        decoration: BoxDecoration(
          color: ColorManager.cardColor(context),
          borderRadius: BorderRadius.circular(24),
          boxShadow: ColorManager.cardShadow(context),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: ColorManager.primaryGradient(context),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.mail_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Send a Message',
                      style: TextStyle(
                        color: ColorManager.blackColor(context),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "I'll get back to you soon",
                      style: TextStyle(
                        color:
                            ColorManager.blackColor(context).withOpacity(0.6),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildTextField(
              label: 'Full Name',
              hint: 'Enter your name',
              controller: _nameController,
              errorText: nameValidationError,
              icon: Icons.person_rounded,
              inputType: TextInputType.name,
              onChange: () => setState(() => nameValidationError = ''),
            ),
            const SizedBox(height: 20),
            _buildTextField(
              label: 'Email',
              hint: 'Enter your email',
              controller: _emailController,
              errorText: emailValidationError,
              icon: Icons.email_rounded,
              inputType: TextInputType.emailAddress,
              onChange: () => setState(() => emailValidationError = ''),
            ),
            const SizedBox(height: 20),
            _buildTextField(
              label: 'Subject',
              hint: 'What is this about?',
              controller: _subjectController,
              errorText: subjectValidationError,
              icon: Icons.subject_rounded,
              inputType: TextInputType.text,
              onChange: () => setState(() => subjectValidationError = ''),
            ),
            const SizedBox(height: 20),
            _buildTextField(
              label: 'Message',
              hint: 'Write your message here...',
              controller: _messageController,
              errorText: messageValidationError,
              icon: Icons.message_rounded,
              inputType: TextInputType.multiline,
              onChange: () => setState(() => messageValidationError = ''),
              lines: 5,
            ),
            const SizedBox(height: 32),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required String errorText,
    required IconData icon,
    required TextInputType inputType,
    required VoidCallback onChange,
    int lines = 1,
  }) {
    final hasError = errorText.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: hasError
                  ? Colors.red
                  : ColorManager.blackColor(context).withOpacity(0.5),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: hasError
                    ? Colors.red
                    : ColorManager.blackColor(context).withOpacity(0.7),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          maxLines: lines,
          keyboardType: inputType,
          onChanged: (_) => onChange(),
          style: TextStyle(
            fontSize: 15,
            color: ColorManager.blackColor(context),
            fontWeight: FontWeight.w500,
          ),
          cursorColor: ColorManager.accentPrimary,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 14,
              color: ColorManager.blackColor(context).withOpacity(0.4),
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: ColorManager.blackColor(context).withOpacity(0.03),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: hasError
                    ? Colors.red.withOpacity(0.5)
                    : ColorManager.blackColor(context).withOpacity(0.08),
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: hasError ? Colors.red : ColorManager.accentPrimary,
                width: 2,
              ),
            ),
            errorText: hasError ? errorText : null,
            errorStyle: const TextStyle(
              fontSize: 12,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return MouseRegion(
      onEnter: (_) => setState(() => _isSubmitHovered = true),
      onExit: (_) => setState(() => _isSubmitHovered = false),
      child: GestureDetector(
        onTap: _submitForm,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            gradient: ColorManager.primaryGradient(context),
            borderRadius: BorderRadius.circular(14),
            boxShadow: _isSubmitHovered
                ? [
                    BoxShadow(
                      color: ColorManager.accentPrimary.withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: ColorManager.accentPrimary.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isFormSubmiting)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              else ...[
                const Text(
                  'Send Message',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(width: 10),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  transform: Matrix4.translationValues(
                    _isSubmitHovered ? 4 : 0,
                    0,
                    0,
                  ),
                  child: const Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (isFormSubmiting) return;
    setState(() => isFormSubmiting = true);

    if (_validateForm()) {
      final success = await ContactFormService().submitContactForm(
        name: _nameController.text,
        email: _emailController.text,
        subject: _subjectController.text,
        message: _messageController.text,
      );

      if (success) {
        AppUtills.showToast(StringManager.submittedSuccessfully);
        _nameController.clear();
        _emailController.clear();
        _subjectController.clear();
        _messageController.clear();
      } else {
        AppUtills.showToast(StringManager.someThingWentWrong);
      }
    }

    setState(() => isFormSubmiting = false);
  }

  bool _validateForm() {
    bool isValid = true;

    if (_nameController.text.isEmpty) {
      nameValidationError = StringManager.nameValidationError;
      isValid = false;
    }
    if (_emailController.text.isEmpty) {
      emailValidationError = StringManager.emailValidationError;
      isValid = false;
    }
    if (_subjectController.text.isEmpty) {
      subjectValidationError = StringManager.subjectValidationError;
      isValid = false;
    }
    if (_messageController.text.isEmpty) {
      messageValidationError = StringManager.messageValidationError;
      isValid = false;
    }

    setState(() {});
    return isValid;
  }
}
