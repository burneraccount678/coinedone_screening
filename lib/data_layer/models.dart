// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  DataModel({
    required this.success,
    required this.data,
  });

  bool success;
  Data data;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.screenTime,
    required this.freeTime,
    required this.devices,
  });

  ScreenTime screenTime;
  FreeTime freeTime;
  List<Device> devices;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        screenTime: ScreenTime.fromJson(json["screenTime"]),
        freeTime: FreeTime.fromJson(json["freeTime"]),
        devices:
            List<Device>.from(json["devices"].map((x) => Device.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "screenTime": screenTime.toJson(),
        "freeTime": freeTime.toJson(),
        "devices": List<dynamic>.from(devices.map((x) => x.toJson())),
      };
}

class Device {
  Device({
    required this.name,
    required this.usage,
  });

  String name;
  int usage;

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        name: json["name"],
        usage: json["usage"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "usage": usage,
      };
}

class FreeTime {
  FreeTime({
    required this.limit,
    required this.usage,
  });

  int limit;
  int usage;

  factory FreeTime.fromJson(Map<String, dynamic> json) => FreeTime(
        limit: json["limit"],
        usage: json["usage"],
      );

  Map<String, dynamic> toJson() => {
        "limit": limit,
        "usage": usage,
      };
}

class ScreenTime {
  ScreenTime({
    required this.screenTimeClass,
    required this.study,
    required this.free,
    required this.total,
  });

  int screenTimeClass;
  int study;
  int free;
  int total;

  factory ScreenTime.fromJson(Map<String, dynamic> json) => ScreenTime(
        screenTimeClass: json["class"],
        study: json["study"],
        free: json["free"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "class": screenTimeClass,
        "study": study,
        "free": free,
        "total": total,
      };
}
