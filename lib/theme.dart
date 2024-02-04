import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const double defaultMargin = 20;

Color primaryColor = const Color(0xff211A2C);
Color greyColor = const Color(0xffE9E9E9);
Color alertColor = const Color(0xffD9435E);
Color whiteColor = const Color(0xffFFFFFF);
Color yellowColor = const Color(0xffFDC300);
Color blackColor = const Color(0xff000000);


TextStyle primaryTextStyle = GoogleFonts.mulish(
  color: primaryColor,
);

TextStyle subtitleTextStyle = GoogleFonts.mulish(
  color: const Color(0xff3F414E),
);

TextStyle blackTextStyle = GoogleFonts.mulish(
  color: blackColor,
);
TextStyle whiteTextStyle = GoogleFonts.mulish(
  color: whiteColor,
);

TextStyle redTextStyle = GoogleFonts.mulish(
  color: alertColor,
);

TextStyle alertTextStyle = GoogleFonts.mulish(
  color: alertColor,
);

TextStyle yellowTextStyle = GoogleFonts.mulish(
  color: yellowColor,
);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;