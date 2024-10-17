import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Chiroyli Animatsiyali PageView'),
        ),
        body: PageViewDemo(),
      ),
    );
  }
}

class PageViewDemo extends StatefulWidget {
  @override
  _PageViewDemoState createState() => _PageViewDemoState();
}

class _PageViewDemoState extends State<PageViewDemo> {
  PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.horizontal, // Gorizontal skroll uchun
      itemBuilder: (context, index) {
        return VerticalPageView(index: index); // Har bir sahifa vertikal skroll
      },
    );
  }
}

class VerticalPageView extends StatelessWidget {
  final int index;

  VerticalPageView({required this.index});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical, // Har bir sahifa vertikal skroll
      itemBuilder: (context, innerIndex) {
        return AnimatedPage(
          index: index,
          innerIndex: innerIndex,
        );
      },
    );
  }
}

class AnimatedPage extends StatelessWidget {
  final int index;
  final int innerIndex;

  AnimatedPage({required this.index, required this.innerIndex});

  @override
  Widget build(BuildContext context) {
    final colors = [Colors.red, Colors.green, Colors.blue, Colors.purple];

    return AnimatedBuilder(
      animation: PageController(),
      builder: (context, child) {
        return Transform.scale(
          scale: 0.9, // Sahifalarni kichikroq qilib yumshoqroq ko'rsatish
          child: Opacity(
            opacity: 0.9, // Sal shaffoflik bilan ko'rsatish
            child: Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colors[(index + innerIndex) % colors.length],
                borderRadius:
                    BorderRadius.circular(30), // Burchaklarni yumaloqlash
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 15, // Sahifalarga soyali ko'rinish berish
                    offset: Offset(0, 5), // Soyaning joylashuvi
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Sahifa ($index, $innerIndex)',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
