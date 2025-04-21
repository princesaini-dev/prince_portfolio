import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prince_portfolio/app/constants.dart';
import 'package:prince_portfolio/data/portfolio_data_model.dart';
import 'package:prince_portfolio/data/projects_data_model.dart';
import 'package:prince_portfolio/utils/app_logger.dart';

import '../data/about_me_data_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ///
  /// Fetch portfolio data from Firestore.
  ///
  Future<PortfolioDataModel?> getPortfolioData() async {
    try {
      DocumentSnapshot aboutSnapshot = await _firestore
          .collection(Constants.portfolioFirestoreKey)
          .doc(Constants.aboutFirestoreKey)
          .get();
      DocumentSnapshot projectsSnapshot = await _firestore
          .collection(Constants.portfolioFirestoreKey)
          .doc(Constants.projectsFirestoreKey)
          .get();

      PortfolioDataModel portfolioDataModel = PortfolioDataModel(
          aboutMeDataModel: aboutSnapshot.exists
              ? AboutMeDataModel.fromMap(
                  aboutSnapshot.data() as Map<String, dynamic>)
              : null,
          projectsDataModel: projectsSnapshot.exists
              ? ProjectsDataModel.fromMap(
                  projectsSnapshot.data() as Map<String, dynamic>)
              : null);
      AppLogger.i(
          'Portfolio data fetched successfully.\n ${portfolioDataModel.toJson()}');
      return portfolioDataModel;
    } catch (e) {
      AppLogger.e("Error fetching portfolio data: $e");
    }
    return null;
  }
}
