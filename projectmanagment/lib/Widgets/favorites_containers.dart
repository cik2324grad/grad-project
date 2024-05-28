import 'package:flutter/material.dart';

class FavoriteCategory extends StatelessWidget {
  const FavoriteCategory(
      {super.key,
      required this.color,
      required this.categoryName,
      required this.percantage});

  final Color? color;
  final String categoryName;
  final double percantage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
          9, 4.5, 9, 4.5), // Metnin etrafındaki boşluk miktarı
      decoration: BoxDecoration(
        color: color, // Arka plan rengi
        borderRadius: BorderRadius.circular(15), // Kenar yarıçapı
      ),
      child: Text(
        "${categoryName} ${100 - 5 * percantage}%",
        style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16 // Yazı rengi
            ),
        softWrap: true,
        overflow: TextOverflow.visible,
        textAlign: TextAlign.center,
      ),
    );
  }
}

/*
 Expanded(
                                      child: Text(
                                        "Spor Kategorisinde benzerliğiniz: ${100 - matchingViewModel.bestMatch[index].differences["Academic Courses"]! * 5}%",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight:
                                                FontWeight.w600 // Yazı rengi
                                            ),
                                        softWrap: true,
                                        overflow: TextOverflow.visible,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),

 */