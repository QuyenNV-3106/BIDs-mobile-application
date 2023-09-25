import 'package:bid_online_app_v2/constants.dart';
import 'package:flutter/material.dart';

class TopRoundedContainer extends StatefulWidget {
  const TopRoundedContainer({
    Key? key,
    required this.color,
    required this.child,
  }) : super(key: key);

  final Color color;
  final Widget child;

  @override
  State<TopRoundedContainer> createState() => _TopRoundedContainerState();
}

class _TopRoundedContainerState extends State<TopRoundedContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: (20 / 375.0) * sizeInit(context).width),
      padding: EdgeInsets.only(top: (20 / 375.0) * sizeInit(context).width),
      width: double.infinity,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: widget.child,
    );
  }
}
