import 'dart:ui';

import 'package:flutter/material.dart';

String getImageForTitle(String title) {
  switch (title.toLowerCase().trim()) {
    case 'brushing teeth':
      return 'lib/assets/teeth.png';
    case 'bathing & hygiene':
      return 'lib/assets/bathing.png';
    case 'eating food':
      return 'lib/assets/food.png';
    case 'going to bed':
      return 'lib/assets/sleeping.png';
    case 'time to wake up':
      return 'lib/assets/alarm.png';
    default:
      return 'assets/images/default.png';
  }
}
// String getCategoryImage(String category) {
//   switch (category.toLowerCase()) {
//     case 'daily routine':
//       return 'lib/assets/nature1.jpg';
//     // case 'animals':
//     //   return 'assets/images/animals.png';
//     // case 'visual games':
//     //   return 'assets/images/visual_games.png';
//     // case 'numbers & counting':
//     //   return 'assets/images/numbers.png';
//     // case 'alphabets':
//     //   return 'assets/images/alphabets.png';
//     // case 'cognitive skills':
//     //   return 'assets/images/cognitive.png';
//     // case 'safety & awareness':
//     //   return 'assets/images/safety.png';
//     // case 'science':
//     //   return 'assets/images/science.png';
//     default:
//       return 'assets/images/default.png';
//   }
// }



final List<Color> containerColors = [
   Color.fromARGB(255, 52, 149, 162),        
  const Color(0xFFC8E6C9),       
  const Color(0xFFBBDEFB),        
  const Color(0xFFFFE0B2),         
  const Color(0xFFE1BEE7),         
  const Color(0xFFB2DFDB),         
  const Color(0xFFFCF8DD),         
  const Color(0xFFFFF9C4),         
  const Color(0xFFF8BBD0),       
  const Color(0xFFB2EBF2),       
  const Color(0xFFF0F4C3),      
];
