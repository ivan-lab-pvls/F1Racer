import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:racing/c_theme.dart';
import 'package:racing/data/controllers/news_controller.dart';
import 'package:racing/data/new_model.dart';
import 'package:racing/pages/news/new_page.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final TextEditingController _controller = TextEditingController();
  var _query = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener(_listener);
  }

  void _listener() {
    setState(() {
      _query = _controller.text.toLowerCase();
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            const Text(
              'News',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            SvgPicture.asset('images/bell.svg'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              style: const TextStyle(color: CTheme.whiteColor),
              decoration: InputDecoration(
                hintStyle: const TextStyle(
                  color: CTheme.textGreyColor,
                ),
                hintText: 'Search',
                filled: true,
                fillColor: CTheme.darkGreyColor,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(16),
                ),
                suffixIcon: UnconstrainedBox(
                  child: SvgPicture.asset('images/search.svg'),
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Formula 1',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: CTheme.whiteColor,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Consumer<NewsController>(
                  builder: (context, controller, child) {
                final news = controller.allNews
                    .where((element) =>
                        element.text.toLowerCase().contains(_query))
                    .toList();

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemCount: news.length,
                  itemBuilder: (context, index) {
                    final n = news[index];

                    return NItem(newModel: n);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class NItem extends StatelessWidget {
  const NItem({super.key, required this.newModel});
  final NewModel newModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => NewPage(newModel: newModel),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: CTheme.darkGreyColor,
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  newModel.url,
                  height: 80,
                  width: 120,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: CTheme.darkColor,
                          ),
                          child: Text(
                            DateFormat('dd MMM yyyy HH:mm')
                                .format(newModel.date),
                            style: const TextStyle(color: CTheme.textGreyColor),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            context
                                .read<NewsController>()
                                .likeNewModel(newModel);
                          },
                          child: SvgPicture.asset(newModel.isFavorite
                              ? 'images/favorite_active.svg'
                              : 'images/favorite.svg'),
                        ),
                      ],
                    ),
                    Text(
                      newModel.text,
                      style: const TextStyle(color: CTheme.whiteColor),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
