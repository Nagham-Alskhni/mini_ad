import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miniad/moudels/users.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  File file;
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    //picked file here where i store the image file

    setState(() {
      file = File(pickedFile.path);
    });
  }

  Future uploadPic(BuildContext context) async {
    String fileName = basename(file.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(file);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
//    what is the below code ??
    final profilePhotoUrl = await taskSnapshot.ref.getDownloadURL();

    return profilePhotoUrl;
  }

  Users usersModels;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    String newPhotoUrl;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Stack(
//          alignment: Alignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 4,
              color: Colors.blue,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 150, left: 30),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(),
                      child: CircleAvatar(
                        backgroundImage: file == null
                            ? NetworkImage(
                                'https://img.icons8.com/officel/2x/user.png'
                                // what the diffrence beytween Image.file and FileImage()
                                )
                            : FileImage(file),
                        radius: 50,
                      ),
                    ),
                  ),
                  Container(
                    width: 300,
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Name',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 300,
                    child: TextField(
                      controller: _cityController,
                      decoration: InputDecoration(
                        hintText: 'City',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: 100,
                    child: FlatButton(
                      onPressed: () async {
                        setState(() async {
                          newPhotoUrl = await uploadPic(context);
                          CollectionReference users =
                              FirebaseFirestore.instance.collection('Users');
//                           Strig uId replaced with below
                          String uId = _auth.currentUser.uid.toString();
                          // dont forget to add merge here too
                          users.doc(uId).set({
                            'name': _nameController.text.trim(),
                            'city': _cityController.text.trim(),
                            'profilePhoto': newPhotoUrl,
                          }, SetOptions(merge: true));
                        });
                      },
                      child: Text('Save'),
                      color: Colors.lightBlue,
                      textColor: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Products',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GridView.count(
                    physics: ClampingScrollPhysics(),
                    crossAxisCount: 2,
                    shrinkWrap: true, // what this prop do?
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 150, left: 250),
              child: IconButton(
                icon: Icon(Icons.camera),
                color: Colors.grey,
                onPressed: getImage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
