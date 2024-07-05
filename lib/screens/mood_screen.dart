import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MoodScreen extends StatelessWidget {
  const MoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: ()=> context.setLocale(const Locale('ru', 'RU')),
            child: Text('wish'.tr())),
      ),
    );
  }
}
