import 'package:flutter/material.dart';
import 'package:slideshow/widgets/slideshow.dart';
import 'package:file_picker/file_picker.dart';

class SlideShowPage extends StatelessWidget {
  final List<String> images;

  const SlideShowPage(this.images, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SlideShow(
        images: images,
        timePerImage: const Duration(seconds: 5),
      ),
    );
  }
}
