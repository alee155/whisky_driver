import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
class text extends StatelessWidget {
  const text({super.key, required this.tex, required this.colorOT, required this.Size});
  final String tex;
  final Color colorOT;
  final double Size;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child:
      Text(tex, style: GoogleFonts.inter(fontWeight: FontWeight.bold,fontSize: Size, color: colorOT),),



    );
  }
}

