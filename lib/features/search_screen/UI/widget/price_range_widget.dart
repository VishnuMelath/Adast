
import 'package:adast/features/search_screen/bloc/search_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../ themes/themes.dart';

class PriceRangeWidget extends StatefulWidget {
  final SearchBloc searchBloc;
  const PriceRangeWidget({super.key, required this.searchBloc});

  @override
  State<PriceRangeWidget> createState() => _PriceRangeWidgetState();
}

class _PriceRangeWidgetState extends State<PriceRangeWidget> {
  
  @override
  void initState() {
    super.initState();
     widget.searchBloc.priceRangeValues=RangeValues(widget.searchBloc.minPrice.toDouble(), widget.searchBloc.maxPrice.toDouble());
  }

  @override
  Widget build(BuildContext context) {
   
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Text('Price range',style: blackTextStyle,),
               Text('${widget.searchBloc.priceRangeValues.start.round()} - ${widget.searchBloc.priceRangeValues.end.round()} ',style: smallBlackTextStyle,)
             ],
           ),
          RangeSlider(
            divisions: 1000,
            min: widget.searchBloc.minPrice.toDouble(),
            max: widget.searchBloc.maxPrice.toDouble(),
            labels: RangeLabels(widget.searchBloc.priceRangeValues.start.round().toString(),
                widget.searchBloc.priceRangeValues.end.round().toString()),
            values: widget.searchBloc.priceRangeValues,
            onChanged: (value) {
              widget.searchBloc.priceRangeValues = value;
              setState(() {
                
              });
              
            },
          ),
        ],
      ),
    );
  }
}
