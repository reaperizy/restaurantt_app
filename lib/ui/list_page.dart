import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/utils/state_result.dart';
import 'package:restaurant_app/provider/resto_provider.dart';
import 'package:restaurant_app/widgets/resto_card.dart';
import 'package:restaurant_app/ui/search_screen.dart';


class ListPage extends StatelessWidget {
  static const routeName = '/list_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchScreen(),
              ),
            );
            },
            icon: const Icon(Icons.search, color: Colors.white),
          )
        ],
      ),
      body: Consumer<RestoProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (state.state == ResultState.hasData) {
              return Scaffold(
                body: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.result.restaurants.length,
                  itemBuilder: (context, index) {
                    var restaurant = state.result.restaurants[index];
                    return CardRestaurant(restaurant: restaurant);
                  },
                ),
              );
            } else if (state.state == ResultState.noData) {
              return Center(
                child: Text(state.message),
              );
            } else if (state.state == ResultState.error){
              return Center(
                child: Text(state.message),
              );
            } else {
              return Center(
                child: Text(''),
              );
            }
          }
        },
      ),
    );
  }
}
