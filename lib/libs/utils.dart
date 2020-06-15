import 'package:google_place/google_place.dart';

class Utils {
  static String formatDistance(double distance) {
    return (distance / 1000).toStringAsFixed(2) + ' km';
  }

  static List<Map<String, dynamic>> convertSearchResultToMap(
      List<SearchResult> listSearchResult) {
    List<Map<String, dynamic>> result = new List();

    listSearchResult.forEach((element) {
      result.add({
        "name": element.name,
        "latitude": element.geometry.location.lat,
        "longitude": element.geometry.location.lng,
        "id": element.id,
        "placeid": element.placeId,
        "rating": element.rating,
        "nRating": element.userRatingsTotal,
        "formattedAddress": element.vicinity,
        "weekdayText":
            element.openingHours != null ? element.openingHours.weekdayText : ''
      });
    });

    return result;
  }

  static String formatAddress(address) {
    return address.toString().split(',').elementAt(0).toString() +
        ', ' +
        address.toString().split(',').elementAt(1).toString();
  }

  static bool isCellphoneNumber(phone) {
    phone = formatPhone(phone);
    return phone.length == 11;
  }

  static String formatPhone(phone){
    return phone.toString().replaceAll("(", "").replaceAll(")", "").replaceAll("-", "").replaceAll(" ", "");
  }
}
