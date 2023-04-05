import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class VisitorCountShimmer extends StatelessWidget {
  final size;

  const VisitorCountShimmer({
    Key? key,
    this.size = 2,
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
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: size,
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 160,
            height: 200,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  top: 40,
                  child: Container(
                    width: 150,
                    height: 150,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(10, 20),
                            blurRadius: 10,
                            spreadRadius: 0,
                            color: Colors.grey.withOpacity(.05)),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  height: 80,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
