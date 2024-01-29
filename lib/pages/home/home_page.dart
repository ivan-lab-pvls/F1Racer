import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:racing/c_theme.dart';
import 'package:racing/data/racing_model.dart';
import 'package:racing/data/racing_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RacingRepository _rep = RacingRepository();

  List<RacingModel> _races = [];
  var _loading = true;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    final races = await _rep.getRaces();
    setState(() {
      _races = races;
      _loading = false;
    });
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
              'Home',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            SvgPicture.asset('images/bell.svg'),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Formula 1 2024 calendar',
              style: TextStyle(
                color: CTheme.whiteColor,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            child: _loading
                ? Center(
                    child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _races.length,
                    itemBuilder: (context, index) {
                      final racingModel = _races[index];
                      return RacingItem(
                        racingModel: racingModel,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class RacingItem extends StatelessWidget {
  const RacingItem({super.key, required this.racingModel});
  final RacingModel racingModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: CTheme.darkGreyColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'event',
                  style: TextStyle(color: CTheme.textGreyColor),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'date',
                    style: TextStyle(color: CTheme.textGreyColor),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white,
                      ),
                      child: Image.network(
                        racingModel.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        racingModel.eventName.toUpperCase(),
                        style: const TextStyle(
                          color: CTheme.whiteColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    DateFormat('[ dd MMM ] HH:mm').format(racingModel.date),
                    style: const TextStyle(
                      color: CTheme.whiteColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
