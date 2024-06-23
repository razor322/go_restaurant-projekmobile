import 'package:flutter/material.dart';
import 'package:go_restoran/const.dart';
import 'package:go_restoran/model/auth/model_otp.dart';
import 'package:go_restoran/model/auth/model_register.dart';
import 'package:go_restoran/screen/auth/login_page.dart';
import 'package:go_restoran/screen/auth/verification_page.dart';
import 'package:http/http.dart' as http;

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _obscurepass = true;
  bool isLoading = false;

  Future<ModelRegister?> registerAccount() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        http.Response res = await http.post(Uri.parse('${url}register.php'),
            body: {
              "username": _username.text,
              "email": _email.text,
              "password": _password.text
            });
        final data = modelRegisterFromJson(res.body);
        if (data.value == 1) {
          otpAccount(_email.text);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => VerificationPage(_email.text)),
              (route) => false);
          if (mounted) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(data.message)));
          }
        } else if (data.value == 2) {
          if (mounted) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(data.message)));
          }
        }
      } catch (e) {
        print(e.toString());
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.toString())));
        }
      } finally {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    }
  }

  Future<ModelOtp?> otpAccount(String emailuser) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        http.Response res = await http
            .post(Uri.parse('${url}otp_send.php'), body: {"email": emailuser});
        final data = modelOtpFromJson(res.body);
        if (data.value == 1) {
          if (mounted) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(data.message)));
          }
        } else if (data.value == 2) {
          if (mounted) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(data.message)));
          }
        }
      } catch (e) {
        print(e.toString());
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.toString())));
        }
      } finally {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        width: 300,
                        height: 90,
                        child: Image.asset(
                          'assets/logo2.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    Text(
                      "Username",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _username,
                      decoration: InputDecoration(
                        hintText: "Create your username",
                        hintStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w400),
                        fillColor: Colors.grey.withOpacity(0.2),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              width: 1,
                            )),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Email",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _email,
                      decoration: InputDecoration(
                        hintText: "Enter your email ",
                        hintStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w400),
                        fillColor: Colors.grey.withOpacity(0.2),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              width: 1,
                            )),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Password",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _password,
                      decoration: InputDecoration(
                        hintText: "Create your password",
                        hintStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w400),
                        fillColor: Colors.grey.withOpacity(0.2),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              width: 1,
                            )),
                        suffixIcon: IconButton(
                          icon: Icon(_obscurepass
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _obscurepass = !_obscurepass;
                            });
                          },
                        ),
                      ),
                      obscureText: _obscurepass,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "By signing up, you accept our Terms and Conditions",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Container(
                        width: 350,
                        height: 60,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amberAccent,
                            ),
                            onPressed: () {
                              if (_formKey.currentState?.validate() == true) {
                                registerAccount();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Silahkan isi data terlebih dahulu")));
                              }
                            },
                            child: isLoading
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text(
                                    "Create Account",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ))),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(child: Divider(thickness: 1)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('Or'),
                        ),
                        Expanded(child: Divider(thickness: 1)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Loginpage()),
                              (route) => false);
                        },
                        child: const Text('Login',
                            style: TextStyle(color: Colors.black)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
