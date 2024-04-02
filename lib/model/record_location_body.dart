class RecordLocationBody {
  double? longitude;
  double? latitude;

  RecordLocationBody({ this.longitude, this.latitude, });

  RecordLocationBody.fromJson(Map<String, dynamic> json) {
    longitude = json['longitude'].toDouble();
    latitude = json['latitude'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    return data;
  }
}
