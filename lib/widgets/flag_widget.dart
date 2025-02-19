import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

class FlagWidget extends StatelessWidget {
  const FlagWidget({
    super.key, required this.country,
  });

  final String country;

  @override
  Widget build(BuildContext context) {
    return CountryFlag.fromCountryCode(
      country,
      height: 36,
      width: 46,
      shape: const RoundedRectangle(8)
    );
  }
}