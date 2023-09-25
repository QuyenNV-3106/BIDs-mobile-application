import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/models/UserProfile.dart';
import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: Image.network(
              UserProfile.avatarSt!,
              fit: BoxFit.fitWidth,
              loadingBuilder: (context, child, loadingProgress) =>
                  loadingProgress == null ? child : Image.asset(noImage),
              errorBuilder: (context, error, stackTrace) =>
                  Image.asset(noImage),
            ).image,
          ),
        ],
      ),
    );
  }
}
