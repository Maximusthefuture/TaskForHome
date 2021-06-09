import 'package:flutter/material.dart';

class WatchListWidget extends StatelessWidget {
  var list = <String>[];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Watch(),
    );
  }
}

class Watch extends StatelessWidget {
  var list = ["ff", "fff", "ffff"];
  var map = {
    "ffff":
        "https://pix10.agoda.net/hotelImages/478594/-1/90da3d13989956f743ce031e01b27369.jpg?s=1024x768",
    "qweqw":
        "https://cdn.vox-cdn.com/thumbor/VYI2U-efVxrd3y6zmiCajyPSTz8=/0x0:3992x2992/1200x800/filters:focal(2483x1821:3121x2459)/cdn.vox-cdn.com/uploads/chorus_image/image/68993490/GettyImages_1032316302.0.jpg",
    "user":
        "https://thebrownidentity.com/wp-content/uploads/2020/07/01-birth-month-If-You-Were-Born-In-Summer-This-Is-What-We-Know-About-You_644740429-icemanphotos.jpg",
        "somoherguys": "https://i.ytimg.com/vi/_K8R7DlYwvw/maxresdefault.jpg"
  };
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: map.length,
          itemBuilder: (context, index) {
            return createWidget(context, map, index);
          }),
    );
  }

  Widget createWidget(BuildContext context, Map list, int index) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 2),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            // child: GestureDetector(
            //   onTapUp: (_) {
            //     Navigator.of(context)
            //         .push(MaterialPageRoute(builder: (_) {
            //       return MovieDetailBlocProvider(
            //         child: MovieDetailsScreen(
            //         movieId: list![index].id
            //       ));
            //     }));
            //     print("id: ${list![index].id}");
            //   },
            child: Column(children: [
              Container(
                width: 200,
                height: 200,
                child: Column(children: [
                  Image.network(
                    map.values.elementAt(index),
                    scale: 2.0,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(map.keys.elementAt(index)),
                ]),
              )
            ])));
  }
}
