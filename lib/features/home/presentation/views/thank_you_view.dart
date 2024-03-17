import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';

class ThankYouView extends StatelessWidget {
  const ThankYouView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          decoration: ShapeDecoration(
            //color: const Color(0xFFEDEDED),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.only(top: 50 + 16, left: 22, right: 22),
            child: Column(
              children: [
                Text(
                  'Thank you!',
                  textAlign: TextAlign.center,
                  style: Styles.textStyle30,
                ),
                Text(
                  'Your transaction was successful',
                  textAlign: TextAlign.center,
                  style: Styles.textStyle20,
                ),
                SizedBox(
                  height: 42,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
