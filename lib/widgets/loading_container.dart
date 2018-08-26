import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: buildContainer(),
          subtitle: buildContainer(),
        ),
        Divider(height: 8.0, color: Colors.purple,)
      ],
    );
  }

  Widget buildContainer() {
    return Container(
      color: Colors.purpleAccent.shade100,
      height: 24.0,
      width: 150.0,
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
    );
  }
}
