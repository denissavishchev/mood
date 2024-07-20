import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const kOrange = Color(0xfffc210d);
const kNavy = Color(0xff7dd5da);
const kBlue = Color(0xff4d89c7);
const kRed = Color(0xffff7582);
const kGrey = Color(0xffdcdcdc);
const kYellow = Color(0xfff7ce38);
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
  fontSize: 30.sp,
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
      borderSide: BorderSide(color: kRed)
  ),
  errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: kRed)
  ),
);