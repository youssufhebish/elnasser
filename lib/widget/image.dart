import 'package:cached_network_image/cached_network_image.dart';
import 'package:elnasser/constants/image_constants.dart';
import 'package:elnasser/helpers/commons.dart';
import 'package:elnasser/screens/initial_pages/splash/splash_bloc/splash_cubit.dart';
import 'package:flutter/material.dart';

class ApiImage extends StatelessWidget {
  ApiImage(
      {Key? key,
      required this.type,
      required this.folderName,
      required this.image,
      this.borderRadius = 0.0,
      this.boxFit = BoxFit.cover})
      : super(key: key);
  final String folderName;
  final String type;
  final String? image;
  double borderRadius;
  BoxFit boxFit;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl:
            "${SplashCubit.get(context).theInitialModel.data!.account!.accountsWebsiteUrl!}/uploads/${Commons.accountId}/$folderName/$type/$image",
        fit: boxFit,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) =>
            Image.asset(ImageConstants.alnasserLogoNoImage),
      ),
    );
  }
}

ImageProvider AttributesImage({
  required String folderName,
  required String type,
  required String? image,
}) {
  return NetworkImage(
    "${Commons.baseUrl}uploads/${Commons.accountId}/$folderName/$type/$image",
  );
}
