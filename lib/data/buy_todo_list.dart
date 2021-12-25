
//TODO: Нужны отдельные категории для дома, покупок, уборки? Разные ячейки?
//Прогресс бар на вкусняшку????

import 'package:cloud_firestore/cloud_firestore.dart';

import 'category.dart';

class BuyList {
    String? item;
    String? category;
    String? title;
    String? description;
    int? isChecked;
    bool? showToOthers;
    DocumentReference? reference;

    BuyList({
      this.item,
      this.category,
      this.isChecked = 0});

      BuyList.fromSnapshot(DocumentSnapshot snapshot)
      : assert(snapshot != null),
        item = snapshot['item'],
        // array = snapshot['array'],
        isChecked = snapshot["isDone"],
        category = snapshot["category"],
        
        reference = snapshot.reference;
}