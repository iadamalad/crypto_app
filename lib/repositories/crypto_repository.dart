import 'dart:convert';
import 'package:cyrpto_currency_app/models/coin_model.dart';
import 'package:cyrpto_currency_app/repositories/base_crypto_repository.dart';
import 'package:http/http.dart' as http;

class CryptoRepository extends BaseCryptoRepository {
  static const String _baseUrl = "https://min-api.cryptocompare.com";
  static const int _perCall = 20;
  final http.Client _httpClient;

  CryptoRepository({http.Client httpClient})
      : _httpClient = httpClient ??
            http.Client(); //set _httpClient to what's passed in, if nothing is passed in, create a newe http client by calling the constructor

  @override
  Future<List<Coin>> getTopCoins({int page}) async {
    List<Coin> coins = [];
    String requestUrl =
        '$_baseUrl/data/top/toalvolfull?limit=$_perCall&tysm=USD&page=$page';
    try {
      final response = await _httpClient.get(requestUrl);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response
            .body); //response.body is a string which we decode into a json object which is Map<String,dynamic>
        List<dynamic> coinList = data['Data'];
        coinList.forEach(
          (json) =>
              coins.add(Coin.fromJson(json)), //json is each item in coinList
        );
      }
      return coins;
    } catch (err) {
      throw (err);
    }
  }

  @override
  void dispose() {
    _httpClient.close();
  }
}
