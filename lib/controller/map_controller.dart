import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:healthplus/models/map_model.dart';
import 'package:http/http.dart' as http;

class MapController extends GetxController {
  List<MapModel> mapModel = <MapModel>[].obs;
  var markers = RxSet<Marker>();
  var isLoading = false.obs;

  fetchLocations() async {
    try {
      isLoading(true);
      http.Response response =
          await http.get(Uri.tryParse('http://powerapi.pythonanywhere.com/api/locations')!);
      if (response.statusCode == 200) {
        ///data successfully
        var result = jsonDecode(response.body);
        log(result.toString());
        print(result.toString());
        mapModel.addAll(RxList<Map<String, dynamic>>.from(result)
            .map((e) => MapModel.fromJson(e))
            .toList());
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
      isLoading(false);
      createMarkers();
    }
  }

  createMarkers() {
    mapModel.forEach((element) {
      markers.add(Marker(
        markerId: MarkerId(element.id.toString()),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(element.latitude, element.longitude),
        infoWindow: InfoWindow(title: element.center),
        onTap: () {
          print('marker tapped');
        },
      ));
    });
  }
}
