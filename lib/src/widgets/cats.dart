import 'package:flutter/material.dart';

class Cat extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    //Imagem da internet
    
    return Image.network(
      'https://i.imgur.com/QwhZRyL.png'
    );   
  }

}
