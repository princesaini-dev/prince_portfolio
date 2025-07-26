import 'package:prince_portfolio/data/portfolio_data_model.dart';
import 'package:prince_portfolio/supabase_client.dart';
import 'package:prince_portfolio/utils/app_logger.dart';
import 'package:prince_portfolio/utils/app_utills.dart';

import '../presentation/resources/string_manager.dart';

class DatabaseServices {
  static Future<Object> getPortfolioData() async {
    try {
      // Wait for Supabase to be initialized
      await SupabaseClient.initializeDatabase();
      var client = SupabaseClient.instance;

      final results = await Future.wait([
        client.from('technologies').select(),
        client.from('projects').select(),
        client.from('about_me').select(),
        client.from('resumes').select(),
        client.from('social_media').select(),
      ]);

      var portfolioData = PortfolioDataModel.fromMap(
          aboutMeList: results[2],
          projectsList: results[1],
          technologiesList: results[0],
          resumesList: results[3],
          socialMediaList: results[4]);

      return portfolioData;
    } catch (e) {
      AppLogger.e('Database error: $e');
      return {};
    }
  }

  Future<void> insertContactFormDetail(
      {required String name,
      required String email,
      required String subject,
      required String message}) async {
    try {
      await SupabaseClient.instance.from('contact_form').insert({
        'name': name,
        'email': email,
        'subject': subject,
        'message': message
      }).onError(
        (error, stackTrace) {
          AppLogger.e('Function insertContactFormDetail() error: $error');
          return;
        },
      );
      AppUtills.showToast(StringManager.submittedSuccessfully);
    } catch (e) {
      AppLogger.e('Function insertContactFormDetail() error: $e');
    }
  }
}
