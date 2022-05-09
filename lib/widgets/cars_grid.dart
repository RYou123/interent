import 'package:flutter/material.dart';
import '../models/cars.dart';
import '../widgets/specific_card.dart';
import '../screens/car_detail.dart';
import '../Widgets/unorderedlist.dart';

class CarsGrid extends StatelessWidget {
  List<CarItem> avilcars;

  DateTime dtf;
  DateTime dtd;
  String pickup;
  String dropoff;

  CarsGrid({
    required this.avilcars,
    required this.dtf,
    required this.dtd,
    required this.pickup,
    required this.dropoff,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      itemCount: avilcars.length,
      itemBuilder: (ctx, i) => Padding(
        padding: MediaQuery.of(context).orientation == Orientation.landscape
            ? const EdgeInsets.fromLTRB(50, 0, 50, 0)
            : const EdgeInsets.all(0),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => CarDetail(
                      title: avilcars[i].title!,
                      transmission: avilcars[i].transmission!,
                      fuel: avilcars[i].fuel!,
                      price: dtf.difference(dtd).inDays.toInt() > 14
                          ? avilcars[i].price! * .85
                          : dtf.difference(dtd).inDays.toInt() > 7
                              ? avilcars[i].price! * .9
                              : avilcars[i].price,
                      path: avilcars[i].path!,
                      doors: avilcars[i].doors!,
                      color: avilcars[i].color!,
                      dtf: dtf,
                      dtd: dtd,
                      pickup: pickup,
                      dropoff: dropoff,
                    )));
          },
          child: Container(
              height: MediaQuery.of(context).size.height / 3.8,
              margin: EdgeInsets.only(top: 5, bottom: 5),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26, blurRadius: 5, spreadRadius: 1)
                  ]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Hero(
                      tag: avilcars[i].title!,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * .9,
                              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              margin: const EdgeInsets.fromLTRB(5, 8, 3, 0),
                              child: Text(
                                '${avilcars[i].title!} or similar ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).orientation ==
                                                Orientation.landscape
                                            ? 18
                                            : 15),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  avilcars[i].path!,
                                  alignment: Alignment.topCenter,
                                  width: MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? 160
                                      : 200,
                                  height: MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? 140
                                      : 180,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                MediaQuery.of(context).orientation ==
                                        Orientation.landscape
                                    ? UnorderedList([
                                        'All local taxes',
                                        'Unlimited mileage',
                                        'CDW & Theft Protection',
                                      ])
                                    : SizedBox(
                                        height: 1,
                                      ),
                                MediaQuery.of(context).orientation ==
                                        Orientation.portrait
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                            MediaQuery.of(context)
                                                        .orientation ==
                                                    Orientation.landscape
                                                ? SizedBox(
                                                    height: 2,
                                                  )
                                                : Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 0, 0, 2),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          SpecificsCard2(
                                                              name: 'Gearbox',
                                                              name2: avilcars[i]
                                                                  .transmission!),
                                                          SpecificsCard2(
                                                              name: 'Doors',
                                                              name2: avilcars[i]
                                                                  .doors!),
                                                          SpecificsCard2(
                                                              name: 'Fuel type',
                                                              name2: avilcars[i]
                                                                  .fuel!),
                                                          SpecificsCard2(
                                                              name: 'Color',
                                                              name2: avilcars[i]
                                                                  .color!),
                                                        ])),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 8, 0),
                                              child: Text(
                                                  '${(dtf.difference(dtd).inDays.toInt() > 14 ? (avilcars[i].price! * .85).roundToDouble() : dtf.difference(dtd).inDays.toInt() > 7 ? (avilcars[i].price! * .9).roundToDouble() : avilcars[i].price).toString()}€ / DAY',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 8, 0),
                                              child: Text(
                                                  'total ${dtf.difference(dtd).inDays.toInt().abs() > 14 ? (avilcars[i].price! * .85).roundToDouble() * dtf.difference(dtd).inDays.toInt().abs() : dtf.difference(dtd).inDays.toInt() > 7 ? (avilcars[i].price! * .9).roundToDouble() * dtf.difference(dtd).inDays.toInt().abs() : avilcars[i].price!.toInt() * dtf.difference(dtd).inDays.toInt().abs()}.00 €',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                  )),
                                            ),
                                          ])
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(children: [
                                                SpecificsCard2(
                                                    name: 'Gearbox',
                                                    name2: avilcars[i]
                                                        .transmission!),
                                                SpecificsCard2(
                                                    name: 'Doors',
                                                    name2: avilcars[i].doors!),
                                                SpecificsCard2(
                                                    name: 'Fuel type',
                                                    name2: avilcars[i].fuel!),
                                                SpecificsCard2(
                                                    name: 'Color',
                                                    name2: avilcars[i].color!),
                                              ]),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 8, 0),
                                              child: Text(
                                                  '${(dtf.difference(dtd).inDays.toInt() > 14 ? (avilcars[i].price! * .85).roundToDouble() : dtf.difference(dtd).inDays.toInt() > 7 ? (avilcars[i].price! * .9).roundToDouble() : avilcars[i].price).toString()}€ / DAY',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 8, 0),
                                              child: Text(
                                                  'total ${dtf.difference(dtd).inDays.toInt().abs() > 14 ? (avilcars[i].price! * .85).roundToDouble() * dtf.difference(dtd).inDays.toInt().abs() : dtf.difference(dtd).inDays.toInt() > 7 ? (avilcars[i].price! * .9).roundToDouble() * dtf.difference(dtd).inDays.toInt().abs() : avilcars[i].price!.toInt() * dtf.difference(dtd).inDays.toInt().abs()}.00 €',
                                                  style:
                                                      TextStyle(fontSize: 14)),
                                            ),
                                          ]),
                              ],
                            ),
                          ])),

                  /* Column(
                      crossAxisAlignment: MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.center,
                      mainAxisAlignment: MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.start,
                      children: [
                        MediaQuery.of(context).orientation ==
                                Orientation.landscape
                            ? SizedBox(
                                height: 2,
                              )
                            : Padding(
                                padding: const EdgeInsets.fromLTRB(0, 8, 0, 2),
                                child: Row(children: [
                                  SpecificsCard2(
                                      name: 'Gearbox',
                                      name2: avilcars[i].transmission!),
                                  SpecificsCard2(
                                      name: 'Doors', name2: avilcars[i].doors!),
                                  SpecificsCard2(
                                      name: 'Fuel type',
                                      name2: avilcars[i].fuel!),
                                  SpecificsCard2(
                                      name: 'Color', name2: avilcars[i].color!),
                                ])),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                          child: Text(
                            '${(dtf.difference(dtd).inDays.toInt() > 14 ? (avilcars[i].price! * .85).roundToDouble() : dtf.difference(dtd).inDays.toInt() > 7 ? (avilcars[i].price! * .9).roundToDouble() : avilcars[i].price).toString()}€ / DAY',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                          child: Text(
                            'total ${dtf.difference(dtd).inDays.toInt().abs() > 14 ? (avilcars[i].price! * .85).roundToDouble() * dtf.difference(dtd).inDays.toInt().abs() : dtf.difference(dtd).inDays.toInt() > 7 ? (avilcars[i].price! * .9).roundToDouble() * dtf.difference(dtd).inDays.toInt().abs() : avilcars[i].price!.toInt() * dtf.difference(dtd).inDays.toInt().abs()}.00 €',
                          ),
                        ),
                      ]),*/
                  SizedBox(
                    width: 5,
                  ),
                  // Add car information and price +Arrow button
                ],
              )),
        ),
      ),
    );
  }
}
