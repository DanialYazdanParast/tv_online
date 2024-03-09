import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = SwiperController();
    return Stack(alignment: AlignmentDirectional.bottomCenter, children: [
      SizedBox(
        height: 220,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "assets/$index.jpg",
                  fit: BoxFit.fill,
                ),
              ),
            );
          },
          itemCount: 3,
          autoplay: true,
          viewportFraction: 0.9,
          controller: controller,
          pagination: SwiperPagination(margin: EdgeInsets.all(15.0)),
        ),
      ),
      // Positioned(
      //   bottom: 10,
      //   child: SmoothPageIndicator(
      //     controller: controller,
      //     count: 3,
      //     effect:  ExpandingDotsEffect(
      //         expansionFactor: 4,
      //         dotHeight: 6,
      //         dotWidth: 6,
      //         dotColor: Colors.white,
      //         activeDotColor: Colors.black),
      //   ),
      // ),
    ]);
  }
}
