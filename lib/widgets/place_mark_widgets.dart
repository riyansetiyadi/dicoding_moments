import 'package:dicoding_moments/utils/placemark_helper.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;

class PlacemarkWidget extends StatelessWidget {
  const PlacemarkWidget({
    super.key,
    required this.placemark,
    this.borderRadiusContainer = const BorderRadius.all(Radius.circular(20)),
    this.boxShadowContainer = const <BoxShadow>[
      BoxShadow(
        blurRadius: 20,
        offset: Offset.zero,
        color: Color.fromARGB(127, 158, 158, 158),
      )
    ],
    this.onTap,
  });

  final geo.Placemark placemark;
  final BorderRadius? borderRadiusContainer;
  final List<BoxShadow>? boxShadowContainer;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(maxWidth: 700),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadiusContainer,
          boxShadow: boxShadowContainer,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    placemark.street!,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    PlacemarkHelper().formatPlacemark(placemark),
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
