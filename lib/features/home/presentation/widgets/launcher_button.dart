import 'package:flutter/material.dart';
import 'package:gamehub/shared/extensions/media_query_extension.dart';
import 'package:gamehub/shared/utils/app_icons.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class LauncherButton extends StatelessWidget{
  const LauncherButton({super.key, required this.page, required this.color, required this.name});

  final String page;
  final Color color;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(3.w, 3.h, 0, 0),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, page),
        child: SizedBox(
          width: 16.25.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 16.25.w,
                height: 8.h,
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(12)
                ),
                child: Image.asset(AppIcons.flappy),
              ),
              Gap(0.5.h),
              Text(
                name,
                style: GoogleFonts.poppins(fontSize: 11.sp),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }
}