import 'package:flutter/material.dart';
import 'package:fv_chat/ui/styles/app_input_styles.dart';
import 'package:fv_chat/ui/styles/app_text_styles.dart';
import 'package:fv_chat/ui/widgets/cyrcle_button.dart';
import 'package:fv_chat/ui/widgets/main_button.dart';

class UiShowcase extends StatefulWidget {
  const UiShowcase({super.key});

  @override
  State<UiShowcase> createState() => _UiShowcaseState();
}

class _UiShowcaseState extends State<UiShowcase> {
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
                hintText: 'Password',
                errorText: 'Incorrect password',
              ),
              style: AppTextStyles.body3,
            ),
            MainButton(
              text: 'Log in',
              onPressed: () {},
            ),
            const MainButton(
              text: 'Log in',
              onPressed: null,
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
