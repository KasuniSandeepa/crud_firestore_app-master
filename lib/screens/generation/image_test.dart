import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import '../app_bar.dart';
import 'add_generation_form.dart';

class ImageSliderTest extends StatelessWidget {
  const ImageSliderTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Color(0xFF2C384A),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFF2C384A),
          title: AppBarTitle(
              sectionName: 'Add Generation'
          ),
        ),
        body: SafeArea(
         //child: Text("kgg"),
          child: 
          Column(
            children: [
              Text("kgg"),
              const SizedBox(height: 50.0),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
                child: ImageSlideshow(
                  width: double.infinity,
                  height: 200,
                  initialPage: 0,
                  indicatorColor: Colors.blue,
                  indicatorBackgroundColor: Colors.grey,
                  onPageChanged: (value) {
                    debugPrint('Page changed: $value');
                  },
                  //autoPlayInterval: 3000,
                  isLoop: true,
                  children: [
                    Image.asset(
                      'assets/blood _line.png',
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      'assets/blood line white.png',
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      'assets/blood_line_black.png',
                      fit: BoxFit.cover,
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
