import '../utils/utils.dart';
import 'package:flutter/material.dart';
import '../widgets/specific_card.dart';
import '../widgets/custom_form.dart';
import 'package:intl/intl.dart';

class CarDetail extends StatelessWidget {
  final String? title;
  final double? price;
  final String? color;
  final String? doors;
  final String? fuel;
  final String? transmission;
  final String? path;
  final DateTime? dtf;
  final DateTime? dtd;
  final String? pickup;
  final String? dropoff;

  CarDetail(
      {required this.title,
      required this.price,
      required this.color,
      required this.doors,
      required this.fuel,
      required this.transmission,
      required this.path,
      required this.dtf,
      required this.dtd,
      required this.pickup,
      required this.dropoff});

  @override
  Widget build(BuildContext context) {
    String pickupdateformat = DateFormat.yMMMEd().format(dtd!);
    String dropoffformat = DateFormat.yMMMEd().format(dtf!);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          actions: [],
          title: Text(
            'Booking details',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold),
          ),
          automaticallyImplyLeading: true,
          leading: Transform.scale(
              scale: 1,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.black,
              )),
        ),
        body: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(10.0),
            children: <Widget>[
              Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Column(children: [
                  Text(
                    title!,
                    style: MainHeading,
                  ),
                  SizedBox(
                    child: Hero(
                      tag: title!,
                      child: Image.asset(path!),
                    ),
                    height: 100,
                    width: 200,
                  )
                ]),
                Container(
                  height: 1000,
                  padding: const EdgeInsets.fromLTRB(10, 20, 0, 10),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SpecificsCard(
                          name: '20 Days',
                          price: dtf!.difference(dtd!).inDays.toInt() > 14
                              ? (price!).roundToDouble()
                              : dtf!.difference(dtd!).inDays.toInt() > 7
                                  ? (price! / 0.9 * 0.85).roundToDouble()
                                  : price!.roundToDouble() * 0.85,
                          name2: 'Euro',
                        ),
                        SpecificsCard(
                          name: '7 Days',
                          price: dtf!.difference(dtd!).inDays.toInt() > 14
                              ? (price! / .85 * 0.9).roundToDouble()
                              : dtf!.difference(dtd!).inDays.toInt() > 7
                                  ? (price!).roundToDouble()
                                  : price!.roundToDouble() * 0.9,
                          name2: 'Euro',
                        ),
                        SpecificsCard(
                          name: '1 Day',
                          price: dtf!.difference(dtd!).inDays.toInt() > 14
                              ? (price! / .85).roundToDouble()
                              : dtf!.difference(dtd!).inDays.toInt() > 7
                                  ? (price! / .9).roundToDouble()
                                  : price!.roundToDouble(),
                          name2: 'Euro',
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'SPECIFICATIONS',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SpecificsCard2(
                          name: 'Door',
                          name2: doors!,
                        ),
                        SpecificsCard2(
                          name: 'Color',
                          name2: color!,
                        ),
                        SpecificsCard2(
                          name: 'Gearbox',
                          name2: transmission!,
                        ),
                        SpecificsCard2(
                          name: 'Fuel',
                          name2: fuel!,
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Divider(thickness: 1),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                      child: Text(
                        "DATES",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    Text('$pickupdateformat'),
                    Text('$dropoffformat'),
                    Divider(thickness: 1),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                      child: Text(
                        'PICKUP & RETURN',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                      child: Text('$pickup / $dropoff'),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: Colors.grey[400]!),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      width: MediaQuery.of(context).size.width * .9,
                      child: Column(children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Price'),
                              Text(
                                  '${dtf!.difference(dtd!).inDays.toInt().abs().roundToDouble() * price!} €')
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Full insurance'),
                              Text('Included')
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Delivery & Return fee'),
                              Text('Included')
                            ]),
                        SizedBox(height: 15),
                        Container(
                          height: 25,
                          decoration: BoxDecoration(color: Colors.blue[100]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total'),
                              Text(
                                '${dtf!.difference(dtd!).inDays.toInt().abs().roundToDouble() * price!.abs().roundToDouble()} €',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ]),
                    ),
                    SizedBox(height: 20),
                    MyCustomForm(title, price, color, fuel, path, transmission,
                        dtf, dtd, pickup, dropoff),
                  ]),
                ),
              ])
            ]));
  }
}
