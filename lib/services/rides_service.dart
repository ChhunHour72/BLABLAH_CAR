import '../data/dummy_data.dart';
import '../model/ride/locations.dart';
import '../model/ride/ride.dart';

////
///   This service handles:
///   - The list of available rides
///
class RidesService {
  static List<Ride> availableRides = fakeRides; // TODO for now fake data

  static List<Ride> filterByDeparture(Location departure) {
    return availableRides.where((ride) => ride.departureLocation==(departure)).toList();
  }
    static List<Ride> filterBySeatRequested(int seatRequested) {
    return availableRides.where((ride) => ride.availableSeats >= seatRequested).toList();
  }

    static List<Ride> filterBy({Location? departure, int? seatRequested}) {
    if (departure != null && seatRequested != null){
    return availableRides.where((ride) => 
    ride.departureLocation.name == departure.name &&
    ride.availableSeats >= seatRequested).toList();
   }
   if(departure != null){
    return availableRides.where((ride) => ride.departureLocation.name == departure.name).toList();
   }
   if (seatRequested != null){
    return availableRides.where((ride) => ride.availableSeats >= seatRequested).toList();
   }
   return availableRides;
  }
}