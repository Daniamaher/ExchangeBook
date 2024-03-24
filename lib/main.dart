
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_application_1/auth/loginpage.dart';
import 'package:flutter_application_1/auth/loginpage2.dart';
//import 'package:flutter_application_1/exchangebook/displaybookpage.dart';
import 'package:flutter_application_1/exchangebook/pages/addBookPage.dart';
import 'package:flutter_application_1/exchangebook/pages/exchangebookpage.dart';
import 'package:flutter_application_1/exchangebook/provider/userprovider.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_application_1/exchangebook/pages/exchangebookpage.dart';
//\import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_app_check/firebase_app_check.dart';


void main() async {

WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform,);
  runApp(MyApp());

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key}) ;


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(), 
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
         initialRoute: '/Login_Page', 
        routes: {
          '/add_book': (context) => AddBookPage(), 
          '/exchange_book': (context) => ExchangeBookPage(), 
           '/Login_Page': (context) => LoginPage(), 
         /*   '/DisplayBook': (context) => DisplayBook(
        title: 'Python',
        price: '22.0',
        email: 'dania@gmail.com',
      )
      */
        },
      
      ),
    );
  }
} 



