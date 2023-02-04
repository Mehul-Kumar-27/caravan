import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../auth/auth_exception.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_event.dart';
import '../../auth/bloc/auth_state.dart';
import '../../config/size_config.dart';
import '../../constants/colors.dart';
import '../../dialogs/error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isElevated = false;
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          if (state.exception is UserNotFoundAuthException) {
            await showErrorDialog(
              context,
              "Cannot find a user with the entered credentials!",
            );
          } else if (state.exception is WrongPasswordAuthException) {
            await showErrorDialog(
              context,
              "Wrong Credentials",
            );
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(
              context,
              "Authentication Error",
            );
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.only(top: screenHeight(30)),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: screenWidth(13.2)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenHeight(42),
                    ),
                    Text(
                      "Let's Login",
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth(22.24),
                        fontWeight: FontWeight.w600,
                        color: AppColors.mainColor,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight(6.94),
                    ),
                    Text(
                      "And never miss your medicines",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: screenWidth(11.8),
                        color: AppColors.textColor1,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight(14),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: screenHeight(14),
                        right: screenWidth(13.2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email Address",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: screenWidth(11.8),
                              color: AppColors.textColor,
                            ),
                          ),
                          SizedBox(
                            height: screenHeight(10.41),
                          ),
                          SizedBox(
                            height: screenHeight(50),
                            child: TextField(
                              controller: _email,
                              enableSuggestions: false,
                              autocorrect: false,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintStyle: GoogleFonts.poppins(
                                  color: AppColors.textColor2,
                                ),
                                hintText: 'someone@gmail.com',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(screenHeight(6.94)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight(27.8),
                          ),
                          Text(
                            "Password",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: screenWidth(11.8),
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: screenHeight(10.41),
                          ),
                          SizedBox(
                            height: screenHeight(50),
                            child: TextField(
                              controller: _password,
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: InputDecoration(
                                hintStyle: GoogleFonts.poppins(
                                  color: AppColors.textColor2,
                                ),
                                hintText: '***********',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(screenHeight(6.94)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight(6.94),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  context.read<AuthBloc>().add(
                                        const AuthEventForgotPassword(),
                                      );
                                },
                                child: Text(
                                  style: GoogleFonts.poppins(
                                    color: AppColors.mainColor,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 1.5,
                                    fontSize: screenWidth(10.41),
                                  ),
                                  "Forgot password?",
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenHeight(13.88),
                          ),
                          SizedBox(
                            height: screenWidth(34.7),
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                backgroundColor: AppColors.mainColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      screenHeight(20.86)),
                                ),
                              ),
                              onPressed: () async {
                                final email = _email.text;
                                final password = _password.text;
                                context.read<AuthBloc>().add(
                                      AuthEventLogIn(
                                        email,
                                        password,
                                      ),
                                    );
                              },
                              child: SizedBox(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: screenWidth(9.86),
                                    ),
                                    Text(
                                      "Login",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: screenWidth(12.51),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight(13.88),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                style: GoogleFonts.poppins(
                                  color: AppColors.textColor1,
                                  fontSize: screenWidth(10.42),
                                  fontWeight: FontWeight.w500,
                                ),
                                'Not Registered yet?',
                              ),
                              TextButton(
                                onPressed: () {
                                  context.read<AuthBloc>().add(
                                        const AuthEventShouldRegister(),
                                      );
                                },
                                child: Text(
                                  style: GoogleFonts.poppins(
                                    color: AppColors.mainColor,
                                    fontSize: screenWidth(10.42),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  'Register here!',
                                ),
                              ),
                            ],
                          ),
                        ],
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
