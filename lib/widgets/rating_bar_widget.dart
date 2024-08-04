import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mood/providers/meal_provider.dart';
import 'package:mood/providers/mood_provider.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

class RatingBarWidget extends StatelessWidget {
  const RatingBarWidget({
    super.key,
    required this.state,
    required this.provider,
  });

  final bool state;
  final String provider;

  @override
  Widget build(BuildContext context) {
    return Consumer2<MealProvider, MoodProvider>(
        builder: (context, meal, mood, _){
          return RatingBar(
            initialRating: 0,
            allowHalfRating: false,
            itemCount: 5,
            itemSize: 60,
            ratingWidget: RatingWidget(
              full: Icon(Icons.star,
                  color: kBlueGrey.withOpacity(0.3),
                  shadows: const [
                    BoxShadow(
                        color: kWhite,
                        blurRadius: 9,
                        spreadRadius: 6,
                        offset: Offset(0.5, 0.5)
                    )
                  ]),
              empty: Icon(Icons.star_border,
                  color: kBlueGrey.withOpacity(0.3),
                  shadows: const [
                    BoxShadow(
                        color: kWhite,
                        blurRadius: 9,
                        spreadRadius: 6,
                        offset: Offset(0.5, 0.5)
                    )
                  ]), half: const SizedBox.shrink(),
            ),
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            onRatingUpdate: (rating) {
              provider == 'meal'
                  ? meal.updateRating(rating)
                  : mood.updateRating(rating);
            } ,
          );
        }
    );
  }
}