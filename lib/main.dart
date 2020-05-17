import 'package:fhn/constants.dart';
import 'package:fhn/pages/home.dart';
import 'package:fhn/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:theme_provider/theme_provider.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      saveThemesOnChange: true,
      loadThemeOnInit: true,
      themes: <AppTheme>[
        hnAppTheme(),
        AppTheme.dark(),
      ],
      child: ThemeConsumer(
        child: Builder(
          builder: (themeContext) => MaterialApp(
            title: 'fHN',
            theme: Theme.of(themeContext),
            initialRoute: Home.id,
            routes: Router.routes,
            home: Home(),
          ),
        ),
      ),
    );
  }
}

AppTheme hnAppTheme() {
  return AppTheme(
    id: 'hn_theme',
    description: 'Hacker News color theme',
    data: ThemeData.light().copyWith(
      brightness: Brightness.light,
      primaryColor: kHNOrange,
      accentColor: kHNOrange,
      backgroundColor: kHNBGColor,
      scaffoldBackgroundColor: kHNBGColor,
      buttonColor: kHNOrange,
      primaryColorLight: kHNOrange,
      textTheme: TextTheme(
        subtitle1: TextStyle(color: kHNBlack, fontSize: 16),
        subtitle2: TextStyle(color: kHNGrey),
      ),
      tabBarTheme: TabBarTheme(
        indicator: ShapeDecoration(
          shape: UnderlineInputBorder(
            borderSide: BorderSide(
              color: kHNOrange,
              width: 4,
              style: BorderStyle.solid,
            ),
          ),
        ),
        labelColor: kHNOrange,
        unselectedLabelColor: kHNGrey,
      ),
    ),
  );
}
