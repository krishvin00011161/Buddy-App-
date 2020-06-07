import 'package:buddyappfirebase/home/widgets/custom_app_bar.dart';
import 'package:buddyappfirebase/home/widgets/custom_drawers.dart';
import 'package:flutter/material.dart';

class RequestsView extends StatefulWidget {
  RequestsView({Key key}) : super(key: key);

  @override
  _RequestsViewState createState() => _RequestsViewState();
}

class _RequestsViewState extends State<RequestsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawers(),
    );
  }
}