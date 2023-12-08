// application pour salon de developpement informatique

import 'package:asyncof/pages/add_event_page.dart';
import 'package:asyncof/pages/event_page.dart';
import 'package:asyncof/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  //initialiser firebase à l'aide "firebase_core"
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  //_currentIndex ne sera pas appelé en dehors de cette classe, c'est une propriété privée
  int _currentIndex=0;

  setCurrentIndex(int index){
   setState(() {
     _currentIndex=index;
   });
  }
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      
      home: Scaffold(
        
        appBar: AppBar(
          title: [
            const Text("Asynconf"),
            const Text("Liste de Conferences"),
            const Text("Formulaire"),
          ][_currentIndex]
        ),
        body: [
          const HomePage(),
          const EventPage(),
          const AddEventPage() ,
        ][_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex:_currentIndex ,
          onTap: (index) =>setCurrentIndex(index) ,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          iconSize: 32,
          elevation:10,
          items: const [
            BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Acceuil",
          ),
            BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Planning",
          ),
            BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Ajout",
          ),
          ],
          ),
      ),
      theme: ThemeData(
         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
         useMaterial3: true,
      ),
    );
}
}