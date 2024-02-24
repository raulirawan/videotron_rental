import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

const double defaultMargin = 20;
int price = 100000;

Color primaryColor = const Color(0xff211A2C);
Color greyColor = const Color(0xffE9E9E9);
Color alertColor = const Color(0xffD9435E);
Color successColor = const Color.fromARGB(193, 0, 255, 17);
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

convertDate(String? date) {
    // Intl.defaultLocale = 'id';
    DateTime dateTimeWithTimeZone = DateTime.parse(date!);
    String formattedDate =
        DateFormat('d MMMM, yyyy').format(dateTimeWithTimeZone);

    var day = DateFormat('EEEE').format(dateTimeWithTimeZone);
    var hari = "";
    switch (day) {
      case 'Sunday':
        {
          hari = "Minggu";
        }
        break;
      case 'Monday':
        {
          hari = "Senin";
        }
        break;
      case 'Tuesday':
        {
          hari = "Selasa";
        }
        break;
      case 'Wednesday':
        {
          hari = "Rabu";
        }
        break;
      case 'Thursday':
        {
          hari = "Kamis";
        }
        break;
      case 'Friday':
        {
          hari = "Jumat";
        }
        break;
      case 'Saturday':
        {
          hari = "Sabtu";
        }
        break;
    }
    return '$hari, $formattedDate';
  }