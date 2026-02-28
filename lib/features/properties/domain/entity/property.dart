import 'package:core_package/core_package.dart';
import 'package:real_state/features/core/domain/entity/city.dart';
import 'package:real_state/features/user/domain/entity/user.dart';

import '../enum/property_enum.dart';

class Property {
  final String id;
  final String refNumber;
  final int price;
  final City city;
  final List<String> images;
  final String? cover;
  final String? neighborhood;
  final int size;
  final int room;
  final int bathrooms;
  final int? propertyAge;
  final PropertyType propertyType;
  final PropertyCategory category;
  final PropertyDeedType propertyDeedType;
  final PropertyStatus status;
  final bool isFeature;
  final int floor;
  final String? rejectReason;
  final String? notes;
  final String? address;
  final User owner;
  final LatLng coordinates;

  Property({
    required this.id,
    required this.refNumber,
    required this.price,
    required this.city,
    required this.images,
    this.cover,
    this.neighborhood,
    required this.size,
    required this.room,
    required this.bathrooms,
    this.propertyAge,
    required this.propertyType,
    required this.category,
    required this.propertyDeedType,
    required this.status,
    required this.isFeature,
    required this.floor,
    this.rejectReason,
    this.notes,
    this.address,
    required this.owner,
    required this.coordinates,
  });
}

// {
// "id": "9c3b4b47-436e-4990-bcb2-fb2b071289a1",
// "refNumber": "26",
// "price": 53228,
// "city": {
// "id": "5878fb54-6a88-4ee8-a77c-8ceb2ee6f687",
// "name": "ريف دمشق"
// },
// "images": [
// "a0c1fc59-3893-4cec-9f32-c4d81b097584",
// "ed7e53ac-ab6a-48d3-824d-963408395f48",
// "67b3c372-83e6-4632-b4bc-0f6a3e17f5c5"
// ],
// "cover": "5b0b0778-ba71-4d14-8c93-180f4e235a09",
// "neighborhood": "3711 Maryjane Skyway",
// "size": 63,
// "room": 10,
// "bathrooms": 5,
// "propertyAge": null,
// "propertyType": "shop",
// "category": "swap",
// "propertyDeedType": "green",
// "status": "unCompleted",
// "isFeature": false,
// "floor": 8,
// "rejectReason": null,
// "notes": null,
// "address": null,
// "owner": {
// "id": "e0ad6622-a404-4be5-bbec-92c66bf7ea0d",
// "name": "Ruby Smith",
// "email": null,
// "phone": "+963983006308",
// "role": "user",
// "createdAt": "2026-02-27T15:23:09.150Z",
// "isCompleted": true
// },
// "stocks": 1,
// "coordinates": {
// "lat": 35.17325,
// "lng": 36.83272
// }
// },
