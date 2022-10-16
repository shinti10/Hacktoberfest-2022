import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PokemonDetails extends StatefulWidget {
  PokemonDetails(this._index, this._pokeImg, this._pokename, this._weight,
      this._height, this._dynamicType, this._dynamicWeakness,
      {Key? key})
      : super(key: key);
  final _index;
  final _pokeImg;
  final _pokename;
  final _weight;
  final _height;
  var _dynamicType;
  var _dynamicWeakness;

  @override
  _PokemonDetailsState createState() => _PokemonDetailsState();
}

class _PokemonDetailsState extends State<PokemonDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(widget._pokename.toUpperCase()),
        backgroundColor: Colors.grey[900],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width - 20,
              top: MediaQuery.of(context).size.height * 0.1,
              left: 10,
              child: Card(
                elevation: 15.0,
                color:
                    Colors.primaries[Random().nextInt(Colors.primaries.length)],
                shadowColor:
                    Colors.primaries[Random().nextInt(Colors.primaries.length)],
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.elliptical(15, 15),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(height: 70),
                    descriptionsText(false, widget._pokename, 25, true),
                    descriptionsText(
                        false, "Weight: " + widget._weight, 20, false),
                    descriptionsText(
                        false, "Height: " + widget._height, 20, false),
                    descriptionsText(false, "Types".toUpperCase(), 22, false),
                    typeDecriptionsTxt(
                        widget._dynamicType[widget._index].length == 2),
                    descriptionsText(
                        false, "Weakness".toUpperCase(), 22, false),
                    weaknessDescText(
                      widget._dynamicWeakness[widget._index].length,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: CachedNetworkImage(
                width: 200,
                height: 200,
                imageUrl: widget._pokeImg,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.fill,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget weaknessDescText(int _size) {
    // I need to show only Four Weakness...
    int _reduceSize = _size <= 4 ? _size : 4;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (var i = 0; i < _reduceSize; i++)
          Flexible(
            child: Container(
              height: 35,
              width: 80,
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Center(
                child: descriptionsText(false,
                    widget._dynamicWeakness[widget._index][i], 22, false),
              ),
            ),
          ),
      ],
    );
  }

  Widget typeDecriptionsTxt(bool len) {
    return len
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              descriptionsText(true,
                  widget._dynamicType[widget._index][0].toString(), 20, false),
              descriptionsText(true,
                  widget._dynamicType[widget._index][1].toString(), 20, false),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              descriptionsText(true,
                  widget._dynamicType[widget._index][0].toString(), 20, false),
            ],
          );
  }

  Widget descriptionsText(
      bool _isContainer, String _txt, double fsize, bool _isBold) {
    return _isContainer
        ? Container(
            width: 90,
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Center(
              child: Text(
                _txt,
                style: TextStyle(
                  fontSize: fsize,
                  fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          )
        : Text(
            _txt,
            style: TextStyle(
              fontSize: fsize,
              fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
            ),
          );
  }
}
