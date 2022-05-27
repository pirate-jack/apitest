import 'package:apitest/Helper/Linkurl.dart';
import 'package:apitest/Model/CarResponseModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Helper/APIservice.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CarResponseModel> carList = [];

  @override
  void initState() {
    super.initState();
    fetchCar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: ListView.builder(
            itemCount: carList.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return design(carList[index]);
            }));
  }

  Widget design(CarResponseModel data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        child: Row(children: [
          Image.network(
            Linkurl.imgUrl + data.image,
            height: 100,
            width: 100,
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name : ${data.name}"),
              Text("Price : ${data.price.toString()}"),
              Text("Description : ${data.description}"),
            ],
          )
        ]),
      ),
    );
  }

  Future<void> fetchCar() async {
    CarModel model = await APIService().carData();
    setState(() {
      carList = model.data;
    });
  }
}
