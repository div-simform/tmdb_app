import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final bool isApplyOnGrid;
  const ShimmerWidget({required this.isApplyOnGrid, super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      enabled: true,
      child: isApplyOnGrid
          ? GridView.builder(
              padding: const EdgeInsets.all(8),
              physics: const BouncingScrollPhysics(),
              itemCount: 20,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                childAspectRatio: 0.6,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                maxCrossAxisExtent: 200,
              ),
              itemBuilder: (context, index) {
                return const Card();
              },
            )
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: 4,
              itemBuilder: (_, __) {
                return const SizedBox(
                  height: 200,
                  width: 150,
                  child: Card(),
                );
              },
            ),
    );
  }
}
