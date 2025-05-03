import 'package:prince_portfolio/data/portfolio_data_model.dart';
import 'package:prince_portfolio/supabase_client.dart';
import 'package:prince_portfolio/utils/app_logger.dart';
import 'package:prince_portfolio/utils/app_utills.dart';

import '../presentation/resources/string_manager.dart';

class DatabaseServices {
  Future<PortfolioDataModel?> getPortfolioData() async {
    try {
      final technologies =
          await SupabaseClient.instance.from('technologies').select();
      final projects = await SupabaseClient.instance.from('projects').select();
      final aboutMe = await SupabaseClient.instance.from('about_me').select();
      final resumes = await SupabaseClient.instance.from('resumes').select();
      final socialMedia =
          await SupabaseClient.instance.from('social_media').select();

      AppLogger.i(
          'technologies ::: $technologies \n projects ::: $projects \n aboutMe ::: $aboutMe \n resumes ::: $resumes \n socialMedia ::: $socialMedia');

      PortfolioDataModel portfolioDataModel = PortfolioDataModel.fromMap(
          aboutMeList: aboutMe,
          projectsList: projects,
          technologiesList: technologies,
          resumesList: resumes,
          socialMediaList: socialMedia);
      return portfolioDataModel;
    } catch (e) {
      AppLogger.e('Function getPortfolioData() error: $e');
      return null;
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
