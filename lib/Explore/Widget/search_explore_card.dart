import 'package:buddyappfirebase/Explore/theme/constant.dart';
import 'package:flutter/material.dart';

class ExploreCard extends StatelessWidget {
  final String imgScr;
  final String title;
  const ExploreCard({
    Key key,
    this.imgScr,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 11, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
            color: textWhite,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 8,
                  offset: Offset(3, 1))
            ]),
        child: Container(
          width: 160,
          child: Column(
            children: <Widget>[
              Image.asset(imgScr),
              Padding(
                padding: EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          height: 1.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
