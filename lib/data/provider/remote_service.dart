import 'package:http/http.dart' as http;
import 'package:usta_bor_android/data/model/ios_version_model.dart';


class RemoteService{

    static var client = http.Client();

static Future<IOSVersionCheck?> iOSVersionCheck()  async {

  var request = http.Request('GET', Uri.parse('https://itunes.apple.com/lookup?bundleId=com.rideauction.Ustabor'));


  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String a = await response.stream.bytesToString();
return iOSVersionCheckFromJson(a);
  }
  else {
   return null;
  }



}

  }