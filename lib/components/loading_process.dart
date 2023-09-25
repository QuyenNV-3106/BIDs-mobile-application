import 'package:bid_online_app_v2/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget loadingProcess(
    BuildContext context, String state, Color color, bool isHoldScreen) {
  double fullSizeHeight = sizeInit(context).height;
  double fullSizeWidth = sizeInit(context).width;
  double textSize = (15 / 375.0) * fullSizeWidth;
  return Container(
    height: fullSizeHeight,
    width: fullSizeWidth,
    color: color,
    child: Center(
      child: isHoldScreen
          ? holdScreenLoading(fullSizeWidth, state, textSize, color, context)
          : smallScreenLoading(fullSizeWidth, state, textSize, context),
    ),
  );
}

Container smallScreenLoading(
    double fullSizeWidth, String state, double textSize, BuildContext context) {
  return Container(
    // color: color,
    // color: Colors.amber,
    height: fullSizeWidth / 3,
    width: fullSizeWidth / 3,
    decoration: BoxDecoration(
        color: Colors.grey.shade300.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(0.05))),
    child: Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              state,
              style: GoogleFonts.workSans(
                // fontSize: (20 / 375.0) * sizeInit(context).width,
                fontSize: textSize,
                height: 1.5,
                fontWeight: FontWeight.w600,
                color: kPrimaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: (20 / 812.0) * sizeInit(context).height),
            // SizedBox(height: (50 / 812.0) * sizeInit(context).height),
            spinkit
          ],
        ),
      ),
    ),
  );
}

Container holdScreenLoading(double fullSizeWidth, String state, double textSize,
    Color color, BuildContext context) {
  return Container(
    color: color,
    child: Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              state,
              style: GoogleFonts.workSans(
                // fontSize: (20 / 375.0) * sizeInit(context).width,
                fontSize: (18 / 375.0) * fullSizeWidth,
                height: 1.5,
                fontWeight: FontWeight.w600,
                color: kPrimaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            // SizedBox(height: (20 / 812.0) * sizeInit(context).height),
            SizedBox(height: (30 / 812.0) * sizeInit(context).height),
            spinkit
          ],
        ),
      ),
    ),
  );
}
