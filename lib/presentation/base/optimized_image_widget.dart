import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OptimizedImageWidget extends StatelessWidget {
  final String? imageUrl;
  final String? assetPath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final bool enableMemoryCache;
  final Duration fadeInDuration;

  const OptimizedImageWidget({
    super.key,
    this.imageUrl,
    this.assetPath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.enableMemoryCache = true,
    this.fadeInDuration = const Duration(milliseconds: 300),
  }) : assert(imageUrl != null || assetPath != null, 'Either imageUrl or assetPath must be provided');

  @override
  Widget build(BuildContext context) {
    final borderRadiusValue = borderRadius ?? BorderRadius.circular(8);

    if (imageUrl != null) {
      return ClipRRect(
        borderRadius: borderRadiusValue,
        child: CachedNetworkImage(
          imageUrl: imageUrl!,
          width: width,
          height: height,
          fit: fit,
          memCacheWidth: enableMemoryCache ? (width?.toInt() ?? 800) : null,
          memCacheHeight: enableMemoryCache ? (height?.toInt() ?? 600) : null,
          fadeInDuration: fadeInDuration,
          placeholder: (context, url) => _buildShimmerPlaceholder(),
          errorWidget: (context, url, error) => _buildErrorWidget(),
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: borderRadiusValue,
              image: DecorationImage(
                image: imageProvider,
                fit: fit,
              ),
            ),
          ),
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: borderRadiusValue,
        child: Image.asset(
          assetPath!,
          width: width,
          height: height,
          fit: fit,
          cacheWidth: enableMemoryCache ? (width?.toInt() ?? 800) : null,
          cacheHeight: enableMemoryCache ? (height?.toInt() ?? 600) : null,
          errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
        ),
      );
    }
  }

  Widget _buildShimmerPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: borderRadius ?? BorderRadius.circular(8),
      ),
      child: const Icon(
        Icons.error_outline,
        color: Colors.grey,
        size: 32,
      ),
    );
  }
}
