import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:miniad/screens/CreatProduct.dart';
import 'package:miniad/screens/PhoneLogIn.dart';
import 'package:miniad/screens/productspage.dart';
import 'package:miniad/screens/userProfile.dart';
import 'package:miniad/widgets/CategoryTheme.dart';
import 'package:miniad/moudels/Products.dart';
import 'package:miniad/widgets/mydrawer.dart';

// what are the below lines???
enum WidgetMarker { Exchange, Donate, Sell, Rent }

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  WidgetMarker selectedMarker = WidgetMarker.Exchange;

  List<Products> products = [
    Products(
        productImage:
            'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/9414c32d-c4bd-405b-8c95-071fb4ffe047/air-max-270-extreme-older-shoe-RC0bDl.jpg',
        productName: 'New Shouse',
        price: '50',
        productDescription: 'new by Nike')
  ];

  Future getProducts() async {
    var fireStore = FirebaseFirestore.instance;
    QuerySnapshot qs = await fireStore.collection("Products").get();
    return qs.docs;
  }

  getData() async {
    return await FirebaseFirestore.instance.collection("Products").get();
  }

  // what the below line do??
  GlobalKey<ScaffoldState> drawerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    // what this widget???
    SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    );
    return Scaffold(
      key: drawerKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'mInI add',
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
          onPressed: () {
            drawerKey.currentState.openDrawer();
          },
          icon: Icon(EvaIcons.menu2Outline),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(EvaIcons.search),
          ),
        ],
      ),
      drawer: Drawer(
        child: MyDrawer(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (FirebaseAuth.instance.currentUser == null)
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PhoneLogIn()));
          else
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreatProduct()));
        },
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Products').snapshots(),
        builder: (BuildContext Context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //
          QuerySnapshot snap = snapshot.data;

          List<DocumentSnapshot> documents = snap.docs;

          //

          return Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true, // what this prop do?
                      children: [
                        CategoryTheme(
                          icon: EvaIcons.home,
                          size: 50,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(
                            left: 10,
                          ),
                          backgroundColor: Color(0xffff4ac0),
                        ),
                        CategoryTheme(
                          icon: Icons.library_books,
                          size: 50,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(
                            left: 10,
                          ),
                          backgroundColor: Color(0xff2ecc71),
                        ),
                        CategoryTheme(
                          icon: EvaIcons.thermometerOutline,
                          size: 50,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(
                            left: 10,
                          ),
                          backgroundColor: Color(0xffFCD46A),
                        ),
                        CategoryTheme(
                          icon: Icons.directions_car,
                          size: 50,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(
                            left: 10,
                          ),
                          backgroundColor: Color(0xff16a085),
                        ),
                        CategoryTheme(
                          icon: Icons.mobile_screen_share,
                          size: 50,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(
                            left: 10,
                          ),
                          backgroundColor: Color(0xffEE84B9),
                        ),
                        CategoryTheme(
                          icon: EvaIcons.shuffle,
                          size: 50,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(
                            left: 10,
                          ),
                          backgroundColor: Color(0xff3498db),
                        ),
                        CategoryTheme(
                          icon: EvaIcons.cube,
                          size: 50,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(
                            left: 10,
                          ),
                          backgroundColor: Color(0xfffc5f53),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  CarouselSlider(
                    options: CarouselOptions(aspectRatio: 16 / 9),
                    items: [1, 2, 3, 4].map((i) {
                      // here i need to set list of products????
                      return Builder(
                        builder: (BuildContext _context) {
                          return InkWell(
                            onTap: () {},
                            child: Container(
                              width: MediaQuery.of(_context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image(
                                  image: NetworkImage(
                                    '',
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Row(
                    children: [
                      FlatButton(
                        child: Text(
                          'Exchange',
                          style: TextStyle(
                              color: (selectedMarker == WidgetMarker.Exchange)
                                  ? Colors.black
                                  : Colors.black12),
                        ),
                        onPressed: () {
                          setState(() {
                            selectedMarker = WidgetMarker.Exchange;
                          });
                        },
                      ),
                      FlatButton(
                        child: Text(
                          'Donate',
                          style: TextStyle(
                              color: (selectedMarker == WidgetMarker.Donate)
                                  ? Colors.black
                                  : Colors.black12),
                        ),
                        onPressed: () {
                          setState(() {
                            selectedMarker = WidgetMarker.Donate;
                          });
                        },
                      ),
                      FlatButton(
                        child: Text(
                          'Sell',
                          style: TextStyle(
                              color: (selectedMarker == WidgetMarker.Sell)
                                  ? Colors.black
                                  : Colors.black12),
                        ),
                        onPressed: () {
                          setState(() {
                            selectedMarker = WidgetMarker.Sell;
                          });
                        },
                      ),
                      FlatButton(
                        child: Text(
                          'Rent',
                          style: TextStyle(
                              color: (selectedMarker == WidgetMarker.Rent)
                                  ? Colors.black
                                  : Colors.black12),
                        ),
                        onPressed: () {
                          setState(() {
                            selectedMarker = WidgetMarker.Rent;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: getCustomContainer(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getCustomContainer() {
    switch (selectedMarker) {
      case WidgetMarker.Exchange:
        return GridViewTypes(
          products: products,
          type: 'Exchange',
        );
      case WidgetMarker.Donate:
        return GridViewTypes(
          products: products,
          type: 'Donate',
        );

      case WidgetMarker.Sell:
        return GridViewTypes(
          products: products,
          type: 'Sell',
        );
      case WidgetMarker.Rent:
        return GridViewTypes(
          products: products,
          type: 'Rent',
        );
    }
  }
}

class GridViewTypes extends StatelessWidget {
  GridViewTypes({Key key, @required this.products, this.type})
      : super(key: key);

  final List<Products> products;
  String type;
//  Products products;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Products')
          .where('productTypes', isEqualTo: type)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.25,
              physics: ClampingScrollPhysics(),
              children: snapshot.data.docs.map((DocumentSnapshot docSnapshot) {
                final data = docSnapshot.data();
                final Products products =
                    Products.fromJson(data, docSnapshot.id);
                return Stack(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 1 / 1,
                            child: Image(
                              image: NetworkImage((products.images.isEmpty)
                                  ? "https://images.pexels.com/photos/4996652/pexels-photo-4996652.jpeg?cs=srgb&dl=pexels-johannes-rapprich-4996652.jpg&fm=jpg"
                                  : products.images[0] ??
                                      "https://images.pexels.com/photos/4996652/pexels-photo-4996652.jpeg?cs=srgb&dl=pexels-johannes-rapprich-4996652.jpg&fm=jpg"),
                            ),
                          ),
                          Text(products.productName),
                          Text(
                            "${products.price}\ EGP",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.amber,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => ProductPage(
                                      uId: products.proId,
                                    ))),
                          );
                        },
                      ),
                    )
                  ],
                );
              }).toList());
        }
      },
    );
  }
}
