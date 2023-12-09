import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(42.50655514080855, 27.465892134392316),
        maxZoom: 16.0,
        minZoom: 2.0,
        zoom: 13.0,
      ),
      children: [
        TileLayer(
          urlTemplate:
          'https://cartodb-basemaps-{s}.global.ssl.fastly.net/rastertiles/voyager/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        PolygonLayer(
          polygons: [

            Polygon(
              points: [
                const LatLng(42.5156267,  27.461691),
                const LatLng(42.5147131,  27.4596834),
                const LatLng(42.5138591,  27.4589305),
                const LatLng(42.5130973,  27.4606287),
                const LatLng(42.5129378,  27.4604934),
                const LatLng(42.5127955,  27.4602842),
                const LatLng(42.5126769,  27.4600482),
                const LatLng(42.5126136,  27.4597639),
                const LatLng(42.5125661,  27.4595332),
                const LatLng(42.5124642,  27.4593335),
                const LatLng(42.5121214,  27.4590703),
                const LatLng(42.5119076,  27.4589157),
                const LatLng(42.511361,  27.4599855),
                const LatLng(42.5103767,  27.4620522),
                const LatLng(42.5108106,  27.4624488),
                const LatLng(42.5110636,  27.4628351),
                const LatLng(42.5112977,  27.4634016),
                const LatLng(42.5114977,  27.4640818),
                const LatLng(42.5120352,  27.464211),
                const LatLng(42.5123137,  27.4642794),
                const LatLng(42.5123447,  27.4642852),
                const LatLng(42.5124605,  27.4642989),
                const LatLng(42.5126769,  27.46429),
                const LatLng(42.5128755,  27.4642683),
                const LatLng(42.5130613,  27.4641522),
                const LatLng(42.513421,  27.4638668),
                const LatLng(42.5156028,  27.4619242),
                const LatLng(42.515626,  27.4618835),
                const LatLng(42.5156369,  27.4618328),
                const LatLng(42.5156388,  27.4617522),
                const LatLng(42.5156267,  27.461691)
              ],
              color: Colors.orange,
              isFilled: true,
            ),

          ],
        ),
      ],
    );
  }
}
