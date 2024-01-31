import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:racing/c_theme.dart';
import 'package:racing/data/racing_model.dart';

class RacingDetailedPage extends StatelessWidget {
  const RacingDetailedPage({super.key, required this.racingModel});
  final RacingModel racingModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Image.network(
                racingModel.imageUrl,
                fit: BoxFit.fitWidth,
                errorBuilder: (context, error, stackTrace) => Container(),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              racingModel.eventName.toUpperCase(),
              style: const TextStyle(
                color: CTheme.whiteColor,
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            Text(
              DateFormat('[ dd MMM ] HH:mm').format(racingModel.date),
              style: const TextStyle(
                color: CTheme.whiteColor,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}