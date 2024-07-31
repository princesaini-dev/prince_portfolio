import 'package:flutter/material.dart';
import 'package:prince_portfolio/presentation/dashboard/header/dashboard_header.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      appBar: DashboardHeader(),
    ));
  }
}
