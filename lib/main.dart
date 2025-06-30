import 'package:flutter/material.dart';
import 'package:fv_chat/common/styles/app_input_styles.dart';
import 'package:fv_chat/common/styles/app_text_styles.dart';
import 'package:fv_chat/common/widgets/cyrcle_button.dart';
import 'package:fv_chat/common/widgets/disabled_main_button.dart';
import 'package:fv_chat/common/widgets/main_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            TextField(
              decoration: AppInputStyles.defaultInput(hintText: 'Email'),
              style: AppTextStyles.body3,
            ),
            TextField(
              decoration: AppInputStyles.errorInput(
                  hintText: 'Password', errorText: 'Incorrect password'),
              style: AppTextStyles.body3,
            ),
            MainButton(
              text: 'Log in',
              onPressed: () {},
            ),
            DisabledMainButton(
              text: 'Log in',
              onPressed: () {},
            ),
            CircleButton(
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
