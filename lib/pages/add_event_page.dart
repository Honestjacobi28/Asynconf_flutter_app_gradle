import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {

  //permet d'enclencher le validator en recupérant l'état du formulaire
  final _formkey = GlobalKey<FormState>();
  //recuperer le contenu des champs au moment de l'envoi et 
  //par la suite le mettre sur une bd
  //il faut créer des controllers
  final confNameController=TextEditingController();
  final speakerNameController=TextEditingController();
  String selectedConfType='demo';
  DateTime selectedConfDate=DateTime.now();

  //l'application se minimalise , il faut libérer un peu de memoire,on fait un dispose
  
  @override
  void dispose() {
    super.dispose();
    confNameController.dispose();
    speakerNameController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.all(20),
       child: Form(
        key: _formkey,
        child:Column(
          children: [
           Container(
            margin: const EdgeInsets.only(bottom: 10),
             child: TextFormField(
              decoration:const  InputDecoration(
                labelText: "Nom de Conference",
                hintText: "Entre le nom de la conference",
                border: OutlineInputBorder(),
              ),
              //verifier si le formulaire est nul ou vide
              validator: (value){
                if (value== null || value.isEmpty){
                  return "Tu dois completer ce texte" ;
                }
                return null;
              },
              controller: confNameController ,
             ),
           ),
           Container(
            margin: const EdgeInsets.only(bottom: 10),
             child: TextFormField(
              decoration:const  InputDecoration(
                labelText: "Nom du  Speaker",
                hintText: "Entre le nom du speaker",
                border: OutlineInputBorder(),
              ),
              //verifier si le formulaire est nul ou vide
              validator: (value){
                if (value== null || value.isEmpty){
                  return "Tu dois completer ce texte" ;
                }
                return null;
              } ,
              controller: speakerNameController,
             ),
           ),
           Container(
            margin: const EdgeInsets.only(bottom: 10),
             child: DropdownButtonFormField(
              items: const [
                 DropdownMenuItem(value:'talk',child: Text("Talk show")),
                 DropdownMenuItem(value:'demo',child: Text("demo Code")),
                 DropdownMenuItem(value:'partner',child: Text("Partner")),
              ],
              //valeur par défaut
              value: selectedConfType,  //sinon définir un validator pour vérifier si le champ n'est pas nul
              onChanged: (value){
                selectedConfType=value!;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder()
              ),
              ),
           ),
           Container(
            margin: const EdgeInsets.only(bottom: 10),
             child: DateTimeFormField(
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.black45),
                errorStyle: TextStyle(color: Colors.redAccent),
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.event_note),
                labelText: 'Changer de date',
              ),
              mode: DateTimeFieldPickerMode.dateAndTime,
              autovalidateMode: AutovalidateMode.always,
              validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
              onDateSelected: (DateTime value) {
                setState(() {
                   selectedConfDate=value;
                });
                
              },
            ),
           ),
           SizedBox(
            width: double.infinity,
            height: 50,
             child: ElevatedButton(
              onPressed: (){
                if(_formkey.currentState!.validate()){
                  //récupération(avoir acces au contenu)
                  final confName=confNameController.text;
                  final speakerName=speakerNameController.text;


                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Envoi en cours..."),)
                  );
                  //fermer le clavier apres "envoyer"
                  FocusScope.of(context).requestFocus(FocusScopeNode());
                  //utilisation des valeurs recuperees
                  // print("ajout de la conf $confName par le speaker $speakerName");
                  // print("Type de conference $selectedConfType");
                  // print("Date de la conference $selectedConfDate");

                  //installer cloud_firestore pour la bd 
                  //ajout dans la base  de données
                  CollectionReference eventsRef=FirebaseFirestore.instance.collection("events");
                  eventsRef.add({
                    "speaker" :speakerName,
                    "date":selectedConfDate,
                    "subject":confName,
                    "type":selectedConfType,
                    "avatar":"lior"
                  });
                }
              }, 
              child:const Text("Envoyer")
              ),
           ),
        ],

        ),
        ),
    );
  }
}