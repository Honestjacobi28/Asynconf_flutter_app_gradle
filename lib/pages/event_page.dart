
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  //final events=[];
  // final events=[
  //   {
  //     "speaker":"Lior chamla",
  //     "date":"13 à 13h30",
  //     "subject":"le code legacy",
  //     "avatar":"lior"
  //   },
  //   {
  //     "speaker":"Damien Carnailles",
  //     "date":"17h 30 à 18",
  //     "subject":"git blame --no-offence",
  //     "avatar":"damien"
  //   },
  //   {
  //     "speaker":"Defend Intelligence",
  //     "date":"18 à 18h30",
  //     "subject":"A la decouverte des IA generatif",
  //     "avatar":"defendintelligence"
  //   },
  //   {
  //     "speaker":"Defend Intelligence",
  //     "date":"18 à 18h30",
  //     "subject":"A la decouverte des IA generatif",
  //     "avatar":"defendintelligence"
  //   },
  // ];
   @override
  Widget build(BuildContext context) {
    return Center(
      //récuperation de données en temps réel  avec StreamBuilder  et snapshot()
         child:StreamBuilder(
          /*snapshots():pour flux, mettre ajout les données instantanement
          ce qui signifie que vous pouvez écouter en continu les modifications de la collection "events". 
          Chaque fois qu'il y a une modification 
          dans la collection (ajout, modification ou suppression de documents), 
          le flux sera mis à jour avec le nouveau QuerySnapshot.  
          En résumé, un snapshot représente un instantané des données 
          à un moment donné et fournit des méthodes et des propriétés 
          pour accéder aux données, vérifier leur présence et effectuer des 
          opérations de manipulation de données.
          */
          //faire des tris
          //stream: FirebaseFirestore.instance.collection("events").where('speaker',isEqualTo: 'MOULOT').snapshots(),
          //définir un ordre d'affichage
          //stream: FirebaseFirestore.instance.collection("events").orderBy("speaker").snapshots(),
          stream: FirebaseFirestore.instance.collection("events").orderBy("speaker",descending:true ).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          //verifier si la connection est en cours  
           if(snapshot.connectionState==ConnectionState.waiting) {
            return const CircularProgressIndicator();
           }
           //verifier  si la structure de données(snapshot) est vide
           if(!snapshot.hasData){
            return const Text("Aucune conference");
           }
           List<dynamic>events=[];
           snapshot.data!.docs.forEach((element) { 
            events.add(element);
           });
            
           //dans le centrer lorsque  nous avons utiliser une liste locale pour 
           //stocker nos données
           return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index){
              final event =events[index];
              //final avatar=event["avatar"]
              final avatar=event["avatar"].toString().toLowerCase();
              final speaker=event["speaker"];
              // final date=event["date"];
              //utiliser  la dependence "intl" pour formater la date
              final Timestamp timestamp=event["date"];
              final String date=DateFormat.yMd().add_jm().format(timestamp.toDate());
              final subject=event["subject"];
                      
              return Card(
                child: ListTile(
                  leading: Image.asset('assets/images/$avatar.jpg'),
                  title:   Text('$speaker($date)'),
                  subtitle:  Text('$subject'),
                  trailing:  const Icon(Icons.more_vert),
                ),
                );    
            
            } ,
          );
        }
          
        ),
      ); 
    
  }
}