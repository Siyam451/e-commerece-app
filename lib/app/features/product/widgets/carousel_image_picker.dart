import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../app_color.dart';

class CarouselImagePicker extends StatefulWidget {
  const CarouselImagePicker({super.key, required this.imageUrls});
  final List<String> imageUrls;

  @override
  State<CarouselImagePicker> createState() => _CarouselImagePickerState();
}

class _CarouselImagePickerState extends State<CarouselImagePicker> {
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> _selectedIndex = ValueNotifier(0);
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(height: 200.0,
              autoPlay: false,//auto play hbe naa
              viewportFraction: 1,//ek time e ekta dekhabe slide
              onPageChanged: (index,reason){
                _selectedIndex.value = index;
              }
          ),

          items: widget.imageUrls.map((image) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        color: Colors.amber,
                      image: DecorationImage(image: NetworkImage(image),
                        fit: BoxFit.fitHeight,
                      )
                    ),

                );
              },
            );
          }).toList(),

        ),

        SizedBox(height: 10,),

        Positioned(
          bottom: 8,
          left: 0,
          right: 0,
          child: ValueListenableBuilder(valueListenable: _selectedIndex,
              builder: (context,selectIndex,_){
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for(int i=0; i<5; i++)//5ta slide ase aikane tai ,,protibar ek kore barbe
                      Container(
                          width: 12,
                          height: 12,
                          margin: EdgeInsets.only(right: 4),
                          decoration:BoxDecoration(
                            color:  i == selectIndex ? AppColors.themeColor : null,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(16),
                          )
                      )
                  ],
                );
              }),
        ),
      ],
    );
  }
}
