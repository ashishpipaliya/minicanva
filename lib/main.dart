import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotesmaker/provider/drawer_provider.dart';
import 'package:quotesmaker/provider/file_management_provider.dart';
import 'package:quotesmaker/layout/quote.dart';
import 'package:quotesmaker/provider/m_themes.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
  setPathUrlStrategy();
  await Firebase.initializeApp(
      options:const FirebaseOptions(
        apiKey: "AIzaSyCf9x1qV39dZXsyeFwm535-QO5OGJqB4CI",
        appId: "1:1006082383544:web:eacbd899dd63d565fede4d",
        messagingSenderId: "1006082383544",
        projectId: "mini-canva",
      )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => DrawerProvider()),
          ChangeNotifierProvider(create: (context) => FileManagementProvider()),
          ChangeNotifierProvider(create: (context) => MthemesProvider()),
        ],
        builder: (context, child) {
          final _themeProvider = Provider.of<MthemesProvider>(context);
          return MaterialApp(
              title: 'Mini Canva',
              debugShowCheckedModeBanner: false,
              theme: _themeProvider.blueThemeLight,
              darkTheme: _themeProvider.blueThemeDark,
              themeMode: _themeProvider.themeMode,
              home: const QuotePage());
        });
  }
}

// f2.10 build web --web-renderer canvaskit --release
