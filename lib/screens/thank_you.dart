import 'dart:ui';

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:window_location_href/window_location_href.dart';

final String? url = getHref();
Uri uri = new Uri.dataFromString(url!);

class Thankyouscreen extends StatelessWidget {
  String? myurl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 15, 0),
                child: MediaQuery.of(context).orientation ==
                        Orientation.landscape
                    ? Text('Customer Service: (+30) 22910 79480 ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: MediaQuery.of(context).orientation ==
                                    Orientation.portrait
                                ? 8
                                : 15,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold))
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            Text('Customer Service:',
                                style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize:
                                        MediaQuery.of(context).orientation ==
                                                Orientation.portrait
                                            ? 13
                                            : 15,
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.bold)),
                            Text('(+30) 22910 79480 ',
                                style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize:
                                        MediaQuery.of(context).orientation ==
                                                Orientation.portrait
                                            ? 12
                                            : 15,
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.bold)),
                          ])),
          ],
          leading: Transform.scale(
              scale: 3,
              child: IconButton(
                onPressed: _launchURL,
                icon: Image.asset('assets/logo.jpg'),
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              )),
        ),
        body: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(10.0),
            children: <Widget>[
              Title(
                  color: Colors.black,
                  child: Text('Thank you for your reservation.')),
              Text(
                  'We will confirm or reply to your request within 12-24 hours. An email confirmation has been sent to your email.'),
              Text(
                  'You can contact us at interent.car.rental@gmail.com for any changes to your reservations.'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: Text("Return"),
                  onPressed: _launchURL,
                ),
              )
            ]));
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
