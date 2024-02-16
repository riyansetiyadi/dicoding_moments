import 'package:geocoding/geocoding.dart' as geo;

class PlacemarkHelper {
  String formatPlacemark(geo.Placemark placemark) {
    StringBuffer address = StringBuffer();
    if (placemark.subLocality != null) {
      if (placemark.subLocality!.isNotEmpty) {
        address.write(placemark.subLocality);
        address.write(', ');
      }
    }
    if (placemark.locality != null) {
      if (placemark.locality!.isNotEmpty) {
        address.write(placemark.locality);
        address.write(', ');
      }
    }
    if (placemark.postalCode != null) {
      if (placemark.postalCode!.isNotEmpty) {
        address.write(placemark.postalCode);
        address.write(', ');
      }
    }
    if (placemark.country != null) {
      if (placemark.country!.isNotEmpty) {
        address.write(placemark.country);
      }
    }
    return address.toString();
  }

  String? getLocation(geo.Placemark? placemark) {
    if (placemark != null) {
      if (placemark.locality != null ||
          placemark.administrativeArea != null ||
          placemark.country != null ||
          placemark.name != null ||
          placemark.street != null) {
        if (placemark.locality!.isNotEmpty) {
          return placemark.locality;
        } else if (placemark.administrativeArea!.isNotEmpty) {
          return placemark.administrativeArea;
        } else if (placemark.country!.isNotEmpty) {
          return placemark.country;
        } else if (placemark.name!.isNotEmpty) {
          return placemark.name;
        } else if (placemark.street!.isNotEmpty) {
          return placemark.street;
        }
      }
    }
    return null;
  }
}
