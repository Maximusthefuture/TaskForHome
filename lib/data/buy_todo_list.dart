
//TODO: Нужны отдельные категории для дома, покупок, уборки? Разные ячейки?
//Прогресс бар на вкусняшку????

import 'category.dart';

class BuyList {
    String? item;
    BuyCategory? category;
    String? title;
    String? description;
    bool? isChecked;
    bool? showToOthers;

    BuyList({
      this.item,
      this.category });
}