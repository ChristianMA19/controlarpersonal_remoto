import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';
import '../content/home.dart';
// import 'signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required this.email, required this.password})
      : super(key: key);

  final String email;
  final String password;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0,0,0,0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Check if running on web, then show container
              if (kIsWeb)
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height,
                  margin: const EdgeInsets.only(right: 20),
                  color:Colors.blueGrey,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          "Welcome to form controller",
                          style: TextStyle(
                              fontSize: 42, color: Colors.white),

                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                          "Login with your email and password",
                          style: TextStyle(
                              fontSize: 24, color: Colors.white),
                      ),
                      // You can add any content you want to show here
                    ],
                  ),
                ),
              // Main login form
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Login with email",
                        style: TextStyle(fontSize: kIsWeb ? 42 : 28),
                      ),
                      const SizedBox(
                        height: kIsWeb ? 200 : 100,
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: kIsWeb ? 30 : 20, left: kIsWeb ? 0 : 20),
                        child:TextFormField(
                          key: const Key('TextFormFieldLoginEmail'),
                          controller: _emailController,
                          decoration:
                              const InputDecoration(labelText: 'Email address'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter email";
                            } else if (!value.contains('@')) {
                              return "Enter valid email address";
                            }
                          },
                        ), 
                      ),
                      
                      const SizedBox(
                        height: kIsWeb ? 50 : 20,
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: kIsWeb ? 30 : 20, left: kIsWeb ? 0 : 20),
                        child:TextFormField(
                        key: const Key('TextFormFieldLoginPassword'),
                        controller: _passwordController,
                        decoration:
                            const InputDecoration(labelText: "Password"),
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter password";
                          } else if (value.length < 6) {
                            return "Password should have at least 6 characters";
                          }
                          return null;
                        },
                      ),
                      )
                      ,
                      const SizedBox(
                        height: kIsWeb ? 200 : 50,
                      ),
                      OutlinedButton(
                          key: const Key('ButtonLoginSubmit'),
                          onPressed: () {
                            // this line dismiss the keyboard by taking away the focus of the TextFormField and giving it to an unused
                            FocusScope.of(context).requestFocus(FocusNode());
                            final form = _formKey.currentState;
                            form!.save();
                            if (form.validate()) {
                              if ((_emailController.text == "a@a.com" || _emailController.text == "a@b.com") && _passwordController.text == "123456") {
                                Get.offAll(HomePage(
                                  key: const Key('HomePage'),
                                  loggedEmail: _emailController.text,
                                  loggedPassword: _passwordController.text,
                                ));
                              }
                              else if (widget.email == _emailController.text &&
                                  widget.password == _passwordController.text) {
                                Get.offAll(HomePage(
                                  key: const Key('HomePage'),
                                  loggedEmail: _emailController.text,
                                  loggedPassword: _passwordController.text,
                                ));
                              } else {
                                const snackBar = SnackBar(
                                  content: Text('User or password nok'),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                            } else {
                              const snackBar = SnackBar(
                                content: Text('Validation nok'),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                          },
                          child: const Text("Submit")),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}