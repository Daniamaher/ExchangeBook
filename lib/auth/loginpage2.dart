import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/exchangebook/model/user.dart';
import 'package:flutter_application_1/exchangebook/provider/userprovider.dart';
import 'package:flutter_application_1/exchangebook/widget/custombutton.dart';
import 'package:flutter_application_1/exchangebook/widget/customtextformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key});

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController universtiyIdController = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    void showErrorDialog(String message) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            MaterialButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }

    Future<void> addUser() async {
      try {
        final uniNumber = '789789';
        final password = '789789';

        await firestore.collection('users').doc(uniNumber).set({
          'password': password,
        });

        print('Document added successfully.');
      } catch (error) {
        print('Error adding document: $error');
      }
    }

    Future<UserP?> signIn(BuildContext context) async {
      try {
        final uniNumber = universtiyIdController.text.trim();
        final password = passwordController.text.trim();

        final userSnapshot =
            await firestore.collection('users').doc(uniNumber).get();

        if (userSnapshot.exists) {
          final userData = userSnapshot.data();
          final storedPassword = userData!['password'];

          if (password == storedPassword) {
            final userProvider =
                Provider.of<UserProvider>(context, listen: false);
            final currentUser = UserP(uniNumber);
            userProvider.setCurrentUser(currentUser);

            Navigator.pushReplacementNamed(context, '/exchange_book');
            print('**************');

            print(currentUser.uniNumber);
            return currentUser;
          } else {
            showErrorDialog('Incorrect password');
          }
        } else {
          showErrorDialog('User does not exist');
        }
      } catch (error) {
        print(error);
        showErrorDialog('An error occurred, please try again later');
      }

      return null;
    }

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 150),
              Center(
                child: Image.asset(
                  'images/imageicon.png',
                  width: 220,
                  height: 220,
                ),
              ),
              SizedBox(height: 40),
              CustomTextField(
                hint: 'University ID',
                controller: universtiyIdController,
              ),
              SizedBox(height: 40),
              CustomTextField(
                hint: 'Password',
                controller: passwordController,
                obscureText: true,
              ),
              SizedBox(height: 40),
              Center(
                child: SizedBox(
                  width: 170,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      signIn(context);
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
