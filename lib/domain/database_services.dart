import 'package:prince_portfolio/supabase_client.dart';
import 'package:prince_portfolio/utils/app_logger.dart';

class DatabaseServices {
  Future<void> getProjectList() async {
    final technologies =
        await SupabaseClient.instance.from('technologies').select();
    final projects = await SupabaseClient.instance.from('projects').select();
    final aboutMe = await SupabaseClient.instance.from('about_me').select();

    AppLogger.i(
        'technologies ::: $technologies \n projects ::: $projects \n aboutMe ::: $aboutMe');
  }
}
