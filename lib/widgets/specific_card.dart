import '../utils/utils.dart';
import 'package:flutter/material.dart';

class SpecificsCard extends StatelessWidget {
  final double? price;
  final String name;
  final String name2;

  SpecificsCard({this.price, required this.name, required this.name2});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: price == null ? 80 : 100,
      width: 100,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(10)),
      child: price == null
          ? Column(
              children: [
                Text(
                  name,
                  style: BasicHeading,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  name2,
                  style: SubHeading,
                ),
              ],
            )
          : Column(
              children: [
                Text(
                  name,
                  style: BasicHeading,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  price.toString(),
                  style: SubHeading,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(name2)
              ],
            ),
    );
  }
}

class SpecificsCard2 extends StatelessWidget {
  final String name;
  final String name2;

  SpecificsCard2({required this.name, required this.name2});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(2),
        padding: EdgeInsets.all(2),
        height: MediaQuery.of(context).orientation == Orientation.landscape
            ? 60
            : 45,
        width: MediaQuery.of(context).orientation == Orientation.landscape
            ? 70
            : 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  name,
                  style: BasicHeading,
                )),
            SizedBox(
              height: 3,
            ),
            FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  name2,
                  style: SubHeading3,
                )),
          ],
        ));
  }
}
