class MapModel {
  MapModel({
    required this.id,
    required this.center,
    required this.latitude,
    required this.longitude,
  
  });

  late final int id;
  late final String center;
  late final double latitude;
  late final double longitude;
 

  MapModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    center = json['center'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['center'] = center;
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    return _data;
  }
}
