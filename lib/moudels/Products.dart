import 'package:miniad/moudels/categories.dart';

class Products {
  // whay when i write final it need a constractor

  String proId;
  String productName;
  String productImage;
  String productDescription;
  String price;
  String productType;
  String uId;
  List<String> images;
  String categoriesProduct;

  Products(
      {this.price,
      this.productDescription,
      this.productImage,
      this.productName,
      this.uId,
      this.productType,
      this.images,
      this.proId,
      this.categoriesProduct});

  Products.fromJson(Map<String, dynamic> json, String productId) {
    price = json['price'];
    productDescription = json['desc'];
    productName = json['name'];
    productType = json['productTypes'];
    uId = json['uId'];
    categoriesProduct = json['categories'];
    proId = productId;
    images = List.castFrom(json['images']);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": productName,
//      "photos": productImage,
      "desc": productDescription,
      "price": price,
      "uId": uId,
      "productTypes": productType,
      'images': images,
      "categories": categoriesProduct,
    };
  }
}
