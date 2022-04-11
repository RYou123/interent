import 'dart:ui';

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:window_location_href/window_location_href.dart';

final String? url = getHref();
Uri uri = new Uri.dataFromString(url!);

class BookingInfo extends StatelessWidget {
  String? myurl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          actions: [],
          leading: Transform.scale(
              scale: 3,
              child: IconButton(
                onPressed: _launchURL,
                icon: Image.asset('assets/logo.jpg'),
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              )),
        ),
        body: ElevatedButton(
          child: Text("Return"),
          onPressed: _launchURL,
        ));
  }
}

_launchURL() async {
  const url = 'https://interent.gr/';
  if (await canLaunch(url)) {
    await launch(url, webOnlyWindowName: '_self');
  } else {
    throw 'Could not launch $url';
  }
}
