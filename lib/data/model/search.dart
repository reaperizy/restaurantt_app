import 'package:restaurant_app/data/model/restaurant.dart';

class RestaurantSearch {
  RestaurantSearch({
    required this.restaurants,
  });

  List<Restaurant> restaurants;

  factory RestaurantSearch.fromJson(Map<String, dynamic> json) =>
      RestaurantSearch(
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );
}
