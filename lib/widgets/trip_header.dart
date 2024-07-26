// import 'package:flutter/material.dart';

// class TripHeader extends StatelessWidget {
//   final String imageUrl;
//   final String tripTitle;
//   final String tripDates;
//   final bool isMobile;

//   const TripHeader({
//     super.key,
//     required this.imageUrl,
//     required this.tripTitle,
//     required this.tripDates,
//     required this.isMobile,
//   });

//   @override
//   Widget build(BuildContext context) {
//     Size screenSize = MediaQuery.of(context).size;

//     return Stack(
//       children: [
//         Container(
//           height: isMobile ? screenSize.height * 0.3 : screenSize.height * 0.3,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: NetworkImage(imageUrl),
//               fit: BoxFit.cover,
//               colorFilter: ColorFilter.mode(
//                   Colors.black.withOpacity(0.3), BlendMode.srcOver),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TripHeader extends StatelessWidget {
  final String imageUrl;
  final String tripTitle;
  final String tripDates;
  final bool isMobile;

  const TripHeader({
    super.key,
    required this.imageUrl,
    required this.tripTitle,
    required this.tripDates,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          height: isMobile ? screenSize.height * 0.3 : screenSize.height * 0.3,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(imageUrl),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3),
                BlendMode.srcOver,
              ),
            ),
          ),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3),
                    BlendMode.srcOver,
                  ),
                ),
              ),
            ),
            errorWidget: (context, url, error) => Image.asset(
              'assets/backgrounds/gradient.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        
      ],
    );
  }
}
