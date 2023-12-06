import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_login/constants.dart';
import 'package:flutter_login/reusable_widgets/reusable_widgets.dart';
import 'package:flutter_login/screens/signup_/components/background.dart';
import 'package:flutter_login/screens/login_/login_screen.dart';
import 'package:flutter_login/screens/main_screen/input_screen.dart';
// import 'package:flutter_login/screens/signup_/signup_screen.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formfield = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final PassController = TextEditingController();
  bool passtoggle = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Form(
          key: _formfield,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    " Create an Account",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.italic,
                        // color: Colors.lightGreen,
                        fontSize: 20),
                  ),
                ],
              ),

              SizedBox(
                height: size.height * 0.03,
              ),
              // Image.asset(
              //   "images/Logo.png",
              //   width: size.width * 0.35,
              // ),
              // SizedBox(
              //   height: size.height * 0.03,
              // ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                    color: Color(0xFFE0F2F1),
                    borderRadius: BorderRadius.circular(29)),
                child: TextFormField(
                  cursorColor: kPrimaryColor,
                  // controller: PassController,
                  // obscureText: passtoggle,
                  decoration: const InputDecoration(
                    hintText: "Name",
                    icon: Icon(
                      Icons.person,
                      color: kPrimaryColor,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.circular(29),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: kPrimaryColor,
                  controller: emailController,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: kPrimaryColor,
                    ),
                    hintText: "Email",
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email can't be empty";
                    } else if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return "Enter a valid email address";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                    color: kPrimaryLightColor,
                    borderRadius: BorderRadius.circular(29)),
                child: TextFormField(
                  controller: PassController,
                  obscureText: passtoggle,
                  decoration: InputDecoration(
                    hintText: "Password",
                    icon: Icon(
                      Icons.lock,
                      color: kPrimaryColor,
                    ),
                    suffix: InkWell(
                      onTap: () {
                        setState(
                          () {
                            passtoggle = !passtoggle;
                          },
                        );
                      },
                      child: Icon(
                          passtoggle ? Icons.visibility : Icons.visibility_off),
                    ),
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password can't be empty";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                    color: kPrimaryLightColor,
                    borderRadius: BorderRadius.circular(29)),
                child: TextFormField(
                    // controller: PassController,
                    obscureText: passtoggle,
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                      icon: const Icon(
                        Icons.lock,
                        color: kPrimaryColor,
                      ),
                      suffix: InkWell(
                        onTap: () {
                          setState(() {
                            passtoggle = !passtoggle;
                          });
                        },
                        child: Icon(passtoggle
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      // suffix: Icon(
                      //   Icons.visibility,
                      //   color: kPrimaryColor,
                      // ),
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password can't be empty";
                      }
                      return null;
                    }),
              ),

              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                      backgroundColor: kPrimaryColor,
                      foregroundColor: Colors.white,
                    ),

                    onPressed: ()
                    {
                      if (_formfield.currentState!.validate())
                      {
                        // Email is valid, perform login logic
                        FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: emailController.text, password: PassController.text).then((value)
                            {
                              showDialog(context: context, builder: (context){
                                return Container(
                                  child: AlertDialog(
                                    title: Text("Account Created Successfullly"),
                                    actions: [
                                      TextButton(onPressed: () {
                                        Navigator.pop(context);
                                      }, child: Text("PROCEED"))
                                    ],
                                  ),
                                );
                              });
                              print("New Account Created");

                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                            }).onError((error, stackTrace)
                        {
                          showDialog(context: context, builder: (context){
                            return Container(
                              child: AlertDialog(
                                title: Text("Error"),
                                actions: [
                                  TextButton(onPressed: () {
                                    Navigator.pop(context);
                                  }, child: Text("OK"))
                                ],
                              ),
                            );
                          });
                              print("Error ${error.toString()}");
                        });
                        print("Success");
                      }
                    },
                    child: const Text(
                      "SIGN UP",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Already have an Account ? ",
                    style: TextStyle(color: kPrimaryColor),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginScreen();
                            },
                          ),
                        );
                      },
                      child: const Text(
                        "LOGIN ",
                        style: TextStyle(
                            color: kPrimaryColor, fontWeight: FontWeight.bold),
                      )),
                ],
              ),
              Container(
                width: size.width * 0.8,
                child: const Row(
                  children: <Widget>[
                    Expanded(
                      child: Divider(
                        color: Color(0XFFD9D9D9),
                        height: 1.5,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "OR",
                        style: TextStyle(
                            color: kPrimaryColor, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Color(0XFFD9D9D9),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 2, color: kPrimaryLightColor),
                          shape: BoxShape.circle),
                      child: Image.asset(
                        "images/Logo.png",
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 2, color: kPrimaryLightColor),
                          shape: BoxShape.circle),
                      child: Image.asset(
                        "images/Logo.png",
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 2, color: kPrimaryLightColor),
                          shape: BoxShape.circle),
                      child: Image.asset(
                        "images/Logo.png",
                        height: 20,
                        width: 20,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
