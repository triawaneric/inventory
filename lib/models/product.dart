class Product {
  final int deviceId;
  final String deviceName;
  final String deviceType;
  final String deviceLocation;
  final String status;

  Product(
      this.deviceId,
      this.deviceName,
      this.deviceType,
      this.deviceLocation,
      this.status);
  factory Product.fromMap(Map<String, dynamic> json) {
    return Product(
      json['device_id'],
      json['device_name'],
      json['device_type'],
      json['device_location'],
      json['status'],
    );
  }






  Map<String, dynamic> toMap() => {
    "device_id": deviceId,
    "device_name": deviceName,
    "device_type": deviceType,
    "device_location": deviceLocation,
    "status": status,
  };
}


