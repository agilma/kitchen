import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kitchen/core/api/frappe_thunder_authenticator/auth.dart'
    as frappeLogin;
import 'package:kitchen/core/api/frappe_thunder_authenticator/user_detail.dart'
    as frappeUserDetail;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  String _errorMessage = '';

  Future<void> _handleLogin() async {
    final username = _phoneController.text;
    final password = _passwordController.text;
    final loginRequest = frappeLogin.loginRequest(username: username, password: password);

    try {
      final response = await frappeLogin.login(loginRequest);
      if (response['message'] == 'Logged In') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('username', username);
        prefs.setString('password', password);
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        setState(() {
          _errorMessage = 'Invalid username or password';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Invalid username or password';
      });
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                'assets/image/logo-kontena.png',
                height: 80,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'House Keeping',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'OpenSans',
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(32.0),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 4),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Masukkan Username dan Password anda',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'OpenSans',
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Nomor Handphone',
                      labelStyle: TextStyle(fontFamily: 'OpenSans'),
                      errorText: _errorMessage.isEmpty ? null : _errorMessage,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password Anda',
                      labelStyle: TextStyle(fontFamily: 'OpenSans'),
                      errorText: _errorMessage.isEmpty ? null : _errorMessage,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    obscureText: !_isPasswordVisible,
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF27ae60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: _handleLogin,
                      child: Text('Login',
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              color: Colors.white,
                              fontSize: 14)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
     ),
);
}
}
