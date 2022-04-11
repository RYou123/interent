import 'package:flutter/material.dart';

class UnorderedList extends StatelessWidget {
  UnorderedList(this.texts);
  final List<String> texts;

  @override
  Widget build(BuildContext context) {
    var widgetList = <Widget>[];
    for (var text in texts) {
      // Add list item
      widgetList.add(UnorderedListItem(text));
      // Add space between items
      widgetList.add(SizedBox(height: 5.0));
    }

    return Column(
      children: widgetList,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}

class UnorderedListItem extends StatelessWidget {
  UnorderedListItem(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text("• ", style: TextStyle(
                color: Colors.grey,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold),),
        Text(text, style: TextStyle(
                color: Colors.grey,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold),),
      ],
    );
  }
}
