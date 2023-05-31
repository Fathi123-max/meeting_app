import 'package:flutter/material.dart';

import '../../model/user_model.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({Key? key}) : super(key: key);
  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _user = User(
    name: '',
    image: '',
    status: '',
    language: '',
    about: '',
    interests: [],
    availability: {},
    email: '',
    phone: '',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (value) => _user.name = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              // Add input fields for other properties of the User model
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Create a new User object with the values entered by the user
                    final newUser = User(
                      name: _user.name,
                      image: _user.image,
                      status: _user.status,
                      language: _user.language,
                      about: _user.about,
                      interests: _user.interests,
                      availability: _user.availability,
                      email: _user.email,
                      phone: _user.phone,
                    );
                    // Save the new User object to a database or display it on the screen
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
