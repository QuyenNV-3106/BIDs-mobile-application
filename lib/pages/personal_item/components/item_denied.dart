import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/helper.dart';
import 'package:bid_online_app_v2/models/UserProfile.dart';
import 'package:bid_online_app_v2/pages/personal_item/models/BookingItemWaitting.dart';
import 'package:bid_online_app_v2/pages/personal_item/services/personal_item_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemDenied extends StatefulWidget {
  const ItemDenied({super.key});

  @override
  State<ItemDenied> createState() => _ItemDeniedState();
}

class _ItemDeniedState extends State<ItemDenied> {
  List<BookingItemWaitting> bookingItems = [];
  bool loading = false;

  _loadingResource() async {
    setState(() {
      loading = true;
    });
    await PersonalItemService()
        .getItemDenied(UserProfile.user!.userId!)
        .then((value) {
      setState(() {
        bookingItems = value;
      });
    });
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    _loadingResource();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(child: spinkit)
        : bookingItems.isEmpty
            ? const Center(child: Text("Không có sản phẩm"))
            : ListView.builder(
                itemCount: bookingItems.length,
                itemBuilder: (context, index) {
                  return Container(
                      child: InkWell(
                          onTap: () {},
                          child: Card(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: Text(bookingItems[index].itemName),
                                  subtitle: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Giá khởi điểm: ${Helper().formatCurrency(bookingItems[index].firstPrice)} VNĐ',
                                        style: TextStyle(
                                            color: Colors.amber[700],
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Bước giá: ${Helper().formatCurrency(bookingItems[index].firstPrice)} VNĐ',
                                        style: const TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                          'Thể loại: ${bookingItems[index].categoryName}'),
                                      const SizedBox(height: 5),
                                      Text(
                                          "Ngày tạo: ${DateFormat('dd/MM/yyyy HH:mm:ss').format(bookingItems[index].createDate)}"),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )));
                },
              );
  }
}
