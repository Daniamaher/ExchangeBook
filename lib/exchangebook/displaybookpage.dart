import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/exchangebook/pages/editbookpage.dart';
import 'package:flutter_application_1/exchangebook/pages/exchangebookpage.dart';
import 'package:flutter_application_1/exchangebook/provider/userprovider.dart';
import 'package:provider/provider.dart';

class DisplayBook extends StatelessWidget {
  final String title;
  final String price;
  final String email;
  final String imageurl;
  final String uniNumber;

  const DisplayBook({
    Key? key,
    required this.title,
    required this.price,
    required this.email,
    required this.imageurl,
    required this.uniNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserProvider>(context).currentUser;
    bool enabled = uniNumber == currentUser?.uniNumber;

    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details'),
        actions: [
          if (enabled)
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return [
                  if (enabled)
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(Icons.edit),
                          SizedBox(width: 10),
                          Text('Edit'),
                        ],
                      ),
                      value: 'Edit',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditBookPage(
                                  initialTitle: title,
                                  initialEmail: email,
                                  initialImageUrl: imageurl,
                                  initialPrice: price)),
                        );
                      },
                    ),
                  if (enabled)
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(Icons.delete),
                          SizedBox(width: 10),
                          Text('Delete'),
                        ],
                      ),
                      value: 'Delete',
                      onTap: () async {
                        try {
                          QuerySnapshot snapshot = await FirebaseFirestore
                              .instance
                              .collection('books')
                              .where('uniNumber', isEqualTo: uniNumber)
                              .where('bookName', isEqualTo: title)
                              .get();

                          if (snapshot.docs.isNotEmpty) {
                            await snapshot.docs.first.reference.delete();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ExchangeBookPage(),
                              ),
                            );
                          } else {
                            print(
                                'Document with uniNumber $uniNumber and bookName $title not found');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('Book not found. Please try again.'),
                              ),
                            );
                          }
                        } catch (e) {
                          print('Error deleting book: $e');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Failed to delete book. Please try again later.'),
                            ),
                          );
                        }
                      },
                    ),
                ];
              },
            ),
        ],
      ),
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              imageurl != null
                  ? Image.network(
                      imageurl!,
                      height: 300,
                      width: 320,
                    )
                  : SizedBox(
                      width: double.infinity,
                      height: 110,
                      child: Center(
                        child: Text('Image not available'),
                      ),
                    ),
              SizedBox(height: 20),
              Text(
                title,
                style: TextStyle(
                  color: ksecondaryColor,
                  fontSize: 30,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Book Price : \$$price',
                style: TextStyle(
                  color: ksecondaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Email: $email',
                style: TextStyle(
                  color: ksecondaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
