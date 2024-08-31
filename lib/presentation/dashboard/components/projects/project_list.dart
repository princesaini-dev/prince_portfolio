import 'package:prince_portfolio/presentation/resources/image_manager.dart';

class ProjectList {
  static const List<ProjectItem> projectList = [
    ProjectItem(
        title: 'Medcura',
        description:
            'Designed and developed a feature-rich social networking app Medcura for iOS and Android both using Flutter. The app enables users to connect through chat, share posts, and experience live streams, leveraging the Amity SDK for a robust foundation. Firebase integration ensures real-time push notifications, contributing to an impressive 94% crash- free user rate.',
        image: ImageManager.imageMedcura,
        url: 'https://apps.apple.com/in/app/medcura/id6465895015'),
    ProjectItem(
        title: 'PCl Health',
        description:
            "Developed a Flutter app for iOS and Android that facilitates seamless Bluetooth Low Energy (BLE) connections with smartwatches for real-time vital signs syncing. Utilized Flutter's capabilities for building a user-friendly interface and integrated Azure Events for efficient data transmission and secure cloud storage of synchronized health data.",
        image: ImageManager.imagePclHealth,
        url:
            'https://play.google.com/store/search?q=pcl%20health&c=apps&hl=en-IN'),
    ProjectItem(
        title: 'PM Wani',
        description:
            'Developed PM Wani, a secure Flutter app, that connects to routers using RSA encryption to protect tokens for internet service provision. Implemented a system for managing a local list of routers with automatic daily refresh, utilizing user location for visualization through Google Maps integration. Additionally, incorporated Razor Pay for seamless and secure in-app payment transactions.',
        image: ImageManager.imagePmWani,
        url: ''),
    ProjectItem(
        title: 'Smart Pro',
        description:
            'Developed an Android app using Kotlin that manages simultaneous Bluetooth Low Energy (BLE) connections with up to five testing devices, optimizing real-time data exchange. Implemented Canvas for dynamic certificate design based on test results, allowing users to download and share personalized certificates directly from the app, enhancing user experience.',
        image: ImageManager.imageSmartPro,
        url: ''),
    ProjectItem(
        title: 'AmarPriyo Business',
        description:
            'Developed an Android app for a business listing platform, enabling users to easily discover and book services from local businesses. Utilized location services for a seamless user experience.',
        image: ImageManager.imageAmarPriyo,
        url: ''),
  ];
}

class ProjectItem {
  final String image;
  final String url;
  final String title;
  final String description;
  const ProjectItem(
      {required this.title,
      required this.description,
      required this.image,
      required this.url});
}
