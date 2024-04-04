import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'task_screen.dart';
import 'package:todoapp_flutter/components/auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:todoapp_flutter/services/localization.dart';

class Register extends StatefulWidget {
  final Locale locale;
  const Register({super.key, required this.locale});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  late String email;
  late String password;
  late String confirmPassword;

  bool showSpinner = false;

  Future<void> _signInWithGoogle(Locale locale) async {
    try {
      await AuthService().signInWithGoogle();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => TaskScreen(locale: widget.locale)),
      );
    } catch (e) {
      print("Error signing in with Google: $e");
    }
  }

  Future<void> _signInWithFacebook(Locale locale) async {
    try {
      await AuthService().signInWithFacebook();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => TaskScreen(locale: widget.locale)),
      );
    } catch (e) {
      print("Error signing in with Facebook: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = Localization(widget.locale);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                // Logo
                const Hero(
                  tag: 'logo',
                  child: CircleAvatar(
                    backgroundColor: Colors.lightBlueAccent,
                    radius: 30,
                    child: Icon(
                      Icons.check,
                      size: 55,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Welcome message
                SizedBox(
                  width: 250.0,
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'Agne',
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText('Welcome to our community!',
                            textStyle: TextStyle(color: Colors.grey[700]),
                            textAlign: TextAlign.center)
                      ],
                      onTap: () {
                        print("Tap Event");
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                // Email input
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: 'Email',
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontFamily: "ZenOldMincho",
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                // Password input
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    controller: passwordController,
                    onChanged: (value) {
                      password = value;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: localization.password!,
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontFamily: "ZenOldMincho",
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                // Confirm Password input
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    controller: confirmPasswordController,
                    onChanged: (value) {
                      confirmPassword = value;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: localization.confirmPassword!,
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontFamily: "ZenOldMincho",
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                // Register button
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    if (password != confirmPassword) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              localization.passwordsDoNotMatch!,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  localization.retry!,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "ZenOldMincho",
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        if (newUser != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TaskScreen(locale: widget.locale)),
                          );
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'email-already-in-use') {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  localization.error!,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                content: Text(
                                  localization.theAccountAlreadyExists!,
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      "OK",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "ZenOldMincho",
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      } catch (e) {
                        print(e);
                      }
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  },
                  child: Flexible(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          localization.register!,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "ZenOldMincho",
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          localization.orContinueWith!,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontFamily: "ZenOldMincho",
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Google & Facebook buttons
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SquareTile(
                        onTap: () => _signInWithGoogle(widget.locale),
                        imagePath: 'assets/images/google.png',
                      ),
                      const SizedBox(width: 15),
                      SquareTile(
                        onTap: () => _signInWithFacebook(widget.locale),
                        imagePath: 'assets/images/facebook.png',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Already have an account? Login now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      localization.already!,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontFamily: "ZenOldMincho",
                      ),
                    ),
                    const SizedBox(width: 2),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        localization.loginNow!,
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontFamily: "ZenOldMincho",
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SquareTile extends StatelessWidget {
  final String imagePath;
  final Function()? onTap;
  const SquareTile({
    Key? key,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[200],
        ),
        child: Image.asset(
          imagePath,
          height: 35,
        ),
      ),
    );
  }
}
