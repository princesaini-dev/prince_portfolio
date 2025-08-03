import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonLoader extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final EdgeInsets? margin;
  final bool isCircle;

  const SkeletonLoader({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.margin,
    this.isCircle = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: margin ?? EdgeInsets.zero,
      child: Shimmer.fromColors(
        baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
        highlightColor: isDark ? Colors.grey[600]! : Colors.grey[100]!,
        period: const Duration(milliseconds: 1000),
        child: Container(
          width: width,
          height: height ?? 16,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: isCircle
                ? BorderRadius.circular((height ?? width ?? 16) / 2)
                : borderRadius ?? BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}

class PortfolioSkeleton extends StatelessWidget {
  const PortfolioSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Hero Section Skeleton
          Container(
            height: 500,
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SkeletonLoader(
                  width: 120,
                  height: 120,
                  isCircle: true,
                  margin: EdgeInsets.only(bottom: 24),
                ),
                const SkeletonLoader(
                  width: 200,
                  height: 32,
                  margin: EdgeInsets.only(bottom: 16),
                ),
                const SkeletonLoader(
                  width: 300,
                  height: 20,
                  margin: EdgeInsets.only(bottom: 8),
                ),
                const SkeletonLoader(
                  width: 250,
                  height: 20,
                  margin: EdgeInsets.only(bottom: 24),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SkeletonLoader(
                      width: 100,
                      height: 40,
                      borderRadius: BorderRadius.circular(20),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                    SkeletonLoader(
                      width: 100,
                      height: 40,
                      borderRadius: BorderRadius.circular(20),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // About Section Skeleton
          Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SkeletonLoader(
                  width: 150,
                  height: 28,
                  margin: EdgeInsets.only(bottom: 16),
                ),
                ...List.generate(4, (index) => SkeletonLoader(
                  width: double.infinity,
                  height: 16,
                  margin: EdgeInsets.only(bottom: 8),
                )),
                const SkeletonLoader(
                  width: 200,
                  height: 16,
                  margin: EdgeInsets.only(bottom: 24),
                ),
              ],
            ),
          ),

          // Projects Section Skeleton
          Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SkeletonLoader(
                  width: 120,
                  height: 28,
                  margin: EdgeInsets.only(bottom: 24),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) => Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonLoader(
                          width: double.infinity,
                          height: 80,
                          margin: EdgeInsets.only(bottom: 12),
                        ),
                        SkeletonLoader(
                          width: 120,
                          height: 18,
                          margin: EdgeInsets.only(bottom: 8),
                        ),
                        SkeletonLoader(
                          width: double.infinity,
                          height: 14,
                          margin: EdgeInsets.only(bottom: 4),
                        ),
                        SkeletonLoader(
                          width: 80,
                          height: 14,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Contact Section Skeleton
          Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SkeletonLoader(
                  width: 140,
                  height: 28,
                  margin: EdgeInsets.only(bottom: 24),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) => const SkeletonLoader(
                    width: 48,
                    height: 48,
                    isCircle: true,
                    margin: EdgeInsets.symmetric(horizontal: 8),
                  )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
