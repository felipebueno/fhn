import 'package:fhn/constants.dart';
import 'package:fhn/pages/home.dart';
import 'package:fhn/hn_router.dart';
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
        customDarkTheme(),
        draculaTheme(),
      ],
      child: ThemeConsumer(
        child: Builder(
          builder: (themeContext) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Hacker News',
            darkTheme: draculaTheme().data,
            theme: draculaTheme().data,
            initialRoute: Home.id,
            routes: HNRouter.routes,
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

AppTheme customDarkTheme() {
  return AppTheme(
    id: 'custom_dark_theme',
    description: 'Hacker News dark theme',
    data: ThemeData.dark().copyWith(
      accentColor: kHNWhite,
      buttonColor: kHNWhite,
      tabBarTheme: TabBarTheme(
        indicator: ShapeDecoration(
          shape: UnderlineInputBorder(
            borderSide: BorderSide(
              color: kHNWhite,
              width: 4,
              style: BorderStyle.solid,
            ),
          ),
        ),
      ),
    ),
  );
}

AppTheme draculaTheme() {
  return AppTheme(
    id: 'dracula_theme',
    description: 'Hacker News dracula theme',
    data: ThemeData.light().copyWith(
      brightness: Brightness.light,
      primaryColor: Color(0xff44475a),
      accentColor: Color(0xffbd93f9),
      backgroundColor: Color(0xff282a36),
      scaffoldBackgroundColor: Color(0xff44475a),
      buttonColor: Color(0xffbd93f9),
      textTheme: TextTheme(
        headline5: TextStyle(color: Color(0xffbd93f9)),
        subtitle1: TextStyle(color: Color(0xfff8f8f2), fontSize: 16),
        subtitle2: TextStyle(color: Color(0xfff8f8f2)),
      ),
      dividerColor: Color(0xffbd93f9),
      iconTheme: IconThemeData(color: Color(0xff6272a4)),
      tabBarTheme: TabBarTheme(
        indicator: ShapeDecoration(
          shape: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffff79c6),
              width: 4,
              style: BorderStyle.solid,
            ),
          ),
        ),
        labelColor: Color(0xffbd93f9),
        unselectedLabelColor: kHNGrey,
      ),
    ),
  );
}
