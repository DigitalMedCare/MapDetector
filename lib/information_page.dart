import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Data Collector').tr()),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: const Text(
          'This is the information that needed to be display!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ).tr(),
      ),
    );
  }
}
