
import 'package:campousia/Model/ModelClasses/BusTrips.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Model/ModelClasses/Bus.dart';
import '../ParticularHP/ParticulurHomePage.dart';


class SecondaryBody extends StatefulWidget {
  const SecondaryBody({Key? key}) : super(key: key);

  @override
  State<SecondaryBody> createState() => _SecondaryBodyState();
}

class _SecondaryBodyState extends State<SecondaryBody> {
  GestureDetector BusButton(
      String imageVal, String hotelname, String hotellocation, int index) {
    return GestureDetector(
      onTap: () {
        //  History_model.His.add(index);
        Bus.selectedBus = index;
        print(Bus.selectedBus);
        Bus.indexfind();

        // for(int i=0;i< BusTrips.busTrips[Bus.indexofbustrips].Uptrips.length;i++){
        //   print(BusTrips.busTrips[Bus.indexofbustrips].Uptrips[i]);
        //
        // }
        //
        // print("object") ;

        // for(int i=0;i<BusTrips.busTrips.length;i++)
        // {
        //   print(BusTrips.busTrips[i].name);
        //   print(BusTrips.busTrips[i].Uptrips);
        //   print(BusTrips.busTrips[i].locShare);
        //   print(BusTrips.busTrips[i].Notice);
        //
        // }


        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ParticulurHomePage()));
      },
      child: Row(
        children: [
          SizedBox(width: 22,),
          Container(
            width: 270,
            height: 240,
            child: Card(
              child: Wrap(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 160,//MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(11.0),
                      image: DecorationImage(
                        image: NetworkImage(imageVal),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(hotelname),
                    subtitle: Text(hotellocation),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 22,),
        ],
      ),
    );

  }

  List<Bus> display_list = List.from(Bus.busList);


  void updateList(String value) {
    setState(() {
      display_list = Bus.busList
          .where((element) =>
              element.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.black,
          pinned: true,
          centerTitle: true,
          title: const Text('Du Buses'),
          actions: [
            /*
            IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => bodyFavorite()));
              },
            ),
            */
          ],
          bottom: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black,
            title: Container(
              width: double.infinity,
              height: 40,
              color: Colors.white,
              child: Center(
                child: TextField(
                  onChanged: (value) => updateList(value),
                  decoration: InputDecoration(
                    hintText: 'Search for something',
                    prefixIcon: Icon(Icons.search),
// suffixIcon: Icon(Icons.favorite)
                  ),
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              TextToDisplay("Favourites :"),
              BusButtonItem("fav"),
              TextToDisplay("All Buses :"),
              BusButtonItem("all"),
            ],
          ),
        ),
      ],
    );
  }

  Widget BusButtonItem(String ud) {
    if(ud =="fav")
      {
        return Container(
            height: 300,
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView.builder(
              //shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(right: 25, left: 25, top: 10),
              itemCount: Bus.favIndices.length,
              itemBuilder: (context, index) => BusButton(Bus.busList[Bus.favIndices[index]].x,
                  Bus.busList[Bus.favIndices[index]].name, Bus.busList[Bus.favIndices[index]].address, Bus.favIndices[index]),
            ));
      }
    else if(ud=="all"){
      return Container(
          height: 300,
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView.builder(
            //shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(right: 25, left: 25, top: 10),
            itemCount: display_list.length,
            itemBuilder: (context, index) => BusButton(display_list[index].x,
                display_list[index].name, display_list[index].address, index),
          ));
    }
    else{
      return Container(
          height: 300,
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView.builder(
            //shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(right: 25, left: 25, top: 10),
            itemCount: display_list.length,
            itemBuilder: (context, index) => BusButton(display_list[index].x,
                display_list[index].name, display_list[index].address, index),
          ));
    }
    return Container();
  }

  Widget TextToDisplay(String title) {
    return ListTile(
      title: Center(
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.white,),
        ),
      ),
    );
  }
}

