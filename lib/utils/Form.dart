import 'package:flutter/material.dart';

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Row(
            children: [
              // Add TextFormFields and ElevatedButton here.

              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'First name'),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'name';
                    }
                    return null;
                  },
                ),
              ),
              Expanded(
                  child: TextFormField(
                      decoration: InputDecoration(labelText: 'last name'),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'surname';
                        }
                        return null;
                      })),
            ],
          ),
          TextFormField(
              keyboardType: TextInputType
                  .emailAddress, // Use email input type for emails.
              decoration: new InputDecoration(
                  hintText: 'you@example.com', labelText: 'E-mail Address')),
          TextFormField(
              keyboardType: TextInputType
                  .emailAddress, // Use email input type for emails.
              decoration: new InputDecoration(labelText: 'Phone number')),
          ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing information')),
                  );
                }
              },
              child: Text('Submit')),
        ],
      ),
    );
  }
}
