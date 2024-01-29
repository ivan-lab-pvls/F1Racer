import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:racing/c_theme.dart';
import 'package:racing/data/new_model.dart';

class NewPage extends StatelessWidget {
  const NewPage({super.key, required this.newModel});
  final NewModel newModel;
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Image.network(
                newModel.url,
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  DateFormat('dd MMM yyyy HH:mm').format(newModel.date),
                  style: const TextStyle(
                    color: CTheme.textGreyColor,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  newModel.text,
                  style: const TextStyle(color: CTheme.whiteColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
