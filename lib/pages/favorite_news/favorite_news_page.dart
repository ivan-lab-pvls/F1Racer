import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:racing/data/controllers/news_controller.dart';
import 'package:racing/pages/news/%20news_page.dart';

class FavoriteNewsPage extends StatelessWidget {
  const FavoriteNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'News',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: SvgPicture.asset('images/bell.svg'),
          ),
        ],
      ),
      body: Consumer<NewsController>(builder: (context, controller, child) {
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.favoriteNews.length,
          itemBuilder: (context, index) {
            final newModel = controller.favoriteNews[index];

            return NItem(newModel: newModel);
          },
        );
      }),
    );
  }
}
