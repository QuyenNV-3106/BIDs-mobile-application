import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/models/Session.dart';
import 'package:bid_online_app_v2/models/SessionHaveNotPay.dart';
import 'package:flutter/material.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({super.key, required this.session});
  final SessionHaveNotPay session;

  @override
  State<ProductImages> createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: (250 / 375.0) * sizeInit(context).width,
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag:
                  widget.session.sessionResponseCompletes!.sessionId.toString(),
              child: widget.session.sessionResponseCompletes!.images!.isEmpty
                  ? Image.asset(noImage)
                  : Image.network(
                      widget.session.sessionResponseCompletes!
                          .images![selectedImage].detail!,
                      fit: BoxFit.fitWidth,
                      loadingBuilder: (context, child, loadingProgress) =>
                          loadingProgress == null
                              ? child
                              : Image.asset(noImage),
                      errorBuilder: (context, error, stackTrace) =>
                          Image.asset(noImage),
                    ),
            ),
          ),
        ),
        SizedBox(height: (15 / 375.0) * sizeInit(context).width),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                  widget.session.sessionResponseCompletes!.images!.length,
                  (index) => buildSmallProductPreview(index)),
            ],
          ),
        )
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
          print("object: $index");
        });
      },
      child: AnimatedContainer(
        duration: const Duration(seconds: 0),
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.all(8),
        height: (50 / 375.0) * sizeInit(context).width,
        width: (50 / 375.0) * sizeInit(context).width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: Image.network(
          widget.session.sessionResponseCompletes!.images![index].detail!,
          loadingBuilder: (context, child, loadingProgress) =>
              loadingProgress == null ? child : Image.asset(noImage),
          errorBuilder: (context, error, stackTrace) => Image.asset(noImage),
        ),
      ),
    );
  }
}
