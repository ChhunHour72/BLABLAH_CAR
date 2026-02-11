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
  List<Location> location = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  void filterLocation(String query) {
    setState(() {
      if (query.isEmpty) {
        location = [];
      } else {
        location = fakeLocations.where((element) => element.name.toLowerCase().contains(query.toLowerCase())).toList();
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
            Container(
              height: 45,
              decoration: BoxDecoration(
                color: BlaColors.greyLight,
                borderRadius: BorderRadius.circular(10)
              ),
              alignment: Alignment.center,
              child:  TextField(
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
              )
            ),
            Expanded(
              child: ListView.builder(
                itemCount: location.length,
                itemBuilder: (context, index) {
                  final locationList = location[index];
                  return ListTile(
                    title: Text(locationList.name),
                    subtitle: Text(locationList.country.name),
                    trailing: Icon(Icons.arrow_forward_rounded, size: 20,),
                    onTap: () {
                      Navigator.of(context).pop(locationList);
                    },
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}