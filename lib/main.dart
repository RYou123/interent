import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:url_launcher/url_launcher.dart';
import './widgets/cars_grid.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:window_location_href/window_location_href.dart';
import 'package:url_strategy/url_strategy.dart';

import 'models/cars.dart';
import 'models/database.dart';

//Testing this:
final String? url = getHref();
Uri uri = new Uri.dataFromString(url!);
DateTime checkinParam = DateTime.parse(uri.queryParameters['checkin-date']!);
DateTime checkoutParam = DateTime.parse(uri.queryParameters['checkout-date']!);
//end test
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setPathUrlStrategy();

  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  String? myurl, para1, para2, para3;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rates & Reservations',
      theme: ThemeData(
          textTheme:
              const TextTheme(bodyText2: TextStyle(fontFamily: "OpenSans")),
          primarySwatch: Colors.blueGrey,
          primaryColor: Colors.white,
          accentColor: Colors.purple,
          backgroundColor: Colors.white),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  String date = "";

  String pickuplocation = 'Athens Airport';
  String dropofflocation = 'Athens Airport';
  var items = [
    'Athens Airport',
    'Koropi Office',
    'Piraeus Port',
    'Kalamaki Port',
    'Central Athens',
    'Other'
  ];

  DateTime selectedDate = DateTime.now().subtract(Duration(days: 1));
  DateTime selectedDate2 = DateTime.now();
  SearchService d = new SearchService();
  Database dd = new Database();
  List<CarItem> avail = [];

  bool aaa = false;
  double? _height;
  double? _width;

  String? _setTime, _setDate;

  String? _hour, _minute, _time;

  String? dateTime;

  TimeOfDay selectedTime =
      TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute);
  TimeOfDay selectedTime2 =
      TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute);

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  CollectionReference _mainCollection =
      FirebaseFirestore.instance.collection('Cars');

  int isDateSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,

          children: [
            SizedBox(
              height: 50,
            ),
            ListTile(
              title: Center(
                child: const Text(
                  'Home',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
              onTap: () {
                _launchURL();
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Center(
                child: const Text('Book Now',
                    style: TextStyle(fontSize: 18, color: Colors.grey)),
              ),
              onTap: () {
                launch('https://interent.gr/book-now.html',
                    webOnlyWindowName: '_self');

                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Center(
                child: const Text('About',
                    style: TextStyle(fontSize: 18, color: Colors.grey)),
              ),
              onTap: () {
                launch('https://www.interent.gr/about.html',
                    webOnlyWindowName: '_self');
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Center(
                child: const Text('Contact',
                    style: TextStyle(fontSize: 18, color: Colors.grey)),
              ),
              onTap: () {
                launch('https://www.interent.gr/contact.html',
                    webOnlyWindowName: '_self');
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 15, 0),
              child: MediaQuery.of(context).orientation == Orientation.landscape
                  ? Align(
                      alignment: Alignment.center,
                      child: Text('Customer Service: (+30) 210 2205573 ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? 8
                                  : 16,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold)),
                    )
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
                          Text('(+30) 210 2205573 ',
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
        elevation: 0.5,
        toolbarHeight: 90,
        title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Transform.scale(
              scale: 4,
              child: IconButton(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                onPressed: _launchURL,
                icon: Image.asset('assets/logo.jpg'),
              )),
          SizedBox(
            width: MediaQuery.of(context).size.width * .2,
          ),
          new Text(
            MediaQuery.of(context).orientation == Orientation.landscape
                ? 'Rates & Reservations'
                : '',
            maxLines: 3,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.grey,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold),
          ),
        ]),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
      ),
      body:
          ListView(shrinkWrap: true, padding: EdgeInsets.all(10.0), children: <
              Widget>[
        SizedBox(
          height: 5,
        ),
        Container(
            decoration: new BoxDecoration(color: Colors.grey[50]),
            padding: EdgeInsets.all(4),
            child: Row(children: [
              Text(
                "  Select your dates and rental location",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 15),
              ),
            ])),
        SizedBox(
          height: 2,
        ),
        Container(
          decoration: new BoxDecoration(color: Colors.blue[50]),
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Row(children: [
            Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              ' Pickup/Drop-off location: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            )),
                      ]),
                  Row(children: [
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 8),
                        height: 40,
                        color: Colors.white,
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 2.3,
                        child: DropdownButton(
                          isExpanded: true,
                          style: TextStyle(color: Colors.black),
                          dropdownColor: Colors.orange,
                          value: pickuplocation,
                          icon: Icon(Icons.keyboard_arrow_down),
                          underline: Container(),
                          items: items.map((String items) {
                            return DropdownMenuItem(
                                value: items,
                                child: Text('       $items',
                                    textAlign: TextAlign.center));
                          }).toList(),
                          onChanged: (String? newValue1) {
                            setState(() {
                              pickuplocation = newValue1!;
                            });
                          },
                        )),
                    SizedBox(
                      width: 2,
                    ),
                    Container(
                        height: 40,
                        margin: const EdgeInsets.fromLTRB(2, 8, 0, 8),
                        color: Colors.white,
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 2.3,
                        child: DropdownButton(
                          isExpanded: true,
                          style: TextStyle(color: Colors.black),
                          dropdownColor: Colors.orange,
                          value: dropofflocation,
                          icon: Icon(Icons.keyboard_arrow_down),
                          underline: Container(),
                          items: items.map((String items) {
                            return DropdownMenuItem(
                                value: items,
                                child: Text('       $items',
                                    textAlign: TextAlign.center));
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropofflocation = newValue!;
                            });
                          },
                        )),
                  ]),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(" Start date: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12)),
                      Row(
                        children: [
                          Container(
                              alignment: Alignment.center,
                              height: 30,
                              width: MediaQuery.of(context).size.width / 2.3,
                              color: Colors.white,
                              child: InkWell(
                                  onTap: () {
                                    _selectDate(context);
                                    isDateSelected =
                                        1; // Call Function that has showDatePicker()
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width / 2.3,
                                    child: Text(
                                        "  ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
                                  ))),
                          Container(
                            color: Colors.white,
                            height: 30,
                            width: MediaQuery.of(context).size.width / 2.3,
                            margin: const EdgeInsets.fromLTRB(8, 10, 0, 8),
                            child: InkWell(
                              onTap: () {
                                _selectTime2(
                                    context); // Call Function that has showDatePicker()
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.07,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                      "${selectedTime2.hour}:${selectedTime2.hour}"),
                                ),

                                // validator: validateDob,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(" End date: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12)),
                      Row(
                        children: [
                          Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width / 2.3,
                              height: 30,
                              color: Colors.white,
                              child: InkWell(
                                  onTap: () {
                                    _selectDate2(context);
                                    isDateSelected =
                                        1; // Call Function that has showDatePicker()
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width / 2.3,
                                    child: Text(
                                        "  ${selectedDate2.day}/${selectedDate2.month}/${selectedDate2.year}"),
                                  ))),
                          //EndDate
                          Container(
                            color: Colors.white,
                            height: 30,
                            width: MediaQuery.of(context).size.width / 2.3,
                            margin: const EdgeInsets.fromLTRB(8, 10, 0, 8),
                            child: InkWell(
                              onTap: () {
                                _selectTime(
                                    context); // Call Function that has showDatePicker()
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.07,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                      "${selectedTime.hour}:${selectedTime.hour}"),
                                ),

                                // validator: validateDob,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ]),
          ]),
        ),
        SizedBox(height: 5),
        isDateSelected == 1
            ? Container(
                decoration: new BoxDecoration(color: Colors.grey[50]),
                padding: EdgeInsets.all(4),
                child: Text(
                  "Select your car:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 15),
                ))
            : SizedBox(height: 5),
        CarsGrid(
          avilcars: c,
          dtd: DateTime(selectedDate.year, selectedDate.month, selectedDate.day,
              selectedTime2.hour, selectedTime2.minute),
          dtf: DateTime(selectedDate2.year, selectedDate2.month,
              selectedDate2.day, selectedTime.hour, selectedTime.minute),
          pickup: pickuplocation,
          dropoff: dropofflocation,
        ),
      ]),
    );
  }

  List<CarItem> c = [];

  Future<void> getlistofcars(DateTime s, DateTime e) async {
    c.clear();
    print("getting");
    _mainCollection.get().then((QuerySnapshot querySnapshot) {
      c.clear();
      if (querySnapshot.docs.length == 0) {
        return [];
      } else {
        querySnapshot.docs.forEach((doc) async {
          Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
          print("Doc = ${doc.id}");
          bool value = await dd.getall2(s, e, doc.id);

          print(
              "value for =${doc.id} $value"); //print if doc.id is available: true or false
          List<String> list2 = [];

          if (value) {
            print("value = true");
            CarItem item = CarItem.fromJson(data);
            data["path"] != null ? list2.add(data["path"]) : null;
            data["path2"] != null ? list2.add(data["path2"]) : null;
            data["path3"] != null ? list2.add(data["path3"]) : null;

            item.isAvailable = true;
            item.image = list2;
            print("llll = ${c.length}");
            listcars2 = c;

            print("llll2 = ${listcars2.length}");
            setState(() {});
            c.add(item);
            print(item.image);
          } else {
            print("value = true");
            CarItem item = CarItem.fromJson(data);
            item.isAvailable = false;
            data["path"] != null ? list2.add(data["path"]) : null;
            data["path2"] != null ? list2.add(data["path2"]) : null;
            data["path3"] != null ? list2.add(data["path3"]) : null;
            data["path4"] != null ? list2.add(data["path4"]) : null;
            print("llll = ${c.length}");
            item.image = list2;

            listcars2 = c;
            print("llll2 = ${listcars2.length}");
            setState(() {});
            print("nn");
            c.add(item);
            c.sort((a, b) => a.price!.compareTo(b.price!));
            print(item.image);
          }
        });
      }

      //print(doc.id);
    });
  }

  Future<void> getlist(DateTime s, DateTime e) async {
    await getlistofcars(s, e).then((value) =>

        //print ("cc ${c.length}");
        //print ("cc ${dd.listcars.length}");

        setState(() {
          // c.clear();
          // c.addAll(dd.listcars);
          print("cc ${c.length}");
          // print ("cc2 ${listcars2.length}");
//});
        }));
  }

  Future _selectLocation(BuildContext context) async {
    DropdownButton(
      value: pickuplocation,
      icon: Icon(Icons.keyboard_arrow_down),
      items: items.map((String items) {
        return DropdownMenuItem(value: items, child: Text(items));
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          pickuplocation = newValue!;
        });
      },
    );
  }

  Future _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 0)),
      lastDate: new DateTime(2025),
    );

    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
        print(selectedDate);
      });
      await MediaQuery.of(context).orientation == Orientation.portrait
          ? getlist(selectedDate, selectedDate2)
              .then((value) => print(c.length))
          : selectedDate = selected;
    }
  }

  _selectDate2(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 3)),
      firstDate: DateTime.now().add(const Duration(days: 3)),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate2) {
      setState(() {
        selectedDate2 = selected;
      });
      getlist(selectedDate, selectedDate2);
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now()
            //selectedTime,
            );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour! + ' : ' + _minute!;
        _timeController.text = _time!;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  Future<Null> _selectTime2(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now()
            //selectedTime2,
            );
    if (picked != null)
      setState(() {
        selectedTime2 = picked;
        _hour = selectedTime2.hour.toString();
        _minute = selectedTime2.minute.toString();
        _time = _hour! + ' : ' + _minute!;
        _timeController.text = _time!;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime2.hour, selectedTime2.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }
}

_launchURL() async {
  const url = 'https://interent.gr';
  if (await canLaunch(url)) {
    await launch(url, webOnlyWindowName: '_self');
  } else {
    throw 'Could not launch $url';
  }
}
