import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:promoter/core/constant/constant.dart';
import 'package:promoter/core/constants.dart';
import 'package:promoter/core/utils/app_router.dart';
import 'package:http/http.dart' as http;
import 'package:promoter/core/utils/cash/cache_helper.dart';
import 'package:promoter/core/utils/styles.dart';

class LoginHomePage extends StatefulWidget {
  @override
  _LoginHomePageState createState() => _LoginHomePageState();
}

class _LoginHomePageState extends State<LoginHomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage; // Add this line
  String? _emailError;
  String? _passwordError;
  bool _isPasswordVisible = false;
  String _managerName = '';
  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      final success = await _performLogin();

      if (success) {
        print("tm");
        print(_managerName);
        GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
      } else {
        // Handle login failure (show error message)
      }
    }
  }

  Future<bool> _performLogin() async {
    var dio = Dio();
    
    final url = Uri.parse('$baseUrl/promoters/login');

    final headers = {
      'Content-Type': 'application/json',
    };

    final body = '''{
    "user": "${_emailController.text}",
    "password": "${_passwordController.text}"
  }''';
    try {
      // var response2 = await dio.post(path)
      final response = await http.post(url, headers: headers, body: body);
      print("status code ${response.statusCode}");
      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        print("kkkkkkk");
        final token = parseTokenFromResponse(response.body);
        final parsedJson = json.decode(response.body);
        final promoterDate = parsedJson['data'];
        setState(() {});
        await CasheHelper.setData(key: Constants.ktoken, value: token);
        await CasheHelper.setData(
            key: Constants.kPromoterName, value: promoterDate['name_en']);
        await CasheHelper.setData(
            key: Constants.kPromoterID, value: promoterDate['id']);

        return true;
      } else {
        final messageApi = jsonDecode(response.body);
        setState(() {
          // _errorMessage = 'Invalid email or password';// Set error message

          if (messageApi['data'] == "User Not Found") {
            _errorMessage = "User Not Found";
          } else {
            _errorMessage = "Invalid password";
          }
        });
        print('Request failed with status: ${response.statusCode}');
        print('Error message: ${response.reasonPhrase}');
        return false;
      }
    } catch (e) {
      print("error un handle $e");
      setState(() {
        _isLoading = false;
      });
      return false;
    }
  }

  // Future<void> _storeToken(String token) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString('auth_token', token);
  // }

  String parseTokenFromResponse(String responseBody) {
    // Parse the JSON response and extract the token
    final parsedJson = json.decode(responseBody);
    final token = parsedJson['token'];
    return token;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: AppColor.hBackgroundColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInDown(
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                  ),
                  const SizedBox(height: 10),
                  FadeInDown(
                    child: const Text(
                      "Welcome Promoter",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          _buildTextField(
                              "Email", false, _emailController, _emailError),
                          const SizedBox(height: 20),
                          _buildPasswordField(
                              _passwordController, _passwordError),
                          const SizedBox(height: 20),
                          _buildLoginButton(context),
                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, bool isPassword,
      TextEditingController controller, String? errorText) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey)),
      ),
      child: TextFormField(
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        controller: controller,
        obscureText: isPassword && !_isPasswordVisible,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
          errorText: errorText,
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter a valid $hintText';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordField(
      TextEditingController controller, String? errorText) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey)),
      ),
      child: TextFormField(
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        controller: controller,
        obscureText: !_isPasswordVisible,
        decoration: InputDecoration(
          hintText: "Password",
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
          errorText: errorText,
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
            child: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter a valid password';
          } else if (value.length < 1) {
            return 'password too short ';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    if (_isLoading) {
      return Center(
        child: SpinKitSpinningLines(
          size: 35,
          color: AppColor.hBackgroundColor,
        ),
      ); // Show loading indicator
    } else {
      return FadeInDown(
        child: Column(
          children: [
            if (_errorMessage != null) // Display error message if available
              Text(
                _errorMessage!,
                style: Styles.textStyle18
                    .copyWith(color: Colors.red.withOpacity(0.5)),
              ),
            SizedBox(
              height: deafultpadding * 2,
            ),
            GestureDetector(
              onTap: _login,
              child: Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: AppColor.kBlueLightColor,
                ),
                child: const Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
