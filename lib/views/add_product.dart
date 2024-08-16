import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modern_app_flutter/core/design/app_button.dart';
import 'package:modern_app_flutter/core/design/app_image.dart';
import 'package:modern_app_flutter/core/design/app_input.dart';
import 'package:modern_app_flutter/core/logic/helper_methods.dart';

class AddProductView extends StatefulWidget {
  final bool isAdd;

  const AddProductView({super.key, this.isAdd = true});

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  String? selectedImage;
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final buyPriceController = TextEditingController();
  final sellPriceController = TextEditingController();
  bool isLoading =false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isAdd ? "Add Product" : "Edit Product"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Choose Image Source",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w700),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () async{
                                  final image = await ImagePicker().pickImage(
                                    source: ImageSource.camera,
                                  );
                                  Navigator.pop(context);

                                  if (image != null) {
                                    selectedImage = image.path;
                                    setState(() {});
                                  }
                                },
                                icon: Icon(
                                  Icons.camera_alt,
                                  size: 100,
                                ),
                              ),
                              SizedBox(
                                width: 24,
                              ),
                              IconButton(
                                onPressed: () async {
                                  final image = await ImagePicker().pickImage(
                                    source: ImageSource.gallery,
                                  );
                                  Navigator.pop(context);

                                  if (image != null) {
                                    selectedImage = image.path;
                                    setState(() {});
                                  }
                                  print("*****************");
                                  print(image?.path);
                                },
                                icon: Icon(
                                  Icons.image,
                                  size: 100,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    ClipOval(
                      child: AppImage(
                        selectedImage != null ? selectedImage! : "pick_image.svg",
                        height: 153,
                        width: 153,
                        isClickable: true,
                      ),
                    ),
                    CircleAvatar(
                      child: AppImage("add.svg"),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            AppInput(text: "Name",controller: nameController,),
            AppInput(text: "Description",controller: descController,),
            AppInput(text: "Buy Price",controller: buyPriceController,),
            AppInput(text: "Sell Price",controller: sellPriceController,),
            AppButton(
              isLoading: isLoading,
              text: widget.isAdd ? "Add Product" : "Edit Product",
              onPressed: () async{
                isLoading= true;
                setState(() {

                });
                if(widget.isAdd)
                  {
                    await FirebaseDatabase.instance.ref().child("products").push().set({
                      "name":nameController.text,
                      "desc":descController.text,
                      "buyPrice":double.tryParse(buyPriceController.text)??0,
                      "sellPrice":double.tryParse(sellPriceController.text)??0
                    });
                    showMessage("Saved Success",isSuccess: true);
                  }

                isLoading= false;
                setState(() {

                });

              },
            )
          ],
        ),
      ),
    );
  }
}
