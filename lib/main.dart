import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mood/providers/mood_provider.dart';
import 'package:mood/screens/main_screen.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
      EasyLocalization(
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('pl', 'PL'),
            Locale('ru', 'RU'),],
          path: 'assets/translations',
          fallbackLocale: const Locale('en', 'US'),
          child: MultiProvider(
              providers: [
                ChangeNotifierProvider<MoodProvider>(create: (_) => MoodProvider()),

              ],
              builder: (context, child) {
                return ScreenUtilInit(
                  designSize: const Size(720, 1560),
                  builder: (_, child) => MaterialApp(
                    debugShowCheckedModeBanner: false,
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                    home: const MainScreen(),
                  ),
                );
              }
          )));
}

