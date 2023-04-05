import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class VisitorShimmer extends StatelessWidget {
  final size;

  VisitorShimmer({Key? key,
    this.size = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: ListView.builder(
        padding: const EdgeInsets.all(4),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: size,
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
          width: Get.width,
          height: 100,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                left: 25,
                child: Container(
                  height: 120,
                  width: Get.width - 45,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const Positioned(
                left: 0,
                top: 10,
                child:  CircleAvatar(
                  backgroundImage: null,
                  radius: 28,
                  backgroundColor: Colors.white,
                )

              ),
            ],
          ),
        ),
        ),
      ),
    );
  }
}
