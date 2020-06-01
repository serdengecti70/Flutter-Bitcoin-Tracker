import 'package:http/http.dart' as http;
import 'dart:convert';


const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];
//TODO: Enter your Apıkey here
const apiKey ="YOUR-API-KEY";

const apiUrl = "https://rest.coinapi.io/v1/exchangerate/";              
    
class CoinData {

  
  Future<Map<String, dynamic>> getData(String current) async {
    Map<String,String> coinMap= {};  

    for(String coin in cryptoList){
      http.Response response = await http.get("$apiUrl$coin/$current?apikey=$apiKey");
      if(response.statusCode == 200){
          var decodedData = jsonDecode(response.body);
          coinMap[coin] =  decodedData['rate'].toStringAsFixed(0);
      }
      else{
        print(response.statusCode);
        throw "Problem with get request";
      }
    }

    return coinMap;

  }


}