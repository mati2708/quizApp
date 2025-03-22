import 'dart:ui';

import 'package:flutter/material.dart';

class OptionTile extends StatefulWidget {
  late final String option, description, corectAnswer, optionSelected;
  OptionTile({ required this.corectAnswer, required this.description, required this.optionSelected,required this.option, super.key});

  @override
  State<OptionTile> createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              border: Border.all(color: widget.description == widget.optionSelected ? widget.optionSelected == widget.corectAnswer ? Colors.green.withOpacity(0.7) : Colors.red.withOpacity(0.7) : Colors.grey, width: 1.4),
              borderRadius: BorderRadius.circular(30)
            ),
            alignment: Alignment.center,
            child: Text("${widget.option}",
            style: TextStyle(
              color: widget.optionSelected ==widget.description ? widget.corectAnswer == widget.optionSelected ? Colors.green.withOpacity(0.7) : Colors.red : Colors.grey
            ),),
          ),
          SizedBox(width: 8,),
          Text(widget.description, style: TextStyle(fontSize: 17, color: Colors.black54),)
        ],
      ),
    );
  }
}