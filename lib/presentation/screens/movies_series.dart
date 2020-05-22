import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_for_home/data/movies_reposilory_impl.dart';
import 'package:tasks_for_home/domain/json_models.dart';
import 'package:tasks_for_home/widgets/popular_movies.dart';

import '../main.dart';


class MoviesTvSeries extends StatelessWidget {
  final MoviesRepositoryImpl repositoryImpl = MoviesRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Развлечения'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(3),
              child: Text(
                'Popular movies',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16
                ),
              ),
            ),
            FutureBuilder<List<Results>>(
              future: repositoryImpl.fetchPhotos(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return PopularMoviesWidget(
                    list: snapshot.data
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
