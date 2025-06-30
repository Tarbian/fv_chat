import 'package:flutter/material.dart';
import 'package:fv_chat/ui_kit/app_button_styles.dart';
import 'package:fv_chat/ui_kit/app_input_styles.dart';

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
              style: AppInputStyles.inputTextStyle,
            ),
            TextField(
              decoration: AppInputStyles.errorInput(
                  hintText: 'Password', errorText: 'Incorrect password'),
              style: AppInputStyles.inputTextStyle,
            ),
            // Через готові віджети
            AppButtonStyles.mainButton(
              text: 'Log in',
              onPressed: () {},
            ),
            AppButtonStyles.offMainButton(
              text: 'Log in',
              onPressed: () {},
            ),
            AppButtonStyles.circle(
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
