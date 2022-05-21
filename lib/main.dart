import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quotesmaker/provider/drawer_provider.dart';
import 'package:quotesmaker/provider/file_management_provider.dart';
import 'package:quotesmaker/quote.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
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
      ],
      builder: (context, child) {
        final _drawerProvider = Provider.of<DrawerProvider>(context);
        return MaterialApp(
            title: 'Quotes Generator',
            debugShowCheckedModeBanner: false,
            theme: FlexThemeData.light(
              scheme: FlexScheme.green,
              surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
              blendLevel: 20,
              appBarOpacity: 0.95,
              subThemesData: const FlexSubThemesData(
                blendOnLevel: 20,
                blendOnColors: false,
                navigationRailElevation: 2.0,
                navigationRailLabelType: NavigationRailLabelType.none,
              ),
              visualDensity: FlexColorScheme.comfortablePlatformDensity,
              useMaterial3: true,
              fontFamily: GoogleFonts.notoSans().fontFamily,
            ),
            darkTheme: FlexThemeData.dark(
              scheme: FlexScheme.green,
              surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
              blendLevel: 15,
              appBarStyle: FlexAppBarStyle.background,
              appBarOpacity: 0.90,
              subThemesData: const FlexSubThemesData(
                blendOnLevel: 30,
                navigationRailElevation: 2.0,
                navigationRailLabelType: NavigationRailLabelType.none,
              ),
              visualDensity: FlexColorScheme.comfortablePlatformDensity,
              useMaterial3: true,
              fontFamily: GoogleFonts.notoSans().fontFamily,
            ),

            themeMode:_drawerProvider.themeMode,
            home:const QuotePage());
      }
    );
  }
}
