import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/config/routes/route_config.dart';
import 'package:todo/core/auth/bloc/auth_bloc.dart';
import 'package:todo/utils/form_validator.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double layoutWidth = MediaQuery.of(context).size.width;
    double layoutHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMsg)));
          }
        },
        child: Container(
          width: layoutWidth,
          height: layoutHeight,
          child: Form(
            key: _formKey,
            child: Stack(
              children: [
                SizedBox(
                  width: layoutWidth,
                  height: layoutHeight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: layoutWidth > 400 ? 300 : layoutWidth * 0.8,
                        child: TextFormField(
                          controller: _emailController,
                          validator: FormValidator.validateEmail,
                        ),
                      ),
                      SizedBox(
                        width: layoutWidth > 400 ? 300 : layoutWidth * 0.8,
                        child: TextFormField(
                          controller: _passwordController,
                          validator: FormValidator.validatePassword,
                          obscureText: true,
                        ),
                      ),
                      SizedBox(
                        width: layoutWidth > 400 ? 300 : layoutWidth * 0.8,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Forgot password ?'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (state is SigningInState) {
                            return CircularProgressIndicator();
                          } else {
                            return SizedBox(
                              width: layoutWidth > 400 ? 300 : layoutWidth * 0.8,
                              child: TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<AuthBloc>().add(OnSignInBtnClicked(email: _emailController.text, password: _passwordController.text));
                                  }
                                },
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'SIGN IN',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Don't have an account ?"),
                        SizedBox(
                          width: layoutWidth > 400 ? 300 : layoutWidth * 0.8,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, Routes.SIGNUP_SCREEN);
                            },
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'SIGN UP',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
