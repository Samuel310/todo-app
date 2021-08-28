import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/theme_bloc.dart';
import 'package:todo/core/auth/bloc/auth_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: Container(
        child: ListView(
          children: [
            ListTile(
              onTap: () {
                context.read<AuthBloc>().add(OnSignOutBtnClicked());
                Navigator.pop(context);
              },
              title: Text(
                'Logout',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return ListTile(
                  onTap: () {
                    context.read<ThemeBloc>().add(OnChangeThemeBtnClicked());
                  },
                  title: Text(
                    'Dark Theme',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Switch(
                    value: state.isDark,
                    onChanged: (value) {
                      context.read<ThemeBloc>().add(OnChangeThemeBtnClicked());
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
