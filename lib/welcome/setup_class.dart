import 'package:buddyappfirebase/login/locator.dart';
import 'package:buddyappfirebase/login/services/navigation_service.dart';
import 'package:buddyappfirebase/login/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
class Setup extends StatefulWidget {
  @override
  _SetupState createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  final classNameController = TextEditingController();
  final classCodeController = TextEditingController();
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    verticalSpaceLarge,
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      color: Colors.blueAccent,
                      padding: EdgeInsets.fromLTRB(0, 0, 75, 0),
                      onPressed: () {
                        Navigator.pop(context); // Go back
                      },
                    ),
                    verticalSpaceLarge,
                    TextFormField( //Todo  Have to change the outline of textfield to blue
                      decoration: InputDecoration(
                        labelText: 'ClassName',
                        labelStyle: TextStyle(
                          color: Colors.blueAccent,
                        )
                      ),
                      controller: classNameController,
                    ),
                    verticalSpaceSmall,
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Class Code',
                        labelStyle: TextStyle(
                          color: Colors.blueAccent,
                        )
                      ),
                      
                      controller: classCodeController,
                      obscureText: true,
                    ),
                    verticalSpaceMedium,
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                          child: Text(
                            'LOG IN',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          color: Colors.blueAccent,
                          padding: EdgeInsets.fromLTRB(75, 12, 75, 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                          ),
                          onPressed: () async {
                            
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
  }
}