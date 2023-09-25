import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/enums.dart';
import 'package:bid_online_app_v2/pages/home/home_page.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    // final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide.none,
          right: BorderSide.none,
          left: BorderSide.none,
          top: BorderSide(
            color: Colors.grey.withOpacity(0.7),
          ),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(
                  MenuState.home == selectedMenu
                      ? Icons.home
                      : Icons.home_outlined,
                  color: MenuState.home == selectedMenu
                      ? kPrimaryColor
                      : Colors.grey,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, HomePage.routeName),
              ),
              IconButton(
                icon: const Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.grey,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.add_box_outlined,
                  color: Colors.grey,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.person_outline,
                  color: Colors.grey,
                ),
                onPressed: () {},
              ),
            ],
          )),
    );
  }
}
