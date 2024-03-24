
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/exchangebook/pages/exchangebookpage.dart';
import 'package:flutter_application_1/exchangebook/widget/custombutton.dart';
import 'package:flutter_application_1/exchangebook/widget/customtextformfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import '../provider/userprovider.dart';

class EditBookPage extends StatefulWidget {
  final String initialTitle;
  final String initialPrice;
  final String initialEmail;
  final String initialImageUrl;

  EditBookPage({
    Key? key,
    required this.initialTitle,
    required this.initialPrice,
    required this.initialEmail,
    required this.initialImageUrl,
  }) : super(key: key);

  @override
  State<EditBookPage> createState() => _EditBookPageState();
}

class _EditBookPageState extends State<EditBookPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController bookNameController = TextEditingController();
  final TextEditingController bookPriceController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  late File? file;
  late String imageUrl;

  @override
  void initState() {
    super.initState();
    bookNameController.text = widget.initialTitle;
    bookPriceController.text = widget.initialPrice;
    emailController.text = widget.initialEmail;
    imageUrl = widget.initialImageUrl;
  }

  Future<void> getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imageGallery =
        await picker.pickImage(source: ImageSource.gallery);
    if (imageGallery != null) {
      file = File(imageGallery.path);
      var imageName = basename(imageGallery.path);
      var refStorage =
          FirebaseStorage.instance.ref("images").child(imageName);
      await refStorage.putFile(file!);
      imageUrl = await refStorage.getDownloadURL();
      print('Image uploaded successfully. URL: $imageUrl');
      setState(() {});
    }
  }








/*

Future<void> updateBook(BuildContext context) async {
  final currentUser =
      Provider.of<UserProvider>(context, listen: false).currentUser;

  if (formKey.currentState!.validate()) {
    formKey.currentState!.save();

    var updatedTitle = bookNameController.text.isNotEmpty
        ? bookNameController.text
        : widget.initialTitle;
    var updatedPrice = bookPriceController.text.isNotEmpty
        ? bookPriceController.text
        : widget.initialPrice;
    var updatedEmail = emailController.text.isNotEmpty
        ? emailController.text
        : widget.initialEmail;

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('books')
          .where('bookName', isEqualTo: widget.initialTitle)
          .where('email', isEqualTo: widget.initialEmail)
          .get();

      if (snapshot.docs.isNotEmpty) {
        var updateData = {
          'bookName': updatedTitle,
          'bookPrice': updatedPrice,
          'email': updatedEmail,
          'uniNumber': currentUser?.uniNumber,
        };

        // Check if a new image is uploaded or not
        if (file != null) {
          var imageName = basename(file!.path);
          var refStorage = FirebaseStorage.instance.ref("images").child(imageName);
          await refStorage.putFile(file!);
          var newImageUrl = await refStorage.getDownloadURL();
          updateData['imageUrl'] = newImageUrl;
        }

        await snapshot.docs.first.reference.update(updateData);

        print('Book updated successfully!');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Book Updated successfully!'),
        ));
      } else {
        print('Document with title ${widget.initialTitle} not found');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Book not found. Please try again.'),
        ));
      }
    } catch (e) {
      print('Error updating book: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to update book. Please try again later.'),
      ));
    }
  }
}
*/




Future<void> updateBook(BuildContext context) async {
  final currentUser =
      Provider.of<UserProvider>(context, listen: false).currentUser;

  if (formKey.currentState!.validate()) {
    formKey.currentState!.save();

    var updatedTitle = bookNameController.text.isNotEmpty
        ? bookNameController.text
        : widget.initialTitle;
    var updatedPrice = bookPriceController.text.isNotEmpty
        ? bookPriceController.text
        : widget.initialPrice;
    var updatedEmail = emailController.text.isNotEmpty
        ? emailController.text
        : widget.initialEmail;

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('books')
          .where('bookName', isEqualTo: widget.initialTitle)
          .where('email', isEqualTo: widget.initialEmail)
          .get();

      if (snapshot.docs.isNotEmpty) {
        var updateData = {
          'bookName': updatedTitle,
          'bookPrice': updatedPrice,
          'email': updatedEmail,
          'uniNumber': currentUser?.uniNumber,
        };

        // Check if a new image is uploaded or not
        if (file != null && imageUrl != widget.initialImageUrl) {
          var imageName = basename(file!.path);
          var refStorage = FirebaseStorage.instance.ref("images").child(imageName);
          await refStorage.putFile(file!);
          var newImageUrl = await refStorage.getDownloadURL();
          updateData['imageUrl'] = newImageUrl;
        } else {
          updateData['imageUrl'] = widget.initialImageUrl;
        }

        await snapshot.docs.first.reference.update(updateData);

        print('Book updated successfully!');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Book Updated successfully!'),
        ));
      } else {
        print('Document with title ${widget.initialTitle} not found');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Book not found. Please try again.'),
        ));
      }
    } catch (e) {
      print('Error updating book: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to update book. Please try again later.'),
      ));
    }
  }
}










  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          'Edit Book',
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
                  controller: bookNameController,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  hint: 'Book Price',
                  controller: bookPriceController,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hint: 'Email',
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
                  textbutton: 'Update Book',
                  onTap: () {
                    updateBook(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExchangeBookPage(),
                      ),
                    );
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
