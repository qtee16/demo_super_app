import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_draggable_gridview/flutter_draggable_gridview.dart';
import 'package:launcher_app/routes/app_routes.dart';

import '../models/app_item.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentPage = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    List<AppItem> list1 = [
      AppItem(imageUrl: "assets/images/facebook.jpg", title: "Facebook",),
      AppItem(imageUrl: "assets/images/instagram.webp", title: "Instagram",),
    ];
    List<AppItem> list2 = [
      AppItem(imageUrl: "assets/images/locket.webp", title: "Locket",),
    ];
    List<AppItem> list3 = [
      AppItem(imageUrl: "assets/images/titktok.webp", title: "Tiktok",),
    ];
    _pages = [
      PageScreen(items: list1),
      PageScreen(items: list2),
      PageScreen(items: list3),
      // Thêm các trang khác ở đây
    ];
  }

  Widget _buildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: 10.0,
      height: 10.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? Colors.black87 : Colors.black38,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView(
            children: _pages,
            onPageChanged: (int index) {
              setState(() {
                _currentPage = index;
              });
            },
          ),
          Positioned(
            bottom: 20.0,
            left: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pages.length, _buildDot),
            ),
          ),
        ],
      ),
    );
  }
}

class PageScreen extends StatefulWidget {
  const PageScreen({super.key, required this.items});
  final List<AppItem> items;

  @override
  State<PageScreen> createState() => _PageScreenState();
}

class _PageScreenState extends State<PageScreen> {
  List<DraggableGridItem> _listOfDraggableGridItem = [];

  @override
  void initState() {
    super.initState();
    _listOfDraggableGridItem = widget.items.map((item) {
      return DraggableGridItem(child: GridItem(item: item), isDraggable: true);
    }).toList();
  }

  Widget feedback(List<DraggableGridItem> list, int index) {
    final maxWidth = MediaQuery.of(context).size.width;
    return Container(
      height: maxWidth/4,
      width: maxWidth/4,
      color: Colors.transparent,
      child: list[index].child,
    );
  }

  PlaceHolderWidget placeHolder(List<DraggableGridItem> list, int index) {
    return PlaceHolderWidget(
      child: Container(
        color: Colors.transparent,
      ),
    );
  }

  void onDragAccept(
      List<DraggableGridItem> list, int beforeIndex, int afterIndex) {
    log('onDragAccept: $beforeIndex -> $afterIndex');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DraggableGridViewBuilder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1.0,
        ),
        children: _listOfDraggableGridItem,
        dragCompletion: onDragAccept,
        isOnlyLongPress: true,
        dragFeedback: feedback,
        dragPlaceHolder: placeHolder,
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  const GridItem({super.key, required this.item});
  final AppItem item;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        color: Colors.transparent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.appDetail,
                    arguments: {
                      "app": item,
                    },
                  );
                },
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(item.imageUrl)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 4,),
              Text(
                item.title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}