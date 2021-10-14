import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_for_home/domain/json_models.dart';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';

class MovieDetailsWidget extends StatelessWidget {
  final AsyncSnapshot<MovieDetails>? snapshot;

  const MovieDetailsWidget({key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //sharedPrefs, userDefaults?
//      RectTween _createRectTween(Rect begin, Rect end) {
//     return QuadraticRectTween(begin: begin, end: end);
// }
    bool isInList = false;
    return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScroller) {
          return <Widget>[
            SliverAppBar(
                pinned: true,
                floating: false,
                expandedHeight: 200,
                actions: <Widget>[
                  Icon(
                    Icons.star,
                    color: isInList ? Colors.yellow : Colors.white,
                  )
                ],
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Column(
                    mainAxisSize: MainAxisSize.min,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Flexible(
                        child: Text(
                          "${snapshot?.data?.title}",
                          textDirection: TextDirection.ltr,
                        ),
                      ),
                      Text(
                        '${snapshot?.data?.releaseDate}',
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                  background: Hero(
                    tag: "Movies${snapshot?.data?.id}",
                    // child: CachedNetworkImage(
                    //   placeholder: (context, url) =>
                    //       const CircularProgressIndicator(),
                    //   imageUrl:
                    //       "https://image.tmdb.org/t/p/w780/${snapshot?.data?.backdropPath}",
                    // ),
                    child: Image.network(
                      "https://image.tmdb.org/t/p/w780/${snapshot?.data?.backdropPath}",
                      errorBuilder: (ctx, object, stacktrace) {
                        return Text("${object}");
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.green),
                            ),
                          );
                        }
                      },
                      fit: BoxFit.cover,
                    ),
                    placeholderBuilder: (context, _, widget) {
                      return Opacity(opacity: 0.2, child: widget);
                    },
                    flightShuttleBuilder: (context, animation, direction,
                        fromHeroContext, toHeroContext) {
                      return FadeTransition(
                        opacity: animation.drive(
                          Tween<double>(begin: 0.0, end: 1.0).chain(
                            CurveTween(
                                curve: Interval(0.0, 1.0,
                                    curve: ValleyQuadraticCurve())),
                          ),
                        ),
                        child: fromHeroContext.widget,
                      );
                    },
                  ),
                ))
          ];
        },
        body: Padding(
            padding: EdgeInsets.all(1),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: 200,
                  width: 100,
                  // child: Hero(
                  //     tag: "Movies",

                  // child: CachedNetworkImage(
                  //   placeholder: (context, url) =>
                  //       CircularProgressIndicator(),
                  //   imageUrl:
                  //       "https://image.tmdb.org/t/p/w780/${snapshot?.data?.posterPath}",
                  // )
                  child: Image.network(
                      "https://image.tmdb.org/t/p/w780/${snapshot?.data?.posterPath}",
                      errorBuilder: (ctx, object, stacktrace) {
                    return Text("${object}");
                  }, loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                      );
                    }
                  }),
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: (Icon(Icons.add)),
                      iconSize: 30,
                      padding: EdgeInsets.all(9),
                      onPressed: () {
                        print("ICONS");
                      },
                    ),
                    Icon(
                      Icons.play_arrow,
                      size: 40,
                    ),
                    Icon(Icons.share),
                  ]),
              Text("${snapshot?.data?.overview}")
            ])));
  }
}

class QuadraticOffsetTween extends Tween<Offset> {
  QuadraticOffsetTween({Offset? begin, Offset? end})
      : super(begin: begin, end: end);

//  @override
//   Offset lerp(double t) {
//     // TODO: implement lerp
//     if (t == 0.0)
//     return begin!;
//     if (t == 1.0)
//       return end!;

//     final double x = -11 * begin!.dx * math.pow(t, 2) +
//         (end.dx + 10 * begin.dx) * t + begin.dx;
//     final double y = -2 * begin.dy * math.pow(t, 2) +
//         (end.dy + 1 * begin.dy) * t + begin.dy;
//     return Offset(x, y);
//   }
}

class ValleyQuadraticCurve extends Curve {
  @override
  double transform(double t) {
    assert(t >= 0.0 && t <= 1.0);
    double result = (4 * pow(t - 0.5, 2)).toDouble();
    return result;
  }
}
