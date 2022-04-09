import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api_service/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/detail_resto_provider.dart';
import 'package:provider/provider.dart';
import '../utils/state_result.dart';
import '../widgets/detail_page.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = '/detail_screen';

  DetailScreen ({required this.restaurant});
  final Restaurant restaurant;

  Widget _buildList (BuildContext context) {
    return ChangeNotifierProvider<DetailProvider>(
      create: (_) => DetailProvider(apiService: ApiService(), resto: restaurant.id),
      child: Scaffold(
        body: Consumer<DetailProvider>(
          builder: (context, data, _) {
            if (data.state == ResultState.loading) {
              return Center(child: CircularProgressIndicator(),);
            } else if (data.state == ResultState.hasData) {
              return Scaffold(
                body: DetailRestoPage(restaurants: data.detailResult.restaurants),
              );
            } else if (data.state == ResultState.noData) {
              return Center(child: Text(data.message));
            } else if (data.state == ResultState.error) {
              return Center(child: Text(data.message));
            } else {
              return Center(child: Text(''));
            }
          }
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidbuilder: _buildList,
      iosbuilder: _buildList,
    );
  }
}