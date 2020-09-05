import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.orange[500],
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Flutter Firebase Demo App",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
        actions: [new IconButton(icon: new Icon(Icons.search,size: 25,color: Colors.white,), onPressed:(){} )],
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      drawer: new Drawer(child: new Container(),),
      body: new StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection("baby").snapshots(),
          builder: (context , snapshot) {
            if (!snapshot.hasData) return Center(child: new CircularProgressIndicator(),);

            return new Container(
              padding: const EdgeInsets.all(10),
              child: new ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context , index)=>
                      new GestureDetector(
                        child: new Card(
                          shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          color: Colors.white,
                          elevation: 10,
                          child:new ListTile(
                            title: new Text(snapshot.data.documents[index]["name"],style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                            trailing: new Text(snapshot.data.documents[index]["votes"].toString(),style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                          ),
                        ),
                        onTap: ()=>snapshot.data.documents[index].reference.updateData({"votes" : FieldValue.increment(1)}),
                      )
              )
            );
          }
      ),
    );
  }
}

/*

 */

/*

 */
/*

 */