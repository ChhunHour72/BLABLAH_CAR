import 'package:blabla/data/dummy_data.dart';
import 'package:blabla/model/ride/locations.dart';
import 'package:blabla/ui/theme/theme.dart';
import 'package:flutter/material.dart';

class RideLocationPicker extends StatefulWidget {
  const RideLocationPicker({super.key});

  @override
  State<RideLocationPicker> createState() => _RideLocationPickerState();
}

class _RideLocationPickerState extends State<RideLocationPicker> {
  final TextEditingController searchController = TextEditingController();
  List<Location> filteredLocations = [];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void filterLocation(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredLocations = [];
      } else {
        filteredLocations = fakeLocations
            .where((loc) => loc.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(BlaSpacings.m),
        child: Column(
          children: [
            // Search bar
            Container(
              height: 45,
              decoration: BoxDecoration(
                color: BlaColors.greyLight,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: TextField(
                controller: searchController,
                onChanged: filterLocation,
                decoration: InputDecoration(
                  hintText: 'Station Road or The Bridge Cafe',
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ),

            // Results list
            Expanded(
              child: ListView.builder(
                itemCount: filteredLocations.length,
                itemBuilder: (context, index) {
                  final loc = filteredLocations[index];
                  return ListTile(
                    title: Text(loc.name),
                    subtitle: Text(loc.country.name),
                    trailing: const Icon(Icons.arrow_forward_rounded, size: 20),
                    onTap: () => Navigator.of(context).pop(loc),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}