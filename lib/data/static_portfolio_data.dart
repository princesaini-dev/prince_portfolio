import 'package:prince_portfolio/data/about_me_data_model.dart';
import 'package:prince_portfolio/data/portfolio_data_model.dart';
import 'package:prince_portfolio/data/projects_data_model.dart';
import 'package:prince_portfolio/data/social_media_data_model.dart';
import 'package:prince_portfolio/data/technology_data_model.dart';

/// Static portfolio data - replaces Supabase database
class StaticPortfolioData {
  StaticPortfolioData._();

  /// Get the complete portfolio data model
  static PortfolioDataModel getPortfolioData() {
    return PortfolioDataModel(
      aboutMeDataModel: _aboutMeData,
      projectsDataModel: _projectsData,
      technologiesDataModel: _technologiesData,
      resumesURL: _resumeUrl,
      socialMediaDataModel: _socialMediaData,
    );
  }

  /// Resume URL
  static const String _resumeUrl =
      'https://yeqvlzlkziaakzhkyrdh.supabase.co/storage/v1/object/sign/resume/prince_saini.pdf?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6InN0b3JhZ2UtdXJsLXNpZ25pbmcta2V5XzYxMWYwMGE4LTQ5MTEtNGJmMC05Y2FjLWQzNGI1ODg4Mzc4ZiJ9.eyJ1cmwiOiJyZXN1bWUvcHJpbmNlX3NhaW5pLnBkZiIsImlhdCI6MTc0NjEwOTE3NiwiZXhwIjoxOTAzNzg5MTc2fQ.hW9Yl0QbXVL-awixZUNrCtyecTKrRv24nQSErkZkHAQ';

  /// About Me Data
  static final AboutMeDataModel _aboutMeData = AboutMeDataModel(
    id: 1,
    createdAt: DateTime.parse('2025-04-30T06:37:30.695761+00:00'),
    fullName: 'Prince Saini',
    introTitle:
        'I am Prince Saini, a Mobile application developer (Flutter developer).',
    description: 'I am a flutter developer',
    objective:
        'Seeking a Flutter Application Developer position to leverage 4+ years of experience in robust, cross-platform mobile applications developement. Proven ability to design, develop, and optimize Flutter applications aligned with business requirements. Eager to contribute to a collaborative team environment and deliver high-quality solutions.',
    title: 'Mobile Application Developer (Flutter Developer)',
    welcomeText: 'Welcome to my portfolio !',
    email: 'princesaini14201@gmail.com',
    location: 'Gurugram, Haryana',
  );

  /// Technologies Data
  static final List<TechnologyDataModel> _technologiesData = [
    TechnologyDataModel(
      id: 1,
      createdAt: DateTime.parse('2025-04-30T06:30:49.597011+00:00'),
      name: 'Flutter',
    ),
    TechnologyDataModel(
      id: 2,
      createdAt: DateTime.parse('2025-04-30T06:31:02.752482+00:00'),
      name: 'Dart',
    ),
    TechnologyDataModel(
      id: 3,
      createdAt: DateTime.parse('2025-04-30T06:31:08.528421+00:00'),
      name: 'Java',
    ),
    TechnologyDataModel(
      id: 4,
      createdAt: DateTime.parse('2025-04-30T06:31:19.784422+00:00'),
      name: 'Kotlin',
    ),
    TechnologyDataModel(
      id: 5,
      createdAt: DateTime.parse('2025-04-30T06:31:29.22216+00:00'),
      name: 'Firebase',
    ),
    TechnologyDataModel(
      id: 6,
      createdAt: DateTime.parse('2025-04-30T06:31:35.884129+00:00'),
      name: 'Git',
    ),
    TechnologyDataModel(
      id: 7,
      createdAt: DateTime.parse('2025-04-30T06:31:44.596981+00:00'),
      name: 'SQL/NoSQL',
    ),
    TechnologyDataModel(
      id: 8,
      createdAt: DateTime.parse('2025-04-30T06:31:58.918313+00:00'),
      name: 'Flutter Flow',
    ),
    TechnologyDataModel(
      id: 9,
      createdAt: DateTime.parse('2025-04-30T06:32:07.93384+00:00'),
      name: 'Android Studio',
    ),
    TechnologyDataModel(
      id: 10,
      createdAt: DateTime.parse('2025-04-30T06:32:22.055148+00:00'),
      name: 'IOS Developement',
    ),
    TechnologyDataModel(
      id: 11,
      createdAt: DateTime.parse('2025-05-02T09:55:03.902676+00:00'),
      name: 'Supabase',
    ),
    TechnologyDataModel(
      id: 12,
      createdAt: DateTime.parse('2025-05-18T16:18:28.962563+00:00'),
      name: 'Python',
    ),
  ];

  /// Projects Data
  static final List<ProjectsDataModel> _projectsData = [
    ProjectsDataModel(
      id: 1,
      index: 1,
      createdAt: DateTime.parse('2025-04-30T06:03:23.749728+00:00'),
      title: 'Platform',
      description:
          'Developed a scalable, dynamic mobile application using Flutter, BLoC architecture, and Clean Architecture principles; integrated ArcGIS maps for advanced geospatial features. Implemented Sqflite for offline storage, Dio for efficient API communication, and Firebase for real-time listeners, cloud data storage, and push notifications.',
      imageUrl:
          'https://yeqvlzlkziaakzhkyrdh.supabase.co/storage/v1/object/sign/images/platform.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6InN0b3JhZ2UtdXJsLXNpZ25pbmcta2V5XzYxMWYwMGE4LTQ5MTEtNGJmMC05Y2FjLWQzNGI1ODg4Mzc4ZiJ9.eyJ1cmwiOiJpbWFnZXMvcGxhdGZvcm0ucG5nIiwiaWF0IjoxNzQ2MTA2NDc2LCJleHAiOjE5MDM3ODY0NzZ9.qn72Qk9ZWFBJ0v6kyOzQ7x_dzHbsKjBW-nKcd7DAtJ4',
      liveUrl: null,
    ),
    ProjectsDataModel(
      id: 3,
      index: 2,
      createdAt: DateTime.parse('2025-04-30T06:38:27.016582+00:00'),
      title: 'Medcura',
      description:
          'Designed and developed a feature-rich social networking app Medcura for iOS and Android both using Flutter. The app enables users to connect through chat, share posts, and experience live streams, leveraging the Amity SDK for a robust foundation. Firebase integration ensures real-time push notifications, contributing to an impressive 94% crash-free user rate.',
      imageUrl:
          'https://yeqvlzlkziaakzhkyrdh.supabase.co/storage/v1/object/sign/images/medcura.webp?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6InN0b3JhZ2UtdXJsLXNpZ25pbmcta2V5XzYxMWYwMGE4LTQ5MTEtNGJmMC05Y2FjLWQzNGI1ODg4Mzc4ZiJ9.eyJ1cmwiOiJpbWFnZXMvbWVkY3VyYS53ZWJwIiwiaWF0IjoxNzQ2MTA2MTAyLCJleHAiOjE5MDM3ODYxMDJ9.PTmE6T1Xf81Gf0cUNd7I3VFAunQAAw-a-Wh1zVKbXhA',
      liveUrl: 'https://apps.apple.com/in/app/medcura/id6465895015',
    ),
    ProjectsDataModel(
      id: 4,
      index: 3,
      createdAt: DateTime.parse('2025-04-30T06:39:01.478924+00:00'),
      title: 'PCl Health',
      description:
          'Developed a Flutter app for iOS and Android that facilitates seamless Bluetooth Low Energy (BLE) connections with smartwatches for real-time vital signs syncing. Utilized Flutter\'s capabilities for building a user-friendly interface and integrated Azure Events for efficient data transmission and secure cloud storage of synchronized health data.',
      imageUrl:
          'https://yeqvlzlkziaakzhkyrdh.supabase.co/storage/v1/object/sign/images/pcl_health.webp?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6InN0b3JhZ2UtdXJsLXNpZ25pbmcta2V5XzYxMWYwMGE4LTQ5MTEtNGJmMC05Y2FjLWQzNGI1ODg4Mzc4ZiJ9.eyJ1cmwiOiJpbWFnZXMvcGNsX2hlYWx0aC53ZWJwIiwiaWF0IjoxNzQ2MTA2MTkwLCJleHAiOjE5MDM3ODYxOTB9.DI4OwJPNreviLfx5poiQCVzPw6jfR7idMXdxX53N_XI',
      liveUrl:
          'https://play.google.com/store/search?q=pcl%20health&c=apps&hl=en-IN',
    ),
    ProjectsDataModel(
      id: 5,
      index: 4,
      createdAt: DateTime.parse('2025-04-30T06:39:35.718423+00:00'),
      title: 'PM Wani',
      description:
          'Developed PM Wani, a secure Flutter app, that connects to routers using RSA encryption to protect tokens for internet service provision. Implemented a system for managing a local list of routers with automatic daily refresh, utilizing user location for visualization through Google Maps integration. Additionally, incorporated Razor Pay for seamless and secure in-app payment transactions.',
      imageUrl:
          'https://yeqvlzlkziaakzhkyrdh.supabase.co/storage/v1/object/sign/images/pm_wani.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6InN0b3JhZ2UtdXJsLXNpZ25pbmcta2V5XzYxMWYwMGE4LTQ5MTEtNGJmMC05Y2FjLWQzNGI1ODg4Mzc4ZiJ9.eyJ1cmwiOiJpbWFnZXMvcG1fd2FuaS5wbmciLCJpYXQiOjE3NDYxMDYyMTUsImV4cCI6MTkwMzc4NjIxNX0.m-RgqAbgpW_oYyFzcZncXf_995ZAZt_GQvq7SDN674U',
      liveUrl: null,
    ),
    ProjectsDataModel(
      id: 6,
      index: 5,
      createdAt: DateTime.parse('2025-04-30T06:39:49.553043+00:00'),
      title: 'Smart Pro',
      description:
          'Developed an Android app using Kotlin that manages simultaneous Bluetooth Low Energy (BLE) connections with up to five testing devices, optimizing real-time data exchange. Implemented Canvas for dynamic certificate design based on test results, allowing users to download and share personalized certificates directly from the app, enhancing user experience.',
      imageUrl:
          'https://yeqvlzlkziaakzhkyrdh.supabase.co/storage/v1/object/sign/images/smart_pro.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6InN0b3JhZ2UtdXJsLXNpZ25pbmcta2V5XzYxMWYwMGE4LTQ5MTEtNGJmMC05Y2FjLWQzNGI1ODg4Mzc4ZiJ9.eyJ1cmwiOiJpbWFnZXMvc21hcnRfcHJvLnBuZyIsImlhdCI6MTc0NjEwNjI0NywiZXhwIjoxOTAzNzg2MjQ3fQ.D9R-VigfNa2dWWuWEg1z91jHO2A_XPA7BqGRdmXQMdk',
      liveUrl: null,
    ),
    ProjectsDataModel(
      id: 7,
      index: 6,
      createdAt: DateTime.parse('2025-04-30T06:40:15.346068+00:00'),
      title: 'AmarPriyo Business',
      description:
          'Developed an Android app for a business listing platform, enabling users to easily discover and book services from local businesses. Utilized location services for a seamless user experience.',
      imageUrl:
          'https://yeqvlzlkziaakzhkyrdh.supabase.co/storage/v1/object/sign/images/amar_priyo.jpeg?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6InN0b3JhZ2UtdXJsLXNpZ25pbmcta2V5XzYxMWYwMGE4LTQ5MTEtNGJmMC05Y2FjLWQzNGI1ODg4Mzc4ZiJ9.eyJ1cmwiOiJpbWFnZXMvYW1hcl9wcml5by5qcGVnIiwiaWF0IjoxNzQ2MTA2MTY1LCJleHAiOjE5MDM3ODYxNjV9.TxlqmrrEr1KlmRTw6zk1TqeomMAp8jfW0elfZcxIwms',
      liveUrl: null,
    ),
  ];

  /// Social Media Data
  static final List<SocialMediaDataModel> _socialMediaData = [
    SocialMediaDataModel(
      imageUrl:
          'https://yeqvlzlkziaakzhkyrdh.supabase.co/storage/v1/object/sign/images/linkedin.png?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV8wYTUxYjE4Ny02ZmNmLTQyZWItYjNiNC1jM2FiMGE4OTQwMjEiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJpbWFnZXMvbGlua2VkaW4ucG5nIiwiaWF0IjoxNzUzNTUxMDE4LCJleHAiOjE3ODUwODcwMTh9.pFH7alTU7Ewgq0p5IHiHwKEhzHPNFHB4rVAFdgzs6O0',
      name: 'LinkedIn',
      link: 'https://www.linkedin.com/in/prince-dev',
    ),
    SocialMediaDataModel(
      imageUrl:
          'https://yeqvlzlkziaakzhkyrdh.supabase.co/storage/v1/object/sign/images/github.png?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV8wYTUxYjE4Ny02ZmNmLTQyZWItYjNiNC1jM2FiMGE4OTQwMjEiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJpbWFnZXMvZ2l0aHViLnBuZyIsImlhdCI6MTc1MzU1MDk0NSwiZXhwIjoxODE2NjIyOTQ1fQ.VWHgxk4_c7Vo438Vf88JZDaiZTmFaipmqgtmDjDBIxc',
      name: 'Github',
      link: 'https://github.com/princesaini-dev',
    ),
  ];
}
