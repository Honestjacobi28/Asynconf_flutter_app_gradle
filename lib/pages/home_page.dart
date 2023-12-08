import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:asyncof/pages/event_page.dart';



class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
       child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //par défaut flutter ne lit pas les fichiers au format svg
          //il faut utiliser une dépendance ex flutter_svg 
          SvgPicture.asset('assets/images/logo.svg'),
          //Image.asset('assets/images/miniature.png'),
          const Text(
          "Asynconf 2022",
           style: TextStyle(
            fontSize: 42,
            // police d'ecriture
            fontFamily: 'Poppins',
            ),
        ),
        const Text(
          "Salon virtuel de l'informatique du 27 au 29 octobre 2022",
           style: TextStyle(fontSize: 24),
           textAlign: TextAlign.center,       
        ),
         const Padding(padding: EdgeInsets.only(top: 20)),
      /*
        ElevatedButton.icon(
          style: const ButtonStyle(
            padding: MaterialStatePropertyAll(EdgeInsets.all(20)),
            backgroundColor: MaterialStatePropertyAll(Colors.green),
          ),
          onPressed: (){
            //rediriger vers la page EventPage
           Navigator.push(
            context, 
            PageRouteBuilder(
              pageBuilder: (_,__,___)=>const EventPage()
              ),
            );
          } , 
          label: const Text(
            "afficher le planning",
             style: TextStyle(
              fontSize: 20,
             ),
          ),
          icon: const Icon(Icons.calendar_month),

          ),
        */
        ],
       ), 
     );
  }
}