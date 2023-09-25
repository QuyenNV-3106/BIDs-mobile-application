import 'package:bid_online_app_v2/components/default_button.dart';
import 'package:bid_online_app_v2/constants.dart';
import 'package:bid_online_app_v2/keyboard.dart';
import 'package:bid_online_app_v2/models/CategoryItem.dart';
import 'package:bid_online_app_v2/models/UserProfile.dart';
import 'package:bid_online_app_v2/pages/form_item/components/build_Name_Form_Field.dart';
import 'package:bid_online_app_v2/pages/form_item/components/build_description_form_field.dart';
import 'package:bid_online_app_v2/pages/form_item/components/build_hour_form_field.dart';
import 'package:bid_online_app_v2/pages/form_item/components/build_minute_form_field.dart';
import 'package:bid_online_app_v2/pages/form_item/components/build_price_form_field.dart';
import 'package:bid_online_app_v2/pages/form_item/components/build_quality_form_field.dart';
import 'package:bid_online_app_v2/pages/form_item/components/build_step_price_form_field.dart';
import 'package:bid_online_app_v2/pages/form_item/services/form_item_services.dart';
import 'package:bid_online_app_v2/pages/login/components/alert_dialog.dart';
import 'package:bid_online_app_v2/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class CreateItemPage extends StatefulWidget {
  static String routeName = "/ceate-item";
  const CreateItemPage({super.key});

  @override
  State<CreateItemPage> createState() => _CreateItemPageState();
}

class _CreateItemPageState extends State<CreateItemPage> {
  final _formkey = GlobalKey<FormState>();
  String selectedValue = 'Trống',
      selectedTypeSession = "Đấu giá sau",
      selectedDeposit = "Có";
  List<String> errors = [];
  List<TextEditingController> controllers = [];
  List<CategoryItem> categories = [];
  List<Asset> selectedImages = [];
  int selectedIndex = 0;
  AlertDialogMessage alert = AlertDialogMessage();

  List<String> items = ['Trống'];
  List<String> itemTypeSession = ['Đấu giá sau', 'Đấu giá ngay'];
  List<String> itemDeposit = ['Có', 'Không'];

  _loadingResource() async {
    await FormItemService().getAllCategories().then((value) {
      setState(() {
        categories = value;
        selectedValue = categories.first.categoryName;
        if (categories.isNotEmpty) {
          items = [];
          for (int i = 0; i < categories.length; i++) {
            for (var element in categories[i].descriptions) {
              controllers.add(TextEditingController());
            }
            items.add(categories[i].categoryName);
          }
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _loadingResource();
  }

  @override
  void dispose() {
    if (categories.isNotEmpty) {
      for (var controller in controllers) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  Widget dropDownTypeSession() {
    return Row(
      children: [
        const Text('Loại phiên đấu giá:',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(width: 15),
        DropdownButton<String>(
          value: selectedTypeSession,
          borderRadius: BorderRadius.circular(10),
          items: itemTypeSession.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedTypeSession = newValue!;
            });
          },
        ),
      ],
    );
  }

  Widget dropDownDeposit() {
    return Row(
      children: [
        const Text('Yêu cầu đặt cọc:',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(width: 15),
        DropdownButton<String>(
          value: selectedDeposit,
          borderRadius: BorderRadius.circular(10),
          items: itemDeposit.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedDeposit = newValue!;
            });
          },
        ),
      ],
    );
  }

  Widget dropDownSelect() {
    return Row(
      children: [
        const Text('Phân loại:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(width: 15),
        DropdownButton<String>(
          value: selectedValue,
          borderRadius: BorderRadius.circular(10),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedValue = newValue!;
              selectedIndex = categories
                  .indexWhere((element) => element.categoryName == newValue);
            });
          },
        ),
      ],
    );
  }

  Widget autoTextField() {
    int itemLenght = categories[selectedIndex].descriptions.length;
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemLenght,
        itemBuilder: (context, index) {
          final description = categories[selectedIndex].descriptions[index];
          return Column(
            children: [
              TextFormField(
                controller: controllers[index],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    setState(() {
                      !errors.contains(description.name)
                          ? errors.add(description.name)
                          : errors.remove(description.name);
                    });
                    return 'Bạn chưa nhập ${description.name.toLowerCase()}';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: description.name,
                  hintText: 'Nhập ${description.name.toLowerCase()}',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  // suffixIcon: const Icon(Icons.person_outline)
                ),
              ),
              SizedBox(height: (30 / 812.0) * sizeInit(context).height),
            ],
          );
        });
  }

  _pressSubmit() async {
    if (selectedImages.isEmpty) {
      alert.showAlertDialog(context, "Thất bại", "Bạn chưa cung cấp hình ảnh");
    } else if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      KeyboardUtil.hideKeyboard(context);

      // await FirebaseService().uploadImageItem(selectedImages., email, itemId)
    }
  }

  _upload() async {
    await FirebaseService()
        .uploadImageItem(selectedImages, UserProfile.user!.email!, '1111');
  }

  _delete() async {
    await FirebaseService()
        .uploadImageItem(selectedImages, UserProfile.user!.email!, '1111');
  }

  Future<void> pickImages() async {
    List<Asset> resultList = [];

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 4, // Số lượng ảnh tối đa có thể chọn
        enableCamera: true, // Cho phép sử dụng camera
        selectedAssets: selectedImages, // Ảnh đã chọn trước đó
        cupertinoOptions: const CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: const MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Chọn ảnh",
          allViewTitle: "Tất cả ảnh",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ), // Tùy chọn cho Android
      );
    } catch (e) {
      // Xử lý lỗi nếu có
      print(e);
    }

    if (!mounted) return;

    setState(() {
      selectedImages = resultList;
    });
    _upload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Thêm sản phẩm'),
        ),
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: (20 / 375.0) * sizeInit(context).width),
              child: Stack(children: [
                SingleChildScrollView(
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        SizedBox(height: sizeInit(context).height * 0.04), // 4%
                        Center(
                          child: Text(
                            "Thêm sản phẩm đấu giá",
                            style: TextStyle(
                              fontSize: (20 / 375.0) * sizeInit(context).width,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: sizeInit(context).height * 0.08),
                        const InputNameItem(),
                        SizedBox(
                            height: (20 / 812.0) * sizeInit(context).height),
                        items.isEmpty ? const SizedBox() : dropDownSelect(),
                        SizedBox(
                            height: (30 / 812.0) * sizeInit(context).height),
                        categories.isEmpty
                            ? const SizedBox(height: 0)
                            : autoTextField(),
                        const InputQualityItem(),
                        SizedBox(
                            height: (30 / 812.0) * sizeInit(context).height),
                        const InputDescriptionItem(),
                        SizedBox(
                            height: (20 / 812.0) * sizeInit(context).height),
                        dropDownTypeSession(),
                        SizedBox(
                            height: (20 / 812.0) * sizeInit(context).height),
                        dropDownDeposit(),
                        SizedBox(
                            height: (20 / 812.0) * sizeInit(context).height),
                        const InputHourItem(),
                        SizedBox(
                            height: (30 / 812.0) * sizeInit(context).height),
                        const InputMinuteItem(),
                        SizedBox(
                            height: (30 / 812.0) * sizeInit(context).height),
                        const InputPriceItem(),
                        SizedBox(
                            height: (30 / 812.0) * sizeInit(context).height),
                        const InputStepPriceItem(),
                        SizedBox(
                            height: (30 / 812.0) * sizeInit(context).height),

                        selectedImages.isEmpty
                            ? const SizedBox(height: 0)
                            : GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                ),
                                itemCount: selectedImages.length,
                                itemBuilder: (context, index) {
                                  Asset asset = selectedImages[index];
                                  return AssetThumb(
                                    asset: asset,
                                    width: 300,
                                    height: 300,
                                  );
                                },
                              ),
                        ElevatedButton(
                          onPressed: pickImages,
                          child: const Text("Chọn ảnh"),
                        ),
                        DefaultButton(
                          text: 'Xác nhận',
                          press: _pressSubmit,
                        ),
                      ],
                    ),
                  ),
                )
              ]),
            ),
          ),
        ));
  }
}
