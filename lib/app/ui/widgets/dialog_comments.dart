import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DialogComments extends StatelessWidget {
  final List<dynamic> reviews;

  DialogComments(this.reviews);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Text("Comentários",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          Container(
              padding: EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height / 2,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(reviews.elementAt(index)['author_name']),
                        Row(
                          children: <Widget>[
                            RatingBar(
                              initialRating:
                                  reviews.elementAt(index)['rating'].toDouble(),
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              ignoreGestures: true,
                              itemCount: 5,
                              glow: false,
                              itemSize: 18,
                              onRatingUpdate: (r) {},
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 32,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                                reviews.elementAt(
                                    index)['relative_time_description'],
                                style: TextStyle(color: Colors.grey[600]))
                          ],
                        ),
                        Text(reviews.elementAt(index)['text'],
                            style: TextStyle(
                                color: Colors.grey[800], fontSize: 14)),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(color: Colors.grey[500]);
                  },
                  itemCount: reviews.length)),
        ],
      ),
    );
  }
}
