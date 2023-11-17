import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/cus_form.dart';

class SignPage extends StatefulWidget {
  const SignPage({super.key});

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final form = FormModel();

  @override
  void initState() {
    super.initState();
  }

  void onSubmit() {
    context.pop();
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
            ),
          ),
          CusFormItem(
            child: CusTextFormField(
              maxLength: 20,
              obscureText: true,
              labelText: 'Password',
              hintText: 'Enter your Password',
              onChanged: (value) => form.password = value,
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
        title: const Text('Sign'),
      ),
      body: Center(
        heightFactor: 1.5,
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
  
  @override
  String toString() {
    return 'FormModel: {username: $username, password: $password';
  }
}