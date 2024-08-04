import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const kWhite = Color(0xfffefffd);
const kBlack = Color(0xff010f19);
const kNavy = Color(0xff7dd5da);
const kBlueGrey = Color(0xff4d89c7);
const kDarkBlue = Color(0xff2800ff);
const kOcean = Color(0xff08f1d9);
const kSalad = Color(0xff7cff6b);
const kGreen = Color(0xff0a8270);
const kLightGreen = Color(0xff18c729);
const kLightYellow = Color(0xfffef500);
const kYellow = Color(0xfff7ce38);
const kOrange = Color(0xfffc210d);
const kRed = Color(0xffff7582);
const kGrey = Color(0xffdcdcdc);



final kTextStyle = TextStyle(
  color: kWhite,
  fontWeight: FontWeight.bold,
  fontSize: 24.sp,
  // fontFamily: 'Roboto'
);

final kBlackTextStyle = TextStyle(
  color: kBlack,
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