import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({
    super.key,
    required this.count,
    required this.builder,
  });

  final int count;

  final Widget? Function(BuildContext context, int index, int x, int y) builder;

  @override
  Widget build(BuildContext context) {
    return CardSwiper(
      cardsCount: count,
      cardBuilder: builder,
    );
  }
}
