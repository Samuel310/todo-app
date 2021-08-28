import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/auth/bloc/auth_bloc.dart';
import 'package:todo/utils/form_validator.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
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
          if (state is ErrorWhileRegisteringState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMsg)));
          } else if (state is AuthInitial) {
            Navigator.pop(context);
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
                          controller: _nameController,
                          validator: FormValidator.validateName,
                        ),
                      ),
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
                      SizedBox(height: 20),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (state is RegisteringState) {
                            return CircularProgressIndicator();
                          } else {
                            return SizedBox(
                              width: layoutWidth > 400 ? 300 : layoutWidth * 0.8,
                              child: TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<AuthBloc>().add(
                                          OnRegisterBtnClicked(
                                            email: _emailController.text,
                                            password: _passwordController.text,
                                            name: _nameController.text,
                                          ),
                                        );
                                  }
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
                        Text("Already have an account ?"),
                        SizedBox(
                          width: layoutWidth > 400 ? 300 : layoutWidth * 0.8,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
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
