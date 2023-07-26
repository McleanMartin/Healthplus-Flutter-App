import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:healthplus/controller/map_controller.dart';

const LatLng SOURCE_LOCATION = LatLng(42.7477863, -71.1699932);
const LatLng DEST_LOCATION = LatLng(42.743902, -71.170009);
const double CAMERA_ZOOM = 16;
const double CAMERA_TITLT = 80;
const double CAMERA_BEARING = 30;

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapController mapController = Get.put(MapController());
  late BitmapDescriptor markerIcon;

  @override
  void initState() {
    super.initState();
    mapController.fetchLocations();
  }

  void setMarkerIcon() async {
    markerIcon = await BitmapDescriptor.defaultMarker;
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
      target: SOURCE_LOCATION,
      bearing: CAMERA_BEARING,
      tilt: CAMERA_TITLT,
      zoom: CAMERA_ZOOM,
    );

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Obx(() => mapController.mapModel.isNotEmpty
                  ? GoogleMap(
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      compassEnabled: false,
                      tiltGesturesEnabled: true,
                      markers: mapController.markers,
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(mapController.mapModel.first.latitude,
                            mapController.mapModel.first.longitude),
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ))),
        ],
      ),
    );
  }
}
