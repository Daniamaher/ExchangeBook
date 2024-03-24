import 'dart:io';
//import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/exchangebook/pages/exchangebookpage.dart';
import 'package:flutter_application_1/exchangebook/widget/custombutton.dart';
import 'package:flutter_application_1/exchangebook/widget/customtextformfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

import '../provider/userprovider.dart';

class AddBookPage extends StatefulWidget {
  AddBookPage({Key? key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController bookNameController = TextEditingController();
  final TextEditingController bookPriceController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  File? file;
  late String imageUrl;

  Future<void> getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imageGallery =
        await picker.pickImage(source: ImageSource.gallery);
    if (imageGallery != null) {
      file = File(imageGallery.path);
      var imageName = basename(imageGallery.path);
      var refStorage = FirebaseStorage.instance.ref("images").child(imageName);
      await refStorage.putFile(file!);
      imageUrl = await refStorage.getDownloadURL();
      print('Image uploaded successfully. URL: $imageUrl');
      setState(() {});
    }
  }

  String? bookName, bookPrice;

  Future<void> addBookToFirestore(BuildContext context) async {
    final currentUser =
        Provider.of<UserProvider>(context, listen: false).currentUser;

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await FirebaseFirestore.instance.collection('books').add({
        'bookName': bookNameController.text,
        'bookPrice': bookPriceController.text,
        'imageUrl': imageUrl,
        'email': emailController.text,
        'uniNumber': currentUser?.uniNumber,
      });
      print('Book added successfully!');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Book added successfully!'),
      ));
      bookNameController.clear();
      bookPriceController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          'Add Book',
          style: TextStyle(color: ksecondaryColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(
                  hint: 'Book Name',
                  onSaved: (value) {
                    bookName = value;
                  },
                  controller: bookNameController,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  hint: 'Book Price',
                  onSaved: (value) {
                    bookPrice = value;
                  },
                  controller: bookPriceController,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hint: 'Email',
                  onSaved: (value) {
                    //email= value;
                  },
                  controller: emailController,
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: MaterialButton(
                    onPressed: getImage,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.upload_outlined),
                        SizedBox(width: 2),
                        Text('Upload Image'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                CustomButton(
                  textbutton: 'Add Book',
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      addBookToFirestore(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ExchangeBookPage()),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
