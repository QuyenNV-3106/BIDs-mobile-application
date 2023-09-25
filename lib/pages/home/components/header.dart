import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/models/UserProfile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({Key? key, required this.size, required this.userProfile})
      : super(key: key);

  final Size size;
  final UserProfile userProfile;

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  void dispose() {
    super.dispose();
  }

  String capitalizeVietnamese(String input) {
    List<String> words = input.split(' ');
    for (int i = 0; i < words.length; i++) {
      String word = words[i];
      if (word.isNotEmpty) {
        String firstChar = word[0].toUpperCase();
        String rest = word.substring(1);
        words[i] = '$firstChar$rest';
      }
    }
    return words.join(' ');
  }

  @override
  Widget build(BuildContext context) {
    String capitalizedString =
        capitalizeVietnamese(widget.userProfile.userName!);
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 64, left: 24, right: 24),
        child: SizedBox(
          height: widget.size.height / 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.userProfile.userName == null
                  ? const CircularProgressIndicator(
                      color: kPrimaryColor,
                    )
                  : Text(
                      "Xin Chào\n$capitalizedString",
                      // "Xin Chào\n${widget.userProfile.userName}",
                      style: GoogleFonts.workSans(
                          textStyle: Theme.of(context).textTheme.headline4,
                          fontSize: (18 / 375.0) * sizeInit(context).width,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: widget.size.height / 24,
                backgroundImage: widget.userProfile.avatar == null
                    ? Image.asset(logo).image
                    : Image.network(
                        "${widget.userProfile.avatar}",
                      ).image,
              )
            ],
          ),
        ),
      ),
    );
  }
}
