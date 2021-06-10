import 'package:http/http.dart';
import 'package:tasks_for_home/domain/watch_list.dart';

class WatchListData {
  final dynamic name;
  final List movieList;

  WatchListData({required this.name, required this.movieList});
}