import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const kGrey = Color(0xffcac8bf);
const kOrange = Color(0xffbb4a0e);
const kBlue = Color(0xff032e41);
const kBlack = Color(0xff010f19);
const kWhite = Color(0xfffefffd);

final kTextStyle = TextStyle(
  color: kGrey,
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

final textFieldDecoration = InputDecoration(
  hintStyle: kTextStyle,
  enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: kGrey)
  ),
  focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: kGrey)
  ),
  focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: kOrange)
  ),
  errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: kOrange)
  ),
);