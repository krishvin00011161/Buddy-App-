import 'package:buddyappfirebase/home/widgets/custom_app_bar.dart';
import 'package:buddyappfirebase/home/widgets/custom_drawers.dart';
import 'package:flutter/material.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawers(),
    );
  }
}
