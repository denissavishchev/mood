import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const kOrange = Color(0xffec4611);
const kBlue = Color(0xff0033c3);
const kBlueGrey = Color(0xff689ed0);
const kPinkGrey = Color(0xfff2dfe5);
const kBlack = Color(0xff010f19);
const kWhite = Color(0xfffefffd);

final kTextStyle = TextStyle(
  color: kWhite,
  fontWeight: FontWeight.bold,
  fontSize: 24.sp,
  // fontFamily: 'Roboto'
);

final kBigTextStyle = TextStyle(
  color: kWhite,
  fontWeight: FontWeight.bold,
  fontSize: 32.sp,
  // fontFamily: 'Roboto'
);

final kBigOrangeTextStyle = TextStyle(
  color: kOrange,
  fontWeight: FontWeight.bold,
  fontSize: 32.sp,
  // fontFamily: 'Roboto'
);

final textFieldDecoration = InputDecoration(
  hintStyle: kTextStyle,
  enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: kWhite)
  ),
  focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: kWhite)
  ),
  focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: kOrange)
  ),
  errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: kOrange)
  ),
);