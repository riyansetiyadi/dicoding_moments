import 'package:dicoding_moments/common.dart';
import 'package:dicoding_moments/routes/page_manager.dart';
import 'package:dicoding_moments/utils/placemark_helper.dart';
import 'package:dicoding_moments/widgets/place_mark_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:geocoding/geocoding.dart' as geo;
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  final LatLng? currentLocation;
  final bool isFromDetailScreen;
  const MapScreen({
    super.key,
    this.currentLocation,
    this.isFromDetailScreen = false,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  late final Set<Marker> markers = {};

  LatLng? pickLocation;

  geo.Placemark? placemark;

  LatLng? initLocation;

  @override
  void initState() {
    super.initState();
    onMyLocationButtonPress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isFromDetailScreen
              ? PlacemarkHelper().getLocation(placemark) ?? "Google Maps"
              : AppLocalizations.of(context)?.mapFromPostTitle ?? "Google Maps",
        ),
      ),
      body: Center(
          child: (initLocation != null)
              ? Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition: CameraPosition(
                        zoom: 18,
                        target: initLocation!,
                      ),
                      markers: markers,
                      zoomControlsEnabled: false,
                      mapToolbarEnabled: false,
                      myLocationButtonEnabled: false,
                      myLocationEnabled: true,
                      onMapCreated: (controller) async {
                        final info = await geo.placemarkFromCoordinates(
                            initLocation!.latitude, initLocation!.longitude);

                        final place = info[0];
                        final street = place.street!;
                        final address =
                            '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

                        setState(() {
                          placemark = place;
                        });

                        defineMarker(initLocation!, street, address);

                        setState(() {
                          mapController = controller;
                        });
                      },
                      onLongPress: widget.isFromDetailScreen
                          ? null
                          : (LatLng latLng) => onLongPressGoogleMap(latLng),
                    ),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: FloatingActionButton(
                        child: const Icon(Icons.my_location),
                        onPressed: () => onMyLocationButtonPress(),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      right: 16,
                      left: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (placemark != null)
                            PlacemarkWidget(
                              placemark: placemark!,
                              onTap: () {
                                if (markers.isNotEmpty) {
                                  final latLng = markers.first.position;
                                  mapController.animateCamera(
                                    CameraUpdate.newLatLng(latLng),
                                  );
                                }
                              },
                            ),
                          if (!widget.isFromDetailScreen)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (pickLocation != null) {
                                    context.read<PageManager>().returnData(
                                          pickLocation!.toJson().toString(),
                                        );
                                    Navigator.pop(context);
                                  } else {
                                    final scaffoldMessenger =
                                        ScaffoldMessenger.of(context);
                                    scaffoldMessenger.showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          AppLocalizations.of(context)
                                                  ?.handleEmptyPickLocation ??
                                              "Please long-press to select a location or use the back button.",
                                        ),
                                      ),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .mapFromPostTitle,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                )
              : const CircularProgressIndicator()),
    );
  }

  void onLongPressGoogleMap(LatLng latLng) async {
    final info =
        await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    final place = info[0];
    final street = place.street!;
    final address =
        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

    setState(() {
      pickLocation = latLng;
      placemark = place;
    });

    defineMarker(latLng, street, address);

    mapController.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );
  }

  void onMyLocationButtonPress() async {
    try {
      final Location location = Location();
      late bool serviceEnabled;
      late PermissionStatus permissionGranted;
      late LocationData locationData;

      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          if (context.mounted) {
            final scaffoldMessenger = ScaffoldMessenger.of(context);
            scaffoldMessenger.showSnackBar(
              const SnackBar(
                content: Text(
                  "Location services is not available",
                ),
              ),
            );
          }
          return;
        }
      }

      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          if (context.mounted) {
            final scaffoldMessenger = ScaffoldMessenger.of(context);
            scaffoldMessenger.showSnackBar(
              const SnackBar(
                content: Text(
                  "Location permission is denied",
                ),
              ),
            );
          }
          return;
        }
      }

      locationData = await location.getLocation();
      final latLng = LatLng(locationData.latitude!, locationData.longitude!);

      if (!widget.isFromDetailScreen) {
        final info = await geo.placemarkFromCoordinates(
            latLng.latitude, latLng.longitude);

        final place = info[0];
        final street = place.street!;
        final address =
            '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

        setState(() {
          pickLocation = latLng;
          placemark = place;
        });

        defineMarker(latLng, street, address);
      }

      if (initLocation == null && widget.currentLocation == null) {
        setState(() {
          initLocation = latLng;
        });
      } else if (initLocation == null && widget.currentLocation != null) {
        setState(() {
          initLocation = widget.currentLocation;
        });
      } else {
        mapController.animateCamera(
          CameraUpdate.newLatLng(latLng),
        );
      }
    } catch (e) {
      if (context.mounted) {
        final scaffoldMessenger = ScaffoldMessenger.of(context);
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text(
              "Error $e",
            ),
          ),
        );
      }
    }
  }

  void defineMarker(LatLng latLng, String street, String address) {
    final marker = Marker(
      markerId: const MarkerId("source"),
      position: latLng,
      infoWindow: InfoWindow(
        title: street,
        snippet: address,
      ),
    );

    setState(() {
      markers.clear();
      markers.add(marker);
    });
  }
}
