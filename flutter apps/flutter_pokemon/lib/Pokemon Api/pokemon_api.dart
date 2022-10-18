import 'dart:convert';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_pokemon/Pokemon/poke_details.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

String _name = 'Pokemon';
String _img = 'http://www.serebii.net/pokemongo/pokemon/001.png';
String _weight = '5 kg';
String _height = '2.0 m';
bool _wait = true;
int _size = 150;
List<String> _apiImg = List.filled(_size, _img);
List<String> _apiName = List.filled(_size, _name);
List<String> _apiWeight = List.filled(_size, _weight);
List<String> _apiHeight = List.filled(_size, _height);
List<String> _apiType = List.filled(_size, _name);
var _apiWeakness = {};
var _dynamicType = {};

class PokemonApi extends StatefulWidget {
  const PokemonApi({Key? key}) : super(key: key);

  @override
  _PokemonApiState createState() => _PokemonApiState();
}

class _PokemonApiState extends State<PokemonApi> {
  final api =
      'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json';
  Future<String> getApiData() async {
    var url = Uri.parse(api);
    http.Response response = await http.get(url);
    var responseData;
    if (response.statusCode == 200) {
      responseData = json.decode(response.body);
    }
    // Adding Imges,Names,Weights,Heights....
    for (int i = 0; i < _size; i++) {
      _apiImg[i] = responseData['pokemon'][i]['img'];
      _apiName[i] = responseData['pokemon'][i]['name'];
      _apiWeight[i] = responseData['pokemon'][i]['weight'];
      _apiHeight[i] = responseData['pokemon'][i]['height'];
      _apiWeakness[i] = responseData['pokemon'][i]['weaknesses'];
    }

    // Adding Only Two Types
    for (int i = 0; i < _size; i++) {
      final len = await responseData['pokemon'][i]['type'];
      for (int j = 0; j < 2; j++) {
        int _lsize = len.length;
        if (_lsize == 1) {
          if (j != 1) {
            _dynamicType[i] = responseData['pokemon'][i]['type'];
          } else {
            break;
          }
        } else {
          _dynamicType[i] = responseData['pokemon'][i]['type'];
          break;
        }
      }
    }
    // print(_apiWeakness);
    return "done";
  }

  @override
  void initState() {
    _waitFORDATA();
    super.initState();
  }

  _waitFORDATA() async {
    await getApiData();
    Future.delayed(const Duration(seconds: 8));
    setState(() {
      _wait = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _wait
        ? Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                    Colors.red,
                    BlendMode.darken,
                  ),
                  image: AssetImage('images/pokemon_ball.png'),
                  fit: BoxFit.fill,
                ),
                shape: BoxShape.circle,
              ),
              child: const CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              leading: const Icon(
                Icons.keyboard_backspace_outlined,
                color: Colors.black,
              ),
              centerTitle: true,
              title: Text(
                "Pokemon".toUpperCase(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.menu_outlined,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            body: SafeArea(
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  // This Loop help to avoid repeted code...
                  for (var i = 0; i < _size; i++) networkImg(i),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.grey[900],
              onPressed: () {
                setState(() {});
              },
              child: const Icon(
                Icons.refresh,
              ),
            ),
          );
  }

  Widget networkImg(int indx) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PokemonDetails(
              indx,
              _apiImg[indx],
              _apiName[indx],
              _apiWeight[indx],
              _apiHeight[indx],
              _dynamicType,
              _apiWeakness,
            ),
          ),
        );
      },
      child: Card(
        elevation: 3.0,
        // Generating Random Colors...
        color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: _apiImg[indx],
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Text(
              _apiName[indx],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
