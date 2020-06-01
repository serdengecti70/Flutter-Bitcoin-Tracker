import 'package:flutter/material.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  @override
  void initState() {
    super.initState();
    getCoinData();
  }

  String selectedCurrent = currenciesList.first;

  Map<String, String> coinMap;

  List<DropdownMenuItem<String>> dropList = currenciesList
      .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ))
      .toList();

  void getCoinData() async {
    try {

      var data = await CoinData().getData(selectedCurrent);
      setState(()  {
        coinMap = data;
      });
      print(coinMap);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto Coin Tracker'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            for (String coin in cryptoList)
              CoinCard(
                cryptoCoin: coin,
                currentCoin: selectedCurrent,
                rate: coinMap[coin] ?? "1",
              ),
            Container(
              alignment: Alignment.center,
              height: 155.0,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.blueAccent,
              child: DropdownButton<String>(
                value: selectedCurrent,
                style: TextStyle(color: Colors.white, fontSize: 25.0),
                underline: Container(
                  color: Colors.white,
                  height: 3.0,
                ),
                items: dropList,
                onChanged: (value) {
                  setState(() {
                    selectedCurrent = value;
                    getCoinData();
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CoinCard extends StatelessWidget {
  CoinCard({this.currentCoin, this.cryptoCoin, this.rate});

  final String currentCoin;
  final String cryptoCoin;
  final String rate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30.0,
            vertical: 15.0,
          ),
          child: Text(
            '1 $cryptoCoin $rate $currentCoin',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25.0,
            ),
          ),
        ),
      ),
    );
  }
}

// CoinCard(
//               currentCoin: selectedCurrent,
//               cryptoCoin: 'BTN',
//             ),
//             CoinCard(
//               currentCoin: selectedCurrent,
//               cryptoCoin: 'ETH',
//             ),
//             CoinCard(
//               currentCoin: selectedCurrent,
//               cryptoCoin: 'LTC',
//             ),
