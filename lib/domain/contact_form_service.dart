import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prince_portfolio/utils/app_logger.dart';

/// Service to handle contact form submissions to Firebase Firestore
class ContactFormService {
  static final ContactFormService _instance = ContactFormService._internal();
  factory ContactFormService() => _instance;
  ContactFormService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collectionName = 'contact_submissions';

  /// Submit contact form data to Firestore
  Future<bool> submitContactForm({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    try {
      await _firestore.collection(_collectionName).add({
        'name': name,
        'email': email,
        'subject': subject,
        'message': message,
        'submitted_at': FieldValue.serverTimestamp(),
        'read': false,
      });
      AppLogger.i('Contact form submitted successfully');
      return true;
    } catch (e) {
      AppLogger.e('Error submitting contact form: $e');
      return false;
    }
  }
}
