import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



Future selectDate(
  BuildContext context, String dateString) async {
  
  DateTime initDate = DateTime.now();
  if (dateString != null) {
    List dateParts = dateString.split(",");
    initDate = DateTime(
      int.parse(dateParts[0]),
      int.parse(dateParts[1]),
      int.parse(dateParts[2]));
  }
  DateTime picker = await showDatePicker(
    context: context, 
    initialDate: initDate, 
    firstDate: DateTime(2019), 
    lastDate: DateTime(2030));

    if (picker != null) {

    }
    
}