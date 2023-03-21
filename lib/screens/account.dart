// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quantumapp/Auth/fauth.dart';
import 'package:quantumapp/screens/homepage.dart';
import 'package:quantumapp/screens/loading.dart';

class Account extends StatefulWidget {
  const Account({Key key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final emc = TextEditingController();
  final passc = TextEditingController();
  final namec = TextEditingController();
  final phnumc = TextEditingController();
  bool loading = false;
  Fauth fauth = Fauth();
  String email = "", name = "", password;
  int phnumber;
  GlobalKey<FormState> formkey = GlobalKey();
  bool login = false;
  AppBar appbar = AppBar(
    backgroundColor: Colors.red,
    title: RichText(
      text: const TextSpan(children: [
        TextSpan(
            text: "Social",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
        TextSpan(text: "X", style: TextStyle(fontSize: 30))
      ]),
    ),
  );
  BoxDecoration controlDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)));
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool ckvalue = false;
    Stack login_signup_con = Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(1.0),
          padding: const EdgeInsets.all(3.0),
          decoration:
              controlDecoration.copyWith(border: Border.all(color: Colors.red)),
          height: 70,
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  login = true;
                  emc.clear();
                  passc.clear();
                });
              },
              child: Container(
                child: Center(
                    child: Text(
                  "LOGIN",
                  style: TextStyle(color: login ? Colors.white : Colors.grey),
                )),
                decoration: controlDecoration.copyWith(
                    color: login ? Colors.red : Colors.white),
                width: width / 2,
                height: 70,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  login = false;
                });
              },
              child: Container(
                child: Center(
                  child: Text("SIGN UP",
                      style: TextStyle(
                        color: login ? Colors.grey : Colors.white,
                      )),
                ),
                decoration: controlDecoration.copyWith(
                  color: login ? Colors.white : Colors.red,
                ),
                width: width / 2,
                height: 70,
              ),
            ),
          ],
        )
      ],
    );
    Container login_container = Container(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8.0, left: 30),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "SigIn into your \n Account",
                  style: TextStyle(
                      fontSize: 23,
                      color: Colors.red,
                      fontWeight: FontWeight.w700),
                )),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0, left: 30, right: 30),
            child: TextFormField(
              validator: (val) {
                return val.isEmpty ? "please enter the email" : null;
              },
              controller: emc,
              decoration: const InputDecoration(
                hintText: "johndoe@gmail.com",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                label: Text(
                  "Email",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                suffixIcon: Icon(
                  Icons.mail_rounded,
                  color: Colors.red,
                ),
                //    suffixIconColor: Colors.red
              ),
              onChanged: (val) {
                setState(() {
                  email = val;
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0, left: 30, right: 30),
            child: TextFormField(
              validator: (val) {
                return val.length < 8 ? "please enter a strong password" : null;
              },
              controller: passc,
              decoration: const InputDecoration(
                focusColor: Colors.black,
                hintText: "Password",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                label: Text(
                  "Password",
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                suffixIcon: Icon(
                  Icons.lock,
                  color: Colors.red,
                ),
                //    suffixIconColor: Colors.red
              ),
              onChanged: (val) {
                setState(() {
                  password = val;
                });
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8.0, left: 30, right: 30),
            child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  "Forgot password ?",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.red,
                  ),
                )),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text("Login with"),
          ),
          Row(
            children: [
              Spacer(),
              Container(
                height: 40,
                width: 40,
                color: Colors.green,
                child: Image.asset(
                  "assets/Icons/google_icon.png",
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              Container(
                height: 40,
                width: 40,
                color: Colors.green,
                child: Image.asset(
                  "assets/Icons/facebook_icon.png",
                  fit: BoxFit.fill,
                ),
              ),
              Spacer(),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                login = false;
              });
            },
            child: RichText(
              text: const TextSpan(children: [
                TextSpan(
                    text: "Don't have an Account ?",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w300)),
                TextSpan(
                    text: "Register Now", style: TextStyle(color: Colors.red))
              ]),
            ),
          ),
        ],
      ),
      height: 520,
      //  color: Colors.white,
      decoration: controlDecoration.copyWith(
          color: Colors.white, borderRadius: BorderRadius.circular(30)),
    );
    Container sign_up_container = Container(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8.0, left: 30),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Create an \nAccount",
                  style: TextStyle(
                      fontSize: 23,
                      color: Colors.red,
                      fontWeight: FontWeight.w700),
                )),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0, left: 30, right: 30),
            child: TextFormField(
              controller: namec,
              validator: (val) {
                return val.isEmpty ? "Please specify Your name" : null;
              },
              decoration: const InputDecoration(
                hintText: "john doe",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                label: Text(
                  "Name",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                suffixIcon: Icon(
                  Icons.person,
                  color: Colors.red,
                ),
                //    suffixIconColor: Colors.red
              ),
              onChanged: (val) {
                setState(() {
                  name = val;
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0, left: 30, right: 30),
            child: TextFormField(
              controller: emc,
              validator: (val) {
                return val.isEmpty ? "please enter your email" : null;
              },
              decoration: const InputDecoration(
                focusColor: Colors.black,
                hintText: "johndoe@gmail.com",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                label: Text(
                  "Email",
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                suffixIcon: Icon(
                  Icons.email,
                  color: Colors.red,
                ),
                //    suffixIconColor: Colors.red
              ),
              onChanged: (val) {
                setState(() {
                  email = val;
                });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 30,
              ),
              Text(
                "Contact no",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 30,
              ),
              Container(
                height: 30,
                width: 40,
                child: Image.asset(
                  "assets/Icons/indian_flag.png",
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(width: 10),
              Text("IN"),
              SizedBox(width: 10),
              Text("+91"),
              SizedBox(
                width: 5,
              ),
              Icon(Icons.arrow_drop_down),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 180,
                child: TextFormField(
                  controller: phnumc,
                  validator: (val) {
                    return val.length < 10
                        ? "please enter a valid mobile number"
                        : null;
                  },
                  keyboardType: TextInputType.number,
                  onChanged: (val) {
                    setState(() {
                      phnumber = int.parse(val);
                    });
                  },
                  decoration: InputDecoration(
                      hintText: "9876543210",
                      suffixIcon: Icon(
                        Icons.phone,
                        color: Colors.red,
                      )),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 30,
              ),
              Text(
                "Password",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 30,
              ),
              Container(
                width: 305,
                child: TextFormField(
                  controller: passc,
                  validator: (val) {
                    return val.length < 8
                        ? "please enter an valid password"
                        : null;
                  },
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "********",
                      suffixIcon: Icon(
                        Icons.lock,
                        color: Colors.red,
                      )),
                ),
              )
            ],
          ),
          Row(
            children: [
              Spacer(),
              Checkbox(
                  value: ckvalue,
                  onChanged: (val) {
                    setState(() {
                      ckvalue = !ckvalue;
                    });
                  }),
              Text("I agree the terms and conditions"),
              Spacer(),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                login = true;
              });
            },
            child: RichText(
              text: const TextSpan(children: [
                TextSpan(
                    text: "Already have an Account ?",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w300)),
                TextSpan(
                    text: "Sign In",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold))
              ]),
            ),
          ),
        ],
      ),
      height: 600,
      //  color: Colors.white,
      decoration: controlDecoration.copyWith(
          color: Colors.white, borderRadius: BorderRadius.circular(30)),
    );
    return loading
        ? Spinkit()
        : Scaffold(
            appBar: appbar,
            body: Container(
              height: height,
              color: Colors.grey,
              child: Form(
                key: formkey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    login_signup_con,
                    const SizedBox(
                      height: 40,
                    ),
                    login ? login_container : sign_up_container,
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: login
                          ? () async {
                              if (formkey.currentState.validate()) {
                                print(email);
                                print(password);
                                setState(() {
                                  loading = true;
                                });
                                dynamic result =
                                    await fauth.Loginwithemailandpassword(
                                        email, password);
                                setState(() {
                                  loading = false;
                                });
                                if (FirebaseAuth.instance.currentUser?.uid !=
                                    null) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
                                }
                              }
                            }
                          : () async {
                              if (formkey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result =
                                    await fauth.Signupwithemailandpassword(
                                        email, password);
                                setState(() {
                                  loading = false;
                                });
                                if (FirebaseAuth.instance.currentUser?.uid !=
                                    null) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
                                }
                              }
                            },
                      child: Container(
                        child: Center(
                            child: Text(
                          login ? "LOGIN" : "Sign In",
                          style: TextStyle(color: Colors.white),
                        )),
                        height: 70,
                        decoration: controlDecoration.copyWith(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
