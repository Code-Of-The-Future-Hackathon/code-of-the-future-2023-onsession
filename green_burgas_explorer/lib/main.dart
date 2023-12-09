import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:green_burgas_explorer/calculations.dart';
import 'package:green_burgas_explorer/closer_polyngon.dart';
import 'package:green_burgas_explorer/map.dart';
import 'dart:math';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:green_burgas_explorer/map_sheet_model.dart';
import 'package:geolocator/geolocator.dart';

double area1 = 0.0,
    area2 = 0.0,
    area3 = 0.0,
    area4 = 0.0,
    area5 = 0.0,
    area6 = 0.0;

void main() {
  // List<Point> polygon1 = [
  //       Point(42.4964575, 27.4644073),
  //       Point(42.4963012, 27.4635832),
  //       Point(42.4961909, 27.4630044),
  //       Point(42.4958361, 27.4631284),
  //       Point(42.4955275, 27.4632363),
  //       Point(42.495636, 27.4638117),
  //       Point(42.4957907, 27.4646261),
  //       Point(42.4959997, 27.4657294),
  //       Point(42.4960889, 27.4656973),
  //       Point(42.4961839, 27.4656642),
  //       Point(42.4963148, 27.4656207),
  //       Point(42.4964641, 27.4655688),
  //       Point(42.4965117, 27.4655281),
  //       Point(42.4964969, 27.4654442),
  //       Point(42.4964685, 27.4652695),
  //       Point(42.4964405, 27.4650968),
  //       Point(42.4963898, 27.4648072),
  //       Point(42.4964575, 27.4644073)
  //     ],
  //     polygon2 = [
  //       Point(42.5260581, 27.4612257),
  //       Point(42.5255456, 27.4603942),
  //       Point(42.5248523, 27.4591378),
  //       Point(42.5247556, 27.4589703),
  //       Point(42.5246633, 27.4589254),
  //       Point(42.5245368, 27.4589919),
  //       Point(42.5234431, 27.460193),
  //       Point(42.5233326, 27.4605965),
  //       Point(42.5230281, 27.4618345),
  //       Point(42.5231234, 27.4619351),
  //       Point(42.5238107, 27.4628601),
  //       Point(42.5243513, 27.4634159),
  //       Point(42.5247939, 27.4638613),
  //       Point(42.5254465, 27.4644361),
  //       Point(42.5255283, 27.4644981),
  //       Point(42.5260675, 27.4649067),
  //       Point(42.5261599, 27.4649404),
  //       Point(42.5260884, 27.4644534),
  //       Point(42.5260007, 27.4641445),
  //       Point(42.5260405, 27.4636449),
  //       Point(42.5260202, 27.4633238),
  //       Point(42.5259623, 27.463109),
  //       Point(42.5258762, 27.4629147),
  //       Point(42.525698, 27.4625844),
  //       Point(42.5253649, 27.4619388),
  //       Point(42.5260581, 27.4612257)
  //     ],
  //     polygon3 = [
  //       Point(42.5208176, 27.4536228),
  //       Point(42.5207989, 27.4535829),
  //       Point(42.5207516, 27.4534821),
  //       Point(42.5199598, 27.4518518),
  //       Point(42.5195913, 27.4511616),
  //       Point(42.519309, 27.4508964),
  //       Point(42.5187539, 27.4521292),
  //       Point(42.5187587, 27.4522198),
  //       Point(42.5187496, 27.4523218),
  //       Point(42.5187061, 27.452472),
  //       Point(42.5175669, 27.4549707),
  //       Point(42.5173311, 27.4552113),
  //       Point(42.5171927, 27.4554988),
  //       Point(42.5168163, 27.4562806),
  //       Point(42.5164341, 27.4570746),
  //       Point(42.5165591, 27.4573786),
  //       Point(42.51662, 27.4574619),
  //       Point(42.5166519, 27.4575415),
  //       Point(42.5167213, 27.4574882),
  //       Point(42.5167822, 27.4576268),
  //       Point(42.5168154, 27.4576041),
  //       Point(42.5173965, 27.4589586),
  //       Point(42.517504, 27.4588697),
  //       Point(42.5178534, 27.4579644),
  //       Point(42.5179745, 27.4576892),
  //       Point(42.5181002, 27.457462),
  //       Point(42.5182002, 27.4573062),
  //       Point(42.5177645, 27.4563654),
  //       Point(42.5178923, 27.4562579),
  //       Point(42.5179832, 27.4561825),
  //       Point(42.5179498, 27.4560932),
  //       Point(42.5180369, 27.4560217),
  //       Point(42.5208176, 27.4536228)
  //     ],
  //     polygon4 = [
  //       Point(42.4895702, 27.4809188),
  //       Point(42.4909865, 27.4817784),
  //       Point(42.491303, 27.48075),
  //       Point(42.4917225, 27.4809523),
  //       Point(42.4920732, 27.4812091),
  //       Point(42.4921884, 27.4812564),
  //       Point(42.4922157, 27.4811912),
  //       Point(42.4921102, 27.4811204),
  //       Point(42.4921748, 27.4809503),
  //       Point(42.4924569, 27.4811497),
  //       Point(42.4924409, 27.4811928),
  //       Point(42.4928196, 27.4814968),
  //       Point(42.4927782, 27.4815845),
  //       Point(42.4933356, 27.4821284),
  //       Point(42.4932654, 27.4822536),
  //       Point(42.4939977, 27.4829598),
  //       Point(42.4941107, 27.4830043),
  //       Point(42.494976, 27.4831852),
  //       Point(42.4949996, 27.4829409),
  //       Point(42.4951367, 27.4829814),
  //       Point(42.4953215, 27.4831031),
  //       Point(42.4953378, 27.4830482),
  //       Point(42.4958331, 27.4831622),
  //       Point(42.4959948, 27.4832231),
  //       Point(42.4965708, 27.4833171),
  //       Point(42.4971464, 27.4833435),
  //       Point(42.4988246, 27.4834228),
  //       Point(42.4996111, 27.4833771),
  //       Point(42.5005143, 27.4834567),
  //       Point(42.5015208, 27.4834004),
  //       Point(42.5031273, 27.4834655),
  //       Point(42.5031436, 27.4834341),
  //       Point(42.5031637, 27.4834186),
  //       Point(42.5031866, 27.483423),
  //       Point(42.5032079, 27.4834464),
  //       Point(42.5035091, 27.4833694),
  //       Point(42.5044211, 27.4834146),
  //       Point(42.5062614, 27.483589),
  //       Point(42.5088155, 27.4839401),
  //       Point(42.5094748, 27.4840387),
  //       Point(42.5095119, 27.4837798),
  //       Point(42.5070851, 27.4821307),
  //       Point(42.5054263, 27.4809383),
  //       Point(42.5051994, 27.4809912),
  //       Point(42.5043011, 27.4809791),
  //       Point(42.5038053, 27.4809412),
  //       Point(42.5032595, 27.4808922),
  //       Point(42.5022099, 27.4807443),
  //       Point(42.500882, 27.4805316),
  //       Point(42.4998159, 27.4803237),
  //       Point(42.4993116, 27.4802608),
  //       Point(42.4986875, 27.4801093),
  //       Point(42.4982804, 27.4801647),
  //       Point(42.4980714, 27.4802128),
  //       Point(42.4971473, 27.4803531),
  //       Point(42.4962749, 27.4804876),
  //       Point(42.4953971, 27.4806759),
  //       Point(42.4943443, 27.48092),
  //       Point(42.4940779, 27.4809137),
  //       Point(42.4938579, 27.4808093),
  //       Point(42.4933206, 27.4803736),
  //       Point(42.4929503, 27.4810617),
  //       Point(42.4917855, 27.4800167),
  //       Point(42.4914042, 27.4797047),
  //       Point(42.4911732, 27.4802093),
  //       Point(42.4911412, 27.480282),
  //       Point(42.491113, 27.4803591),
  //       Point(42.4910669, 27.4805218),
  //       Point(42.4908715, 27.4803941),
  //       Point(42.4902538, 27.4801955),
  //       Point(42.4899858, 27.480312),
  //       Point(42.4898432, 27.480105),
  //       Point(42.4895668, 27.4804369),
  //       Point(42.4894112, 27.4806517),
  //       Point(42.4895958, 27.480823),
  //       Point(42.4895702, 27.4809188)
  //     ],
  //     polygon5 = [
  //       Point(42.5156267, 27.461691),
  //       Point(42.5147131, 27.4596834),
  //       Point(42.5138591, 27.4589305),
  //       Point(42.5130973, 27.4606287),
  //       Point(42.5129378, 27.4604934),
  //       Point(42.5127955, 27.4602842),
  //       Point(42.5126769, 27.4600482),
  //       Point(42.5126136, 27.4597639),
  //       Point(42.5125661, 27.4595332),
  //       Point(42.5124642, 27.4593335),
  //       Point(42.5121214, 27.4590703),
  //       Point(42.5119076, 27.4589157),
  //       Point(42.511361, 27.4599855),
  //       Point(42.5103767, 27.4620522),
  //       Point(42.5108106, 27.4624488),
  //       Point(42.5110636, 27.4628351),
  //       Point(42.5112977, 27.4634016),
  //       Point(42.5114977, 27.4640818),
  //       Point(42.5120352, 27.464211),
  //       Point(42.5123137, 27.4642794),
  //       Point(42.5123447, 27.4642852),
  //       Point(42.5124605, 27.4642989),
  //       Point(42.5126769, 27.46429),
  //       Point(42.5128755, 27.4642683),
  //       Point(42.5130613, 27.4641522),
  //       Point(42.513421, 27.4638668),
  //       Point(42.5156028, 27.4619242),
  //       Point(42.515626, 27.4618835),
  //       Point(42.5156369, 27.4618328),
  //       Point(42.5156388, 27.4617522),
  //       Point(42.5156267, 27.461691)
  //     ],
  //     polygon6 = [
  //       Point(42.5134541, 27.4761646),
  //       Point(42.5139244, 27.4755801),
  //       Point(42.5155294, 27.4737141),
  //       Point(42.5187905, 27.4697209),
  //       Point(42.5190645, 27.4693846),
  //       Point(42.519365, 27.4692247),
  //       Point(42.5193349, 27.4687591),
  //       Point(42.5192784, 27.4686878),
  //       Point(42.5183487, 27.468722),
  //       Point(42.5178577, 27.4688322),
  //       Point(42.5174081, 27.4690149),
  //       Point(42.5168611, 27.4693223),
  //       Point(42.5160708, 27.4698119),
  //       Point(42.5152521, 27.4703452),
  //       Point(42.5149393, 27.4705205),
  //       Point(42.5143266, 27.4709178),
  //       Point(42.5140112, 27.4711938),
  //       Point(42.5136985, 27.4716111),
  //       Point(42.5134389, 27.4720623),
  //       Point(42.5131111, 27.4726936),
  //       Point(42.5125565, 27.4739413),
  //       Point(42.5123659, 27.4746319),
  //       Point(42.5119741, 27.4740044),
  //       Point(42.5119003, 27.4739765),
  //       Point(42.5118572, 27.4740009),
  //       Point(42.5118262, 27.4740594),
  //       Point(42.5117273, 27.4744041),
  //       Point(42.5116395, 27.4746468),
  //       Point(42.5115337, 27.4748689),
  //       Point(42.5100736, 27.4768726),
  //       Point(42.5098183, 27.4772414),
  //       Point(42.5087659, 27.4786606),
  //       Point(42.508235, 27.4792988),
  //       Point(42.5081459, 27.4793987),
  //       Point(42.507762, 27.4797641),
  //       Point(42.5071893, 27.4802137),
  //       Point(42.5067032, 27.4805059),
  //       Point(42.5064363, 27.480615),
  //       Point(42.5061928, 27.4806842),
  //       Point(42.5059862, 27.4807881),
  //       Point(42.5054386, 27.4809351),
  //       Point(42.5095119, 27.4837798),
  //       Point(42.5099057, 27.4840367),
  //       Point(42.5113321, 27.4843599),
  //       Point(42.5118972, 27.4811177),
  //       Point(42.5119645, 27.4807078),
  //       Point(42.51199, 27.4805523),
  //       Point(42.512425, 27.4806451),
  //       Point(42.5124735, 27.4805848),
  //       Point(42.5123722, 27.479409),
  //       Point(42.5124861, 27.4782674),
  //       Point(42.5128369, 27.4772273),
  //       Point(42.5134541, 27.4761646)
  //     ];
  // area1 = polygonArea(polygon1);
  // area2 = polygonArea(polygon2);
  // area3 = polygonArea(polygon3);
  // area4 = polygonArea(polygon4);
  // area5 = polygonArea(polygon5);
  // area6 = polygonArea(polygon6);
  // print(
  //     "Площта на многоъгълник 1 е: $area1 \n Площта на многоъгълник 2 е: $area2 \n Площта на многоъгълник 3 е: $area3 \n Площта на многоъгълник 4 е: $area4 \n Площта на многоъгълник 5 е: $area5 \n Площта на многоъгълник 6 е: $area6");

// Четене на файла
  File file = File('/data/polygons_coordinates.json');
  String jsonString = file.readAsStringSync();

  // Десериализация на JSON
  Map<String, dynamic> jsonData = json.decode(jsonString);

  // Създаване на масиви от JSON данните
  List<Polygon> polygons = [];

  jsonData.forEach((key, value) {
    Polygon polygon = Polygon.fromJson(value);
    polygons.add(polygon);
  });

  // Използване на масивите
  // for (int i = 0; i < polygons.length; i++) {
  //   print('Polygon ${i + 1} points: ${polygons[i].points}');
  // }

  // Пример за изчисляване на площ
  for (int i = 0; i < polygons.length; i++) {
    double area = polygonArea(polygons[i].points);
    print('Area of Polygon ${i + 1}: $area');
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('GreenBurgas Explorer'),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            MapWidget(),
            Positioned(
              bottom: 16.0,
              right: 16.0,
              child: ClipOval(
                child: Material(
                  color: Colors.blue, // Цвят на кръга
                  child: InkWell(
                    onTap: () async {
                      try {
                        Position position = await determinePosition();
                        print(
                            'Latitude: ${position.latitude}, Longitude: ${position.longitude}');
                      } catch (e) {
                        print('Грешка при вземане на локацията: $e');
                      }
                    },
                    child: const SizedBox(
                      width: 56,
                      height: 56,
                      child: Icon(
                        FontAwesomeIcons.locationCrosshairs,
                        color: Colors.white, // Цвят на иконата
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomeScreen(),
//     );
//   }
// }
//
// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('GreenBurgas Explorer'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             GestureDetector(
//               onTap: () {
//                 showModalBottomSheet(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return SheetModal(
//                       name: 'Your Point Name',
//                       description: 'Your Point Description',
//                     );
//                   },
//                 );
//               },
//               child: Text(
//                 'Click me to show SheetModal',
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.blue,
//                   decoration: TextDecoration.underline,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
