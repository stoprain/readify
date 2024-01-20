import 'package:flutter/material.dart';

import '../util/preference.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _api = '';
  String _user = '';
  String _pass = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {});
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Preference.setString(Preference.API, _api);
      Preference.setString(Preference.USER, _user);
      Preference.setString(Preference.PASS, _pass);

      Navigator.pop(context);
    }
  }

  void _login() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'API address'),
                initialValue: Preference.getString(Preference.API),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter API address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _api = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'user'),
                initialValue: Preference.getString(Preference.USER),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter user';
                  }
                  return null;
                },
                onSaved: (value) {
                  _user = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'pass'),
                initialValue: Preference.getString(Preference.PASS),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter pass';
                  }
                  return null;
                },
                onSaved: (value) {
                  _pass = value!;
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Save'),
              ),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Login'),
              ),
            ],
          )),
    );
  }
}
