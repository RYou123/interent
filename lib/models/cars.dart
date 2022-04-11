import 'package:flutter/foundation.dart';

class CarItem {
  String? title;
  String? category;
  double? price;
  String? path;
  String? path2;
  String? path3;
  String? path4;
  String? color;
  String? doors;
  String? fuel;
  String? transmission;
  bool? isAvailable;
  DateTime? startDate1;
  DateTime? endDate1;
  List<Reservation>? reser;
  List<String>? image;

  CarItem(
      {this.price,
      this.category,
      this.title,
      required this.path,
      this.path2,
      this.path3,
      this.path4,
      required this.color,
      required this.doors,
      required this.fuel,
      required this.transmission,
      required this.isAvailable,
      required this.startDate1,
      required this.endDate1,
      this.reser,
      this.image});

  CarItem.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    path2 = json['path2'];
    path3 = json['path3'];
    path4 = json['path4'];
    color = json['color'];
    doors = json['doors'];
    category = json['category'];
    fuel = json['fuel'];
    price = json['price'].toDouble();
    title = json['title'];
    transmission = json['transmission'];
    // reser = Reservation.fromJson(json);
  }
}

CarsList allCars = CarsList(cars: [
  CarItem(
    title: 'Skoda Fabia',
    price: 30,
    color: 'Grey',
    doors: '5',
    fuel: 'Diesel',
    transmission: 'Manual',
    path: 'assets/car1.jpg',
    isAvailable: true,
    endDate1: DateTime.parse("2021-12-02"),
    startDate1: DateTime.parse("2021-11-02"),
  ),
  CarItem(
      title: 'Toyota Prius',
      price: 223,
      color: 'Gold',
      doors: '5',
      fuel: 'Unleaded Hybrid',
      transmission: 'Automatic',
      path: 'assets/car2.jpg',
      isAvailable: true,
      endDate1: DateTime.parse("2021-11-01"),
      startDate1: DateTime.parse("2021-10-01")),
  CarItem(
      title: 'Toyota Prius',
      price: 223,
      color: 'Gold',
      doors: '5',
      fuel: 'Unleaded Hybrid',
      transmission: 'Automatic',
      path: 'assets/car2.jpg',
      isAvailable: true,
      endDate1: DateTime.parse("2021-10-30"),
      startDate1: DateTime.parse("2021-10-15")),
  CarItem(
      title: 'Toyota Prius',
      price: 223,
      color: 'Gold',
      doors: '5',
      fuel: 'Unleaded Hybrid',
      transmission: 'Automatic',
      path: 'assets/car2.jpg',
      isAvailable: true,
      endDate1: DateTime.parse("2021-11-30"),
      startDate1: DateTime.parse("2021-11-01")),
]);

class CarsList {
  List<CarItem> cars;

  CarsList({required this.cars});
}

CarsList availCarsList =
    CarsList(cars: allCars.cars.where((i) => i.isAvailable == true).toList());

class Reservation {
  String? user;

  DateTime? startDate1;
  DateTime? endDate1;

  Reservation({this.user, required this.startDate1, required this.endDate1});

  Reservation.fromJson(Map<String, dynamic> json) {
    user = json['Customer'];
    startDate1 = json['start'];
    endDate1 = json['end'];
  }
}
