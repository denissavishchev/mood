import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mood/constants.dart';
import 'package:mood/providers/meal_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/button_widget.dart';
import '../widgets/flag_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  void initState() {
    final meal = Provider.of<MealProvider>(context, listen: false);
    meal.loadSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGrey,
      body: Consumer<MealProvider>(
        builder: (context, data, _){
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                const SizedBox(height: 40,),
                Row(
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
                const SizedBox(height: 20,),
                TextField(
                  controller: data.maxCaloriesController,
                  cursorColor: kWhite,
                  decoration: textFieldDecoration.copyWith(
                      label: const Text('calories', style: TextStyle(color: kWhite),)),
                ),
                const SizedBox(height: 20,),
                TextField(
                  controller: data.maxWaterController,
                  cursorColor: kWhite,
                  decoration: textFieldDecoration.copyWith(
                      label: const Text('water', style: TextStyle(color: kWhite),)),
                ),
                const Spacer(),
                ButtonWidget(
                  icon: Icons.save,
                  onTap: () => data.saveSettings(),
                ),
                const SizedBox(height: 20,),
              ],
            ),
          );
        },
      )
    );
  }
}
