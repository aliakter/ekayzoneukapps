import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ShowImage extends StatefulWidget {
  const ShowImage({Key? key, required this.initialIndex}) : super(key: key);
  final int initialIndex;

  @override
  ShowImageState createState() => ShowImageState();
}

class ShowImageState extends State<ShowImage> {
  final pageController = PageController();

  @override
  void initState() {
    currentPage = widget.initialIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF28282B),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black87),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        systemOverlayStyle: Platform.isIOS
            ? SystemUiOverlayStyle.dark
            : const SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark),
      ),
      body: SafeArea(
        child: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              // imageProvider: NetworkImage(widget.galleries[currentPage].imageUrl),
              imageProvider: const NetworkImage(""),
              initialScale: PhotoViewComputedScale.contained * 1,
              // heroAttributes: PhotoViewHeroAttributes(tag: widget.galleries[currentPage].id),
              heroAttributes: const PhotoViewHeroAttributes(tag: "1"),
            );
          },
          itemCount: 10,
          loadingBuilder: (context, event) => Center(
            child: SizedBox(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(
                value: event == null
                    ? 0
                    : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
              ),
            ),
          ),
          pageController: pageController,
          onPageChanged: (value) {
            setState(() {
              currentPage = value;
            });
          },
        ),
      ),
    );
  }

  int currentPage = 0;

  AnimatedContainer buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(microseconds: 500),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 12 : 6,
      decoration: ShapeDecoration(
        color: currentPage == index
            ? Colors.lightGreen
            : Colors.lightGreen.withOpacity(0.3),
        shape: const StadiumBorder(),
      ),
    );
  }
}
