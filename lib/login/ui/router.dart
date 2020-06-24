import 'package:buddyappfirebase/Explore/explore.dart';
import 'package:buddyappfirebase/login/ui/views/start_view.dart';
import 'package:buddyappfirebase/welcome/setup_class.dart';
import 'package:buddyappfirebase/welcome/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:buddyappfirebase/login/constants/route_names.dart';
import 'package:buddyappfirebase/login/ui/views/login_view.dart';
import 'package:buddyappfirebase/login/ui/views/signup_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  // Generating routes it is used by navigation service
  switch (settings.name) {
    case LoginViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: LoginView(),
      );
    case SignUpViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SignUpView(),
      );
    case WelcomeViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: WelcomeView(),
      );
    case StartViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: StartView(),
      );
      case SetUpViewRoute:
        return _getPageRoute(
          routeName: settings.name,
          viewToShow: Setup(),
        );
      case ExploreViewRoute:
        return _getPageRoute(
          routeName: settings.name,
          viewToShow: ExplorePage(),
        );
    
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}

PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}
