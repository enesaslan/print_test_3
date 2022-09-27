import 'package:flutter/material.dart'; 

class MyCustomTextBox extends StatefulWidget {
  MyCustomTextBox({this.hintText, this.textBoxController, this.inputAction});

  String? hintText;
  TextEditingController? textBoxController = TextEditingController();
  TextInputAction? inputAction;

  @override
  State<MyCustomTextBox> createState() => _MyCustomTextBoxState();
}

class _MyCustomTextBoxState extends State<MyCustomTextBox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: TextFormField(
        controller: widget.textBoxController,
        decoration: InputDecoration(
          
          labelText: "${widget.hintText}",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        textInputAction: widget.inputAction,
      ),
    );
  }
}
