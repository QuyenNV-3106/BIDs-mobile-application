import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/models/Category.dart';
import 'package:bid_online_app_v2/pages/home/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryBar extends StatefulWidget {
  static String? categoryString;

  const CategoryBar({
    Key? key,
    required this.size,
    required this.category,
  }) : super(key: key);

  final Size size;
  final List<CategoryProduct> category;

  @override
  State<CategoryBar> createState() => _CategoryBarState();
}

class _CategoryBarState extends State<CategoryBar> {
  int selectedIndex = 0;
  @override
  void initState() {
    widget.category.insert(0,
        CategoryProduct(categoryId: "1", categoryName: "Tất cả", status: true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          height: widget.size.height / 15,
          child: widget.category.isEmpty
              ? const CircularProgressIndicator(
                  color: kPrimaryColor,
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.category.length,
                  itemBuilder: ((context, index) {
                    if (!widget.category
                        .any((element) => element.categoryName == "Tất cả")) {
                      widget.category.insert(
                          0,
                          CategoryProduct(
                              categoryId: "1",
                              categoryName: "Tất cả",
                              status: true));
                    }
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          CategoryBar.categoryString =
                              widget.category[index].categoryName;
                        });
                      },
                      child: Container(
                        width: widget.size.width / 3,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(left: 16),
                        decoration: selectedIndex == index
                            ? BoxDecoration(
                                color: Colors.deepOrange,
                                borderRadius: BorderRadius.circular(12))
                            : BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.deepOrange)),
                        child: selectedIndex == index
                            ? Text(
                                widget.category[index].categoryName,
                                style: GoogleFonts.workSans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              )
                            : Text(
                                widget.category[index].categoryName,
                                style: GoogleFonts.workSans(
                                    fontSize: 15,
                                    // fontWeight: FontWeight.w600,
                                    color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                      ),
                    );
                  }),
                ),
        ),
        SizedBox(
          height: (20 / 812.0) * sizeInit(context).height,
          child: Container(color: Colors.white),
        ),
        Container(
          color: Colors.white,
          height: (50 / 812.0) * sizeInit(context).height,
          child: Row(
            children: [
              const Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
              Text(
                CategoryBar.categoryString == null || selectedIndex == 0
                    ? "Danh sách các phiên"
                    : "Danh sách ${CategoryBar.categoryString}",
                style: GoogleFonts.workSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
