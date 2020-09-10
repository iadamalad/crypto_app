import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Coin extends Equatable {
  final String name;
  final String fullName;
  final double price;

  const Coin(
      {@required this.name, @required this.fullName, @required this.price});

  @override
  List<Object> get props =>
      [name, fullName, price]; //when comparing two Coin objects, we compare
//the name, full name, and price

  @override
  String toString() => 'Coin {name: $name, fullName: $fullName, price: $price}';

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
        name: json['CoinInfo']['Name'] as String,
        fullName: json['CoinInfo']['FullName'] as String,
        price: (json['RAW']['USD']['PRICE'] as num).toDouble());
  }
}
