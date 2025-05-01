import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:prince_portfolio/app/constants.dart';
import 'package:prince_portfolio/data/portfolio_data_model.dart';
import 'package:prince_portfolio/data/projects_data_model.dart';
import 'package:prince_portfolio/domain/database_services.dart';
import 'package:prince_portfolio/utils/app_logger.dart';

import '../data/about_me_data_model.dart';

class FirebaseService {
  final remoteConfig = FirebaseRemoteConfig.instance;

  ///
  /// Initialize remote config.
  ///
  Future<void> initializeRemoteConfig() async {
    try {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 1),
      ));

      await remoteConfig.fetchAndActivate();
    } catch (e) {
      AppLogger.e("Error initializing remote config: $e");
    }
  }
}
