import 'package:flutter/material.dart';

import '../../../../model/ride/locations.dart';
import '../../../../model/ride_pref/ride_pref.dart';
import 'package:blabla/utils/date_time_utils.dart';
import 'package:blabla/ui/widgets/display/bla_divider.dart';
import 'package:blabla/ui/theme/theme.dart';
import 'package:blabla/ui/screens/ride_location_picker.dart';
///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    // TODO
    
    departure = widget.initRidePref?.departure;
    departureDate = widget.initRidePref?.departureDate ?? DateTime.now();
    arrival = widget.initRidePref?.arrival;
    requestedSeats = widget.initRidePref?.requestedSeats ?? 1;
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  Future<void> selectDate() async {
    final DateTime? datePicked = await showDatePicker(
      context: context, 
      initialDate: departureDate,
      firstDate: DateTime.now(), 
      lastDate: DateTime.now().add(Duration(days: 365))
    );
    if (datePicked != null && datePicked != departureDate) {
      setState(() {
        departureDate = datePicked;
      });
    }
  }

   void selectDeparture() async {
    final leaving = await Navigator.of(context).push(
      MaterialPageRoute(builder: (builder) => RideLocationPicker())
    );
    setState(() {
      if (leaving != null) {
        departure = leaving;
      }
    });
  }
  void selectArrival() async {
    final going = await Navigator.of(context).push(
      MaterialPageRoute(builder: (builder) => RideLocationPicker())
    );
    setState(() {
      if (going != null) {
        arrival = going;
      }
    });
  }
  
  void swapLocation() async {
    setState(() {
      if ( departure != null && arrival != null ) {
        final swap = departure;
        departure = arrival;
        arrival = swap;
      }
    });
  }
  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(BlaSpacings.s),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [ 
              _onClickButton(
                text: departure?.name ?? 'Leaving from',
                icon: Icons.circle_outlined,
                onPressed: selectDeparture,
              ),
              BlaDivider(),
              _onClickButton(
                text: arrival?.name ?? 'Going to',
                icon: Icons.circle_outlined,
                onPressed: selectArrival,
              ),
              BlaDivider(),
              _onClickButton(
                icon: Icons.calendar_month, 
                text: DateTimeUtils.formatDateTime(departureDate),
                onPressed: selectDate
              ),
              BlaDivider(),
              _onClickButton(
                icon: Icons.people_alt, 
                text: '1'
              )
            ]
          )
        ),
        Positioned(
          right: 10,
          top: 15,
          child: InkWell(
            onTap: swapLocation,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Icon(
                Icons.swap_vert,
                color: BlaColors.primary,
                size: 22,
              ),
            ),
          ),
        ),
      ],
    );
  }
}


Widget _onClickButton({
  required IconData icon,
  required String text,
  VoidCallback? onPressed
}) { 
  return TextButton(
    onPressed: onPressed ?? () {},
    child: ListTile(
      leading: Icon(icon),
      title: Text(text),
      contentPadding: EdgeInsets.all(0),
    ),
  );
}
