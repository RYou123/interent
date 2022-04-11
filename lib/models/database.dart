import 'package:cloud_firestore/cloud_firestore.dart';

import 'cars.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('Cars');

List<CarItem> listcars2 = [];

class Database {
  static String userUid = "";

  List<CarItem> listcars = [];

  static Stream<QuerySnapshot> readItems() {
    CollectionReference CarItemCollection =
        _mainCollection.doc(userUid).collection('Cars');

    return CarItemCollection.snapshots();
  }

  Future<void> getlistofcars(DateTime s, DateTime e) async {
    this.listcars.clear();
    print("geting");
    _mainCollection.get().then((QuerySnapshot querySnapshot) {
      this.listcars.clear();
      if (querySnapshot.docs.length == 0) {
        return [];
      } else {
        querySnapshot.docs.forEach((doc) async {
          Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
          print("Doc = ${doc.id}");
          bool value = await getall2(s, e, doc.id);

          print("value for =${doc.id} $value");

          if (value) {
            print("value = true");

            this.listcars.add(CarItem.fromJson(data));
            print("llll = ${listcars.length}");
            listcars2 = listcars;
            print("llll2 = ${listcars2.length}");
          } else {
            print("nn");
          }
        });
      }

      //print(doc.id);
    });
  }

  //check if car/doc is reserved and return a: true or false.
  Future<bool> getall2(DateTime s, DateTime e, String id) async {
    bool a = true;

    var aa = await _mainCollection
        .doc(id)
        .collection('Reservations')
        .get()
        .then((QuerySnapshot docs) async {
      if (docs.docs.length == 0) {
        print("no item ");
        return a = false;
      } else {
        for (final element in docs.docs) {
          //   docs.docs.forEach((element) {
          //  print(element.id);

          DateTime start = (element['start'] as Timestamp).toDate();

          DateTime end = (element['end'] as Timestamp).toDate();
          // print(s);
          //  print(e);
          //  print(start);
          //   print(end);
          if (!((s.isAfter(end) && e.isAfter(end)) ||
              (e.isBefore(start) && s.isBefore(start)))) {
            a = false;
            print('nottt');

            break;
            // print (a);

          } else {
            print('isss');

            a = true;
          }
        }
        ;
      }
    });

    print("a = $a");
    return a;
  }
}

class SearchService {
  getall(DateTime s, DateTime e) {
    Stream<QuerySnapshot> _usersStream = _mainCollection.snapshots();

    return _usersStream;
    ;
  }

  bool aa = true;
  getall3(DateTime s, DateTime e, String id) async {
    await getall2(s, e, id).then((value) {
      aa = value;
    });
  }

  Future<bool> getall2(DateTime s, DateTime e, String id) async {
    bool a = true;

    var aa = await _mainCollection
        .doc(id)
        .collection('Reservations')
        .get()
        .then((QuerySnapshot docs) async {
      for (final element in docs.docs) {
        //   docs.docs.forEach((element) {
        print(element.id);

        DateTime start = (element['start'] as Timestamp).toDate();

        DateTime end = (element['end'] as Timestamp).toDate();
        print(s);
        print(e);
        print(start);
        print(end);
        if ((s.isAfter(start) && s.isBefore(end)) ||
            (e.isAfter(start) && e.isBefore(end))) {
          a = false;
          print('nottt');

          break;
          // print (a);

        } else {
          print('isss');

          a = true;
        }
      }
      ;
    });

    print("a = $a");
    return a;
  }
}
