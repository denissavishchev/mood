import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../widgets/flag_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('language'.tr(),),
            GestureDetector(
                onTap: () => context.setLocale(const Locale('en', 'US')),
                child: const FlagWidget(country: 'GB')),
            GestureDetector(
                onTap:  () => context.setLocale(const Locale('pl', 'PL')),
                child: const FlagWidget(country: 'PL')),
            GestureDetector(
                onTap: () => context.setLocale(const Locale('ru', 'RU')),
                child: const FlagWidget(country: 'RU')),
          ],
        ),
      ),
    );
  }
}
