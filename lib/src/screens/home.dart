import 'package:flutter/material.dart';
import '../widgets/cats.dart';
import 'dart:math';

//Ler Documentação da Classe Stack no flutter

class Home extends StatefulWidget{  

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  //Buscar no manual do flutter documentação das classes Animation e Animation Controller
  Animation<double> catAnimation;
  AnimationController catController;

  Animation<double> boxAnimation;
  AnimationController boxController;


  //Método da classe State
  @override
  void initState() {    
    super.initState();
    catController = AnimationController(
      duration: Duration(milliseconds: 200),
      //Parametro da Classe TickerProvider
      vsync: this,
    );

     catAnimation = Tween(begin: -30.0 , end: -83.0).animate(
        CurvedAnimation(
          parent: catController,
          curve: Curves.easeIn,
          ),
     );

     boxController = AnimationController(
        duration: Duration(milliseconds: 300),
        vsync: this,
      );

      boxAnimation = Tween( begin: pi * 0.6, end: pi * 0.65).animate(
        CurvedAnimation(
            parent: boxController,
            curve: Curves.easeInOut,
        ),
      );
      boxAnimation.addStatusListener((status) { 
        if(status == AnimationStatus.completed){
          boxController.reverse();
        }
        else if(status == AnimationStatus.dismissed){
           boxController.forward();
        }
      });
      boxController.forward();
     
  }

  onTap(){
    
    

    if(catController.status == AnimationStatus.completed){
      catController.reverse();
      boxController.forward();
    }
    else if(catController.status == AnimationStatus.dismissed){
        catController.forward();
        boxController.stop();
    }
    
    
  }


  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      body: GestureDetector (
        onTap: onTap,
          child: Center(
              child: Stack(
                //Não corta o widget ao sair do limite do stack
                overflow: Overflow.visible,
                children:  [  
                  buildCatAnimation(),
                  buildBox(),
                  buidLeftFlap(),
                  buidRightFlap(),
                ],
            ),
          ),
        )
    );
  }

  Widget buildCatAnimation(){
      return AnimatedBuilder(animation: catAnimation, 
        builder: (context, child){
          return Positioned(            
            child: child,
            top : catAnimation.value, 
            //Define os limites e redimensiona o tamanho do widget se necessário
            right: 0.0,
            left: 0.0,
          );

        },
        child: Cat(),
      );
  }

  Widget buildBox(){
    return Container(
      height: 200.0,
      width: 200.0,
      color: Colors.brown,

    );
  }

  // Para girar um widge podemos usar a classe Transform 
  //ou podemos usar uma classe chamada RotatedBox

  Widget buidLeftFlap(){    
    return Positioned (
      left: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,      
        child:Container(
          height: 10.0,
          width: 125.0,
          color: Colors.brown,
        ),
        builder: (context, child){
          return Transform.rotate(
            child: child,
            angle: boxAnimation.value,            
            alignment: Alignment.topLeft,
          );
        },
    ),
    );
  }

   Widget buidRightFlap(){    
    return Positioned (
      right: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,      
        child:Container(
          height: 10.0,
          width: 125.0,
          color: Colors.brown,
        ),
        builder: (context, child){
          return Transform.rotate(
            child: child,
            angle: - boxAnimation.value,            
            alignment: Alignment.topRight,
          );
        },
    ),
    );
  }
  

}