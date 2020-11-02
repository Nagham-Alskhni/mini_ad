import 'package:flutter/material.dart';
import 'package:miniad/moudels/Products.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:miniad/classes/menueDropStrings.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:miniad/classes/categoryDropString.dart';

class CreatProduct extends StatefulWidget {
  @override
  _CreatProductState createState() => _CreatProductState();
}

class _CreatProductState extends State<CreatProduct> {
  bool isLoading = false;

  TextEditingController _priceController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descController = TextEditingController();

  CategoryDropString categoryDropString;
  List<CategoryDropString> _categorydownItems = [
    CategoryDropString(1, "Apartment"),
    CategoryDropString(2, "Books"),
    CategoryDropString(3, "Computers and Laptop"),
    CategoryDropString(4, "Cars"),
    CategoryDropString(5, "Clothes"),
    CategoryDropString(6, "Medicines"),
    CategoryDropString(7, "Others"),
  ];
  List<DropdownMenuItem<CategoryDropString>> _categorydownMenuItems;
  CategoryDropString _selectedCategory;

  List<DropdownMenuItem<CategoryDropString>> buildCategoryDropDownMenuItems(
      List<CategoryDropString> dropdownItems) {
    List<DropdownMenuItem<CategoryDropString>> items = List();
    for (CategoryDropString manual in _categorydownItems) {
      items.add(
        DropdownMenuItem(
          child: Text(manual.name),
          value: manual,
        ),
      );
    }
    return items;
  }

  ManualDropString manualDropString;
  List<ManualDropString> _dropdownItems = [
    ManualDropString(1, "Exchange"),
    ManualDropString(2, "Donate"),
    ManualDropString(3, "Sell"),
    ManualDropString(4, "Rent"),
  ];

  List<DropdownMenuItem<ManualDropString>> _dropdownMenuItems;
  ManualDropString _selectedItem;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> addProduct(Products product) async {
    CollectionReference products =
        FirebaseFirestore.instance.collection('Products');
    String uId = firebaseAuth.currentUser.uid.toString();

    product.uId = uId;
    // print('SAVING ***********************');
    // return print(imageUrls);
    await products.add(product.toJson());
  }

  List<Asset> images = List<Asset>();
  List<String> imageUrls = <String>[];
  String _error = 'No Error Dectected';

  List<DropdownMenuItem<ManualDropString>> buildDropDownMenuItems(
      List<ManualDropString> dropdownItems) {
    List<DropdownMenuItem<ManualDropString>> items = List();
    for (ManualDropString manual in _dropdownItems) {
      items.add(
        DropdownMenuItem(
          child: Text(manual.name),
          value: manual,
        ),
      );
    }
    return items;
  }

  @override
  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;

    _categorydownMenuItems = buildCategoryDropDownMenuItems(_categorydownItems);
    _selectedCategory = _categorydownMenuItems[0].value;
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }
  // the 3 methods below to work with image list download it to firebase

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();

    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 20,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }

  Future<dynamic> postImage(Asset imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    // here is the diffrent between list ans string putData()
    StorageUploadTask uploadTask =
        reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    final url = await storageTaskSnapshot.ref.getDownloadURL();
    print("IMAGE UPLOADED =========");

    print(url);
    return url;
  }

  Future<void> uploadImages() async {
    for (var imageFile in images) {
      await postImage(imageFile).then((downloadUrl) {
        imageUrls.add(downloadUrl.toString());
        if (imageUrls.length == images.length) {
          String documentId = DateTime.now().millisecondsSinceEpoch.toString();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Center(child: Text('Error: $_error')),
              RaisedButton(
                child: Text("Pick images"),
                onPressed: loadAssets,
              ),
              Flexible(
                flex: 2,
                child: buildGridView(),
              ),
              Divider(
                color: Colors.blue,
              ),
              Flexible(
                flex: 4,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          width: 300,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              color: Colors.white,
                              border: Border.all(color: Colors.grey)),
                          child: Center(
                            child: DropdownButton<ManualDropString>(
                              isDense: true,
                              style: TextStyle(
                                color: Color(0xff7E8388),
                              ),
//                isDense: true,
                              icon: Padding(
                                padding: const EdgeInsets.only(left: 50),
                                child: Icon(Icons.sort),
                              ),
                              value: _selectedItem,
                              items: _dropdownMenuItems,
                              onChanged: (value) {
                                setState(() {
                                  _selectedItem = value;
                                });
                              },
                            ),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 300,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: Colors.white,
                            border: Border.all(color: Colors.grey)),
                        child: Center(
                          child: DropdownButton<CategoryDropString>(
                            isDense: true,
                            style: TextStyle(
                              color: Color(0xff7E8388),
                            ),
//                isDense: true,
                            icon: Padding(
                              padding: const EdgeInsets.only(left: 50),
                              child: Icon(Icons.sort),
                            ),
                            value: _selectedCategory,
                            items: _categorydownMenuItems,
                            onChanged: (value) {
                              setState(() {
                                _selectedCategory = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        child: TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: "Name",
                            //hintText: 'price',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        child: TextField(
                          controller: _priceController,
                          decoration: InputDecoration(
                            labelText: "Price",
                            //hintText: 'price',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        child: TextField(
                          controller: _descController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            labelText: "Description",
                            //hintText: 'price',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          persistentFooterButtons: [
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: FlatButton(
                  color: Theme.of(context).primaryColor,
                  child: Text("ADD"),
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });

                    print(_selectedItem.name);
                    await uploadImages();
                    Products products = Products(
                        productType: _selectedItem.name,
                        categoriesProduct: _selectedCategory.name,
                        productDescription: _descController.text,
                        price: _priceController.text,
                        productName: _nameController.text,
                        images: imageUrls);
                    await addProduct(products);
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
            )
          ],
        ),
        if (isLoading == true)
          Material(
            color: Colors.white54,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
      ],
    );
  }
}
