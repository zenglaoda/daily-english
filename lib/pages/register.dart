import 'package:flutter/material.dart';
import '../widgets/cus_form.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final form = FormModel();

  @override
  void initState() {
    super.initState();
  }

  void onSubmit() {
    _formKey.currentState?.validate();
  }

  Widget renderForm() {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CusFormItem(
            child: CusTextFormField(
              maxLength: 20,
              labelText: 'Username',
              hintText: 'Enter your username',
              onChanged: (value) => form.username = value,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'username is required';
                }
                return null;
              },
            ),
          ),
          CusFormItem(
            child: CusTextFormField(
              maxLength: 20,
              obscureText: true,
              labelText: 'Password',
              hintText: 'Enter your Password',
              onChanged: (value) => form.password = value,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Password is required';
                }
                return null;
              },
            ),
          ),
          CusFormItem(
            child: CusTextFormField(
              maxLength: 20,
              obscureText: true,
              labelText: 'Confirm',
              hintText: 'Confirm Password',
              onChanged: (value) => form.confirm = value,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Password is required';
                }
                if (value != form.password) {
                  return 'Entered passwords differ';
                }
                return null;
              },
            ),
          ),
          CusFormItem(
            top: 30,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50)
              ),
              onPressed: onSubmit, 
              child: const Text('Submit')
            ),
          ),
        ],
      ) 
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Center(
        heightFactor: 1.4,
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              width: double.infinity,
              child: renderForm()
            ),
          ) 
        ),
      )
    );
  }
}


class FormModel {
  String username = '';
  String password = '';
  String confirm = '';
  
  @override
  String toString() {
    return 'FormModel: {username: $username, password: $password, confirm: $confirm}';
  }
}