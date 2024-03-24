import 'package:flutter/material.dart';
import 'package:flutter_application_1/exchangebook/widget/customtextformfield.dart';


class AddBookForm extends StatefulWidget {
  const AddBookForm({
    Key? key,
  }) : super(key: key);

  @override
  State<AddBookForm> createState() => _AddBookFormState();
}

class _AddBookFormState extends State<AddBookForm> {
  final GlobalKey<FormState> formKey = GlobalKey();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  String? bookName, bookPrice;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        children: [
          const SizedBox(
            height: 32,
          ),
          CustomTextField(
            onSaved: (value) {
              bookName = value;
            },
            hint: 'Book Name',
          ),
          const SizedBox(
            height: 16,
          ),
          CustomTextField(
            onSaved: (value) {
              bookPrice= value;
            },
            hint: 'Book Price ',
           
          ),
          const SizedBox(
            height: 32,
          ),
          const SizedBox(
            height: 32,
          ),
         
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}