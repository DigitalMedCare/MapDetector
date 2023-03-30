import 'package:data_collector/page_four.dart';
import 'package:data_collector/page_one.dart';
import 'package:data_collector/page_six.dart';
import 'package:data_collector/page_three.dart';
import 'package:data_collector/page_two.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => EasyLocalization(
        supportedLocales: const [Locale('en', ''), Locale('de', '')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', ''),
        startLocale: const Locale('en', ''),
        useOnlyLangCode: true,
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      title: 'Swipe Navigation Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SwipeNavigation(),
    );
  }
}

class SwipeNavigation extends StatefulWidget {
  const SwipeNavigation({Key? key}) : super(key: key);

  @override
  State<SwipeNavigation> createState() => _SwipeNavigationState();
}

class _SwipeNavigationState extends State<SwipeNavigation> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPageIndex = 0;

  void _onPageChanged(int pageIndex) {
    setState(() {
      _currentPageIndex = pageIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: const [
          PageOne(),
          PageTwo(),
          PageThree(),
          LocationPage(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPageIndex == 0 ? Colors.green : Colors.grey,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPageIndex == 1 ? Colors.green : Colors.grey,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPageIndex == 2 ? Colors.green : Colors.grey,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPageIndex == 3 ? Colors.green : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
