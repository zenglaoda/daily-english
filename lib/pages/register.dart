import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();

}

class _RegisterPageState extends State<RegisterPage> {
  
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final Widget formEl = Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          FieldItem(
            TextFormField(
              maxLength: 20,
              decoration: const InputDecoration(
                counterText: '',
                labelText: 'Username',
                hintText: 'Enter your username',
                labelStyle: TextStyle(fontSize: 16),
                floatingLabelStyle:TextStyle(fontSize: 20),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.only(left: 16, right: 10, top: 5, bottom: 5),
              ),
              buildCounter: null,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'username is required';
                }
                return null;
              },
            ),
          ),
          FieldItem(
            TextFormField(
              maxLength: 20,
              buildCounter: null,
              obscureText: true,
              decoration: const InputDecoration(
                counterText: '',
                labelText: 'Password',
                hintText: 'Enter your Password',
                floatingLabelStyle:TextStyle(fontSize: 20),
                labelStyle: TextStyle(fontSize: 16),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.only(left: 16, right: 10, top: 5, bottom: 5),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }
                return null;
              },
            ),
          ),
          FieldItem(
            top: 30,
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50)
              ),
              onPressed: (){}, 
              child: const Text('Submit')
            ),
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          width: double.infinity,
          child: formEl
        ),
      )
    );
  }
}


class FieldItem extends StatelessWidget {
  final Widget child;
  final double top;

  const FieldItem(
    this.child, 
    { 
      super.key,
      this.top = 20
    }
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: top),
      child: child,
    );
  }
}