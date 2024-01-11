import 'package:flutter/material.dart';

import 'package:favourite_places/models/place.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PlaceDetailScreen extends StatelessWidget {
  PlaceDetailScreen({super.key, required this.place});

  final Place place;

  final String? mapKey = dotenv.get('GOOGLE_API_KEY');

  String get locationImage {
    final lat = place.location.latitude;
    final lng = place.location.longtitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng,NY&zoom=16&size=600x300&maptype=roadmap &markers=color:red%7Clabel:A%7C$lat,$lng&key=$mapKey';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Stack(
        children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(locationImage),
                ),
                Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black54,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Text(
                    place.location.address,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
