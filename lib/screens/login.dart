import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp_flutter/screens/task_screen.dart';
import 'register.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:todoapp_flutter/components/auth.dart';
import 'package:todoapp_flutter/services/localization.dart';

class Login extends StatefulWidget {
  final Locale locale;
  const Login({super.key, required this.locale});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  late String email;

  late String password;

  bool showSpinner = false;
  Future<void> _signInWithGoogle(Locale locale) async {
    try {
      await AuthService().signInWithGoogle();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TaskScreen(locale: locale)),
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
        MaterialPageRoute(builder: (context) => TaskScreen(locale: locale)),
      );
    } catch (e) {
      print("Error signing in with Facebook: $e");
    }
  }

  Future<void> _forgotPassword() async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      // Show a success message or navigate to a screen to inform the user about the password reset email sent.
      print("Password reset email sent successfully");

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Password Reset Email Sent',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            content: Text(
              'A password reset email has been sent to $email. Please check your inbox.',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'OK',
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
    } catch (e) {
      print("Error sending password reset email: $e");
      // Handle any errors, e.g., invalid email, user not found, etc.
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

                // logo
                Hero(
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

                SizedBox(
                  width: 250.0,
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'Agne',
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText('You need to login first!',
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

                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => {
                          _forgotPassword(),
                        },
                        child: Text(
                          localization.forgotPassword!,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontFamily: "ZenOldMincho",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                // sign in button
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TaskScreen(locale: widget.locale)),
                        );
                        setState(() {
                          showSpinner = false;
                        });
                      }
                    } catch (e) {
                      setState(() {
                        showSpinner = false;
                      });
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              localization.userNotExistTitle!,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            content: Text(
                              localization.userNotExistContent!,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            actions: [
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
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        localization.login!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "ZenOldMincho",
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // or continue with
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

                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // google button
                      SquareTile(
                          onTap: () async {
                            await _signInWithGoogle(widget.locale);
                          },
                          imagePath: 'assets/images/google.png'),

                      const SizedBox(width: 15),

                      // facebook button
                      SquareTile(
                          onTap: () async {
                            await _signInWithFacebook(widget.locale);
                          },
                          imagePath: 'assets/images/facebook.png')
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      localization.notAMember!,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontFamily: "ZenOldMincho",
                      ),
                    ),
                    const SizedBox(width: 2),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Register(locale: widget.locale)),
                        );
                      },
                      child: Text(
                        localization.registerNow!,
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
