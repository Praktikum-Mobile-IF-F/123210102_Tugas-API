import 'package:flutter/material.dart';
import 'package:prak_tpm_api_123210102/services/shared_preferences_service.dart';

class LoginPage extends StatefulWidget {
  final String? message;

  const LoginPage({Key? key, this.message}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  String? message;
  final String validationUser = 'rafaelsantosa75@gmail.com';
  final String validationPassword = '123210102';

  bool _showPassword = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('LOGIN PAGE')),
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
                    _registerText(),
                    _loginButton(),
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
        controller: userController,
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

  Widget _loginButton() {
    return Center(
      child: Container(
        width: 200,
        height: 45,
        child: TextButton(
          style: TextButton.styleFrom(backgroundColor: Colors.green),
          child: const Text(
            "Login",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          onPressed: () {
            _login(context);
            }
        ),
      ),
    );
  }

  Widget _registerText() {
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
            Navigator.pushReplacementNamed(context, '/register');
          },
          child: Text(
            'Register',
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


  void _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      String users = userController.text;
      String pass = passwordController.text;
      String text = "";
      final userData = await SharedPreferencesService.getUserCredentials();
      userData['birthday'] = await SharedPreferencesService.getUserBirthday();

      if (userData['email'] == users || userData['password'] == pass) {
        Navigator.pushNamed(context, '/home', arguments: userData);
        text = "Login Success";
      } else {
        text = "Login Failed, your username or password is wrong";
      }

      SnackBar snackBar = SnackBar(
        content: Text(text),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

}
