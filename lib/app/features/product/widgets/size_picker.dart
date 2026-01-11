import 'package:ecommerce_project/app/app_color.dart';
import 'package:flutter/material.dart';

class SizePicker extends StatefulWidget {
  const SizePicker({super.key, required this.Sizes, required this.onChange});
  final List<String> Sizes;
  final Function (String) onChange; //aita color select korle jate change hoi tai use kora hoi

  @override
  State<SizePicker> createState() => _SizePickerState();
}

class _SizePickerState extends State<SizePicker> {
  String? _selectedSize;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for(String color in widget.Sizes)
          GestureDetector(
            onTap: (){
              _selectedSize = color;
              widget.onChange(_selectedSize!);
              setState(() {

              });

            },

            child: Container(
              margin: EdgeInsets.only(right: 4),
              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.grey),
                color: _selectedSize == color ? AppColors.themeColor : null, //button e click krle ki hbe ta
              ),
              child: Text(color,style: TextStyle(color: _selectedSize == color ? Colors.white : null),),
            ),

          )
      ],
    );
  }
}


