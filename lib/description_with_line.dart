import 'package:flutter/material.dart';
import 'app_colors.dart';
class DescriptionWithLine extends StatelessWidget {
  final String description;
  final double positionX;
  final double positionY;
  final double chartHeight;
  final double chartWidth;

  const DescriptionWithLine({
    super.key,
    required this.description,
    required this.positionX,
    required this.positionY,
    required this.chartHeight,
    required this.chartWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 수직선
        Positioned(
          left: positionX+50,
          bottom: positionY+40,
          child: Container(
            height: chartHeight - positionY,
            width: 1,
            color: AppColors.mainBlue,
          ),
        ),
        // 설명 텍스트
        Positioned(
          left: positionX+50,
          bottom: positionY+40, // 텍스트의 위치 조정
          child: Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.mainBlue, width: 1),
              borderRadius: BorderRadius.circular(2.0),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Text(
                  description,
                  style: const TextStyle(
                    color: AppColors.mainBlue,
                    fontSize: 9,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
