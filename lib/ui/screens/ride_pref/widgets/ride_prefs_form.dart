import 'package:flutter/material.dart';

import '../../../../model/ride/locations.dart';
import '../../../../model/ride_pref/ride_pref.dart';
import 'package:blabla/utils/date_time_utils.dart';
import 'package:blabla/ui/widgets/display/bla_divider.dart';
import 'package:blabla/ui/theme/theme.dart';
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


   void selectDeparture() async {
  }
  void selectArrival() async {
  }
  
  void swapLocation() async {
  }
  void selectDate() async {
  }
  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  // ----------------------------------
  // Build the widgets
  // ----------------------------------

  Widget _buildRow({
    required IconData icon,
    required String text,
    VoidCallback? onPressed,
  }) {
    return TextButton(
      onPressed: onPressed ?? () {},
      child: ListTile(
        leading: Icon(icon),
        title: Text(text),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Form inputs
        Padding(
          padding: EdgeInsets.all(BlaSpacings.s),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildRow(
                icon: Icons.circle_outlined,
                text: departure?.name ?? 'Leaving from',
                onPressed: selectDeparture,
              ),
              const BlaDivider(),
              _buildRow(
                icon: Icons.circle_outlined,
                text: arrival?.name ?? 'Going to',
                onPressed: selectArrival,
              ),
              const BlaDivider(),
              _buildRow(
                icon: Icons.calendar_month,
                text: DateTimeUtils.formatDateTime(departureDate),
                onPressed: selectDate,
              ),
              const BlaDivider(),
              _buildRow(
                icon: Icons.people_alt,
                text: '$requestedSeats',
              ),
            ],
          ),
        ),

        // Swap button
        Positioned(
          right: 10,
          top: 15,
          child: InkWell(
            onTap: (){},
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
