import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/common/app_colors.dart';

class PersonCacheImage extends StatelessWidget {
  const PersonCacheImage({
    Key? key,
    this.imageUrl,
    this.width = 160,
    this.height = 160,
  }) : super(key: key);

  final String? imageUrl;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) => CachedNetworkImage(
        imageUrl: imageUrl ?? '',
        height: height,
        width: width,
        imageBuilder: (context, imageProvider) => _imageWidget(imageProvider: imageProvider),
        placeholder: (context, _) => const Center(
          child: CircularProgressIndicator(
            color: AppColors.grey,
          ),
        ),
        errorWidget: (context, url, error) =>
            _imageWidget(imageProvider: const AssetImage("assets/images/noimages.jpg")),
      );

  Widget _imageWidget({required ImageProvider imageProvider}) => Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            bottomLeft: Radius.circular(8),
          ),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          )
        ),
      );
}
