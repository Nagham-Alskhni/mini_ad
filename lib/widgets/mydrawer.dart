import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.amber,
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(17.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Ahmad',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.white30,
              ),
              ListTile(
                leading: Icon(
                  Icons.dashboard,
                  color: Colors.white,
                ),
                title: Text(
                  'Prfile',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Divider(
                color: Colors.white30,
              ),
              ListTile(
                leading: Icon(
                  Icons.add_shopping_cart,
                  color: Colors.white,
                ),
                onTap: () {
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (BuildContext context) => ProjectDrawer()));
                },
                title: Text(
                  'myFavorite',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Divider(
                color: Colors.white30,
              ),
              ListTile(
                leading: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                title: Text(
                  'myItems',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Divider(
                color: Colors.white30,
              ),
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                title: Text(
                  'inviteFriends',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
//                width: 20,
//                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xffF4465E),
                  border: Border.all(color: Colors.white),
                ),
                child: Positioned(
                  child: SizedBox(
                    width: 250,
                    height: 50,
                    child: RaisedButton(
                      elevation: 0.1,
                      onPressed: () {},
                      color: Color(0xffF4465E),
                      child: Text(
                        'LOGOUT',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),

//              Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: [
//                  Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: Icon(
//                      Icons.menu,
//                      color: Colors.white,
//                    ),
//                  ),
//                  Text(
//                    'Menue',
//                    style: TextStyle(color: Colors.white),
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: Container(
//                      child: Column(
//                        children: [
////                          CustomDropDown()
//                          DropdownButton<String>(
//                            dropdownColor: Color(0xffF4465E),
//                            icon: Icon(
//                              Icons.arrow_downward,
//                              color: Colors.white,
//                            ),
//                            iconSize: 20,
//                            style: TextStyle(color: Colors.grey),
//                            items: subMenue.map((String dropDownItem) {
//                              return DropdownMenuItem<String>(
//                                value: dropDownItem,
//                                child: Text(dropDownItem),
//                              );
//                            }).toList(),
//                            onChanged: (value) {
//                              setState(() {
////                    cureentItemSelected = value;
//                              });
//                            },
//                            value: null,
//                          ),
//                        ],
//                      ),
//                    ),
//                  ),
//                ],
//              ),
            ],
          ),
        )
      ],
    );
  }
}
