import 'package:flutter/material.dart';
import 'package:flutter_application_1/exchangebook/displaybookpage.dart';
import 'provider/userprovider.dart';
import 'package:provider/provider.dart';

class BookItem extends StatelessWidget {
  BookItem({
    super.key,
    this.bookName,
    required this.bookPrice,
    this.imageUrl,
    this.email,
    this.UniNumber,
  });
  final bookName;
  final String bookPrice;
  final imageUrl;
  final email;
  final UniNumber;
  @override
  Widget build(BuildContext context) {
    //final currentUser = Provider.of<UserProvider>(context).currentUser;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DisplayBook(
              title: bookName,
              price: bookPrice,
              email: email,
              imageurl: imageUrl,
              uniNumber: UniNumber,
            ),
          ),
        );
      },
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            imageUrl != null
                ? Image.network(
                    imageUrl!,
                    height: 110,
                    width: 150,
                    // fit: BoxFit.cover,
                  )
                : SizedBox(
                    width: double.infinity,
                    height: 110,
                    child: Center(
                      child: Text('Image not available'),
                    ),
                  ),
            Text(bookName),
            Center(
                child: Padding(
              padding: EdgeInsets.all(0),
              child: Text(
                '$bookPrice\$',
                style: TextStyle(fontSize: 15, color: Colors.yellowAccent),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
