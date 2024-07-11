import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const kGrey = Color(0xffb5cacd);
const kLightGrey = Color(0xfff1faf2);
const kOrange = Color(0xffff9944);
const kBlack = Color(0xff010f19);
const kWhite = Color(0xfffefffd);

final kTextStyle = TextStyle(
  color: kGrey,
  fontWeight: FontWeight.bold,
  fontSize: 24.sp,
  // fontFamily: 'Roboto'
);

final kBigTextStyle = TextStyle(
  color: kBlack,
  fontWeight: FontWeight.bold,
  fontSize: 32.sp,
  // fontFamily: 'Roboto'
);

final textFieldDecoration = InputDecoration(
  hintStyle: kTextStyle,
  enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: kLightGrey)
  ),
  focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: kLightGrey)
  ),
  focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: kOrange)
  ),
  errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: kOrange)
  ),
);