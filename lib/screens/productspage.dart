import 'package:carousel_slider/carousel_slider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:miniad/moudels/Products.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductPage extends StatefulWidget {
  final String uId;
  ProductPage({this.uId});
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Products product;
//  String productId = '5AOIICWrFqNdTuRhcENv';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Product Details",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0,
        actionsIconTheme: IconThemeData(
          color: Colors.black,
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(EvaIcons.menu2Outline),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(EvaIcons.search),
          ),
        ],
      ),
      body: StreamBuilder(
        //To stream a single document we will need the id of that document
        // you should send the id to this screen i the future but for testing we will
        // pick an id from Firestore
        // now we will change from streaming a collection to streaming one document only
        // this will change the type of snapshot we get from QuerySnapshot to DocumentSnapshot

        stream: FirebaseFirestore.instance
            .collection('Products')
            .doc(widget.uId)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          //the stream now gives us a snapshot of one document only
          //we will check first if we do not have data we will display a progress indicator
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            //else of we have data we will begin to display the data we have
            // first read all the JSON data that came from Firestore into the json variable
            final json = snapshot.data.data();
            // second convert the JSON data to our Products object to make it easier to deal with
            // and prevent any typing mistakes. e.g.: you could make a mistake in the name of the field and get no data
            final product = Products.fromJson(json, snapshot.data.id);

            //now that we have our product object loaded with the values
            // from Firestore, we can begin displaying its content
            return Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                      ),
                      items: product.images.map((i) {
                        // here i need to set list of products????
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(i),

//                                child: Image(
//                                  image: NetworkImage(
//                                      'https://media.istockphoto.com/photos/illustration-of-generic-compact-red-car-side-view-picture-id952108732'),
//                                  fit: BoxFit.cover,
//                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),

//                    Hero(
//                      tag: product.images[0],
//                      child: AspectRatio(
//                        aspectRatio: 1 / 1,
//                        child: Image(
//                          image: NetworkImage(product.images[1]),
//                        ),
//                      ),
//                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        product.productName,
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${product.price}\E\G\P",
                        style: TextStyle(fontSize: 50, color: Colors.amber),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          OutlineButton.icon(
                            onPressed: () {},
                            color: Colors.white,
                            splashColor: Colors.amber,
                            icon: Icon(
                              Icons.phone,
                              color: Colors.green,
                            ),
                            label: Text('contact'),
                          ),
                          OutlineButton.icon(
                            onPressed: () {},
                            color: Colors.white,
                            splashColor: Colors.amber,
                            highlightedBorderColor: Colors.amber,
                            icon: Icon(
                              Icons.shopping_cart,
                              color: Colors.green,
                            ),
                            label: Text('Order Now'),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(product.productDescription),
                    )
                  ],
                ),
              ),
            );
//              ListView(
//              children: [
//                Text(product.productName ?? "Product Name"),
//                Text(product.price ?? "Price unknown"),
//                // put your UI here. you can read all fields from object product
//              ],
//            );
          }
        },
      ),
    );
  }
}
