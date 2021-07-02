

import 'package:flutter/material.dart';
import 'package:tasks_for_home/domain/watch_list.dart';
import 'package:tasks_for_home/widgets/watch_list_card.dart';
import 'dart:math' as math;

const double _minSpacingPx = 16;
const double _cardWidth = 360;

class WatchListGrid extends StatelessWidget {
  final List<WatchListModel>? list;
  const WatchListGrid({this.list });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
  itemCount:list?.length,
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: MediaQuery.of(context).orientation ==
          Orientation.landscape ? 3: 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
    // childAspectRatio: (2 / 1),
  ),
  itemBuilder: (context,index,) {
    return WatchListCard(recommendation: list?[index]);
  });

  // @override
  // Widget build(BuildContext context) {
  //   return ResponsiveGridList(
  //     desiredItemWidth: math.min(
  //         _cardWidth, MediaQuery.of(context).size.width - (2 * _minSpacingPx)),
  //     minSpacing: _minSpacingPx,
  //     children: list
  //         !.map((recommendation) => WatchListCard(
  //               recommendation: recommendation,
  //             ))
  //         .toList(),
  //   );
  // }
}}