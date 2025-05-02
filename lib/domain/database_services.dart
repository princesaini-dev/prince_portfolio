import 'package:prince_portfolio/data/portfolio_data_model.dart';
import 'package:prince_portfolio/supabase_client.dart';
import 'package:prince_portfolio/utils/app_logger.dart';

class DatabaseServices {
  Future<PortfolioDataModel?> getPortfolioData() async {
    try {
      final technologies =
          await SupabaseClient.instance.from('technologies').select();
      final projects = await SupabaseClient.instance.from('projects').select();
      final aboutMe = await SupabaseClient.instance.from('about_me').select();
      final resumes = await SupabaseClient.instance.from('resumes').select();

      AppLogger.i(
          'technologies ::: $technologies \n projects ::: $projects \n aboutMe ::: $aboutMe \n resumes ::: $resumes');

      PortfolioDataModel portfolioDataModel = PortfolioDataModel.fromMap(
          aboutMeList: aboutMe,
          projectsList: projects,
          technologiesList: technologies,
          resumesList: resumes);
      return portfolioDataModel;
    } catch (e) {
      AppLogger.e('Function getPortfolioData() error: $e');
      return null;
    }
  }
}
