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

      AppLogger.i(
          'technologies ::: $technologies \n projects ::: $projects \n aboutMe ::: $aboutMe');

      PortfolioDataModel portfolioDataModel = PortfolioDataModel.fromMap(
          aboutMeList: aboutMe,
          projectsList: projects,
          technologiesList: technologies);
      return portfolioDataModel;
    } catch (e) {
      AppLogger.e('Function getPortfolioData() error: $e');
      return null;
    }
  }
}
