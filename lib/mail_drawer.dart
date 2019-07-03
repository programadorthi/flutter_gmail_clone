import 'package:flutter/material.dart';

class MailDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Text(
              'Mail',
              style: Theme.of(context).textTheme.title.copyWith(
                    color: Colors.redAccent,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
