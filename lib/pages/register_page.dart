import 'package:flutter/material.dart';
import 'package:prak_tpm_api_123210102/services/shared_preferences_service.dart';

class RegisterPage extends StatefulWidget {

  final String? message;

  const RegisterPage({Key? key, this.message}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

  class _RegisterPageState extends State<RegisterPage> {
  bool _showPassword = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('REGISTER PAGE')),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(6.0),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.only(
                    left: 30.0, top: 50.0, right: 3.0, bottom: 5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Email",
                      style: const TextStyle(fontSize: 14),
                    ),
                    _usernameField(),
                    const Text(
                      "Password",
                      style: const TextStyle(fontSize: 14),
                    ),
                    _passwordField(),
                    const Text(
                      "Birthday",
                      style: const TextStyle(fontSize: 14),
                    ),
                    _birthdayField(),
                    _loginText(),
                    _registerButton(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _usernameField() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: TextFormField(
        controller: emailController,
        autofocus: true,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.green, width: 2.5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: 'Email',
          prefixIcon: const Icon(
            Icons.account_box_outlined,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _passwordField() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: TextFormField(
        controller: passwordController,
        obscureText: !_showPassword,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Password is required';
          }
          if (value.length < 8) {
            return 'Password must be at least 8 characters';
          }
          return null;
        },
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.green, width: 2.5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: 'Password',
          prefixIcon: const Icon(
            Icons.lock_outline,
            color: Colors.black,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _showPassword ? Icons.visibility : Icons.visibility_off,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                _showPassword = !_showPassword;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _birthdayField() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: TextFormField(
        controller: birthdayController,
        autofocus: true,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.green, width: 2.5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: 'Birthday',
          prefixIcon: const Icon(
            Icons.cake,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _loginText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Belum mendaftar, lakukan ',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        SizedBox(height: 10.0),
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/');
          },
          child: Text(
            'Login',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Widget _registerButton() {
    return Center(
      child: Container(
        width: 200,
        height: 45,
        child: TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.green),
            child: const Text(
              "Register",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            onPressed: () {
              _register(context);
            }
        ),
      ),
    );
  }

  void _register(BuildContext context) async {
    final email = emailController.text;
    final password = passwordController.text;
    final birthday = birthdayController.text;

    await SharedPreferencesService.saveUserCredentials(email, password);
    await SharedPreferencesService.saveUserBirthday(birthday);

    Navigator.pushReplacementNamed(context, '/');
  }

}
