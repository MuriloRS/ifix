import 'package:ifix/app/data/provider/httpProvider.dart';

class HttpRepository {
  final HttpProvider provider = HttpProvider();

  getDataFromMechanic(url) async {
    return await provider.getRequest(url);
  }
}
