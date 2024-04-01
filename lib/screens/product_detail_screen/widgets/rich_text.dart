import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildDetailRichText(String key, String value) {
  return RichText(
    text: TextSpan(
      style: GoogleFonts.poppins().copyWith(
      ),
      children: <TextSpan>[
        TextSpan(text: '$key:  ', style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15.sp,color: Colors.black)),
        TextSpan(text: value,style: TextStyle(fontSize: 15.sp,color: Colors.black)),
      ],
    ),
  );
}
