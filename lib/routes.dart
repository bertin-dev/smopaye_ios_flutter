import 'package:flutter/material.dart';
import 'package:smopaye_mobile/views/menuReloadAccount.dart';
import 'package:smopaye_mobile/views/menuSubscription.dart';
import 'package:smopaye_mobile/views/menuTransfer.dart';
import 'views/facebook.dart';
import 'views/historyDebit.dart';
import 'views/onlineSupport.dart';
import 'views/telecollectMenu.dart';
import 'views/agencies.dart';
import 'views/clientService.dart';
import 'views/generalPublic.dart';
import 'views/historyRefill.dart';
import 'views/historyTelecollect.dart';
import 'views/historyTransfer.dart';
import 'views/smopayeShops.dart';
import 'views/twitter.dart';
import 'views/google_map.dart';
import 'views/assistance.dart';
import 'views/historic.dart';
import 'views/manageAcceptor.dart';
import 'views/manageAccounts.dart';
import 'views/manageUser.dart';
import 'views/revenue.dart';
import 'views/smopayeOffers.dart';
import 'views/legalInfo.dart';
import 'views/qrPay.dart';
import 'views/qrScan.dart';
import 'views/about.dart';
import 'views/qr.dart';
import 'views/tutorial.dart';
import 'views/website.dart';
import 'views/withrawal.dart';
import 'views/withrawalAccount.dart';
import 'views/withrawalCard.dart';
import 'views/checkBalance.dart';
import 'views/reloadAccount.dart';
import 'views/payInvoice.dart';
import 'views/verifyAccount.dart';
import 'views/renewSubscription.dart';
import 'views/transfer.dart';
import 'views/bottomNavigation.dart';
import 'views/editAccount.dart';
import 'views/introViews.dart';
import 'views/autoRegister.dart';
import 'views/login.dart';
import 'views/register.dart';
import 'views/splashScreen.dart';

// La gestion du routage général se fait ici

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => SplashScreen());   // Route de la page de chargement
      case '/intro':
        return MaterialPageRoute(builder: (context) => IntroductionViews());   // Route de la page d'introduction
      case '/login':
        return MaterialPageRoute(builder: (context) => Login());   // Route de la page d'authentification
      case '/register':
        return MaterialPageRoute(builder: (context) => Register());   // Route de la page d'enrégistrement
      case '/autoRegister':
        return MaterialPageRoute(builder: (context) => AutoRegister());   // Route de la page d'auto enrégistrement
      case '/home':
        {  final String args = settings.arguments;
        //print("MON TELEPHONE EST: $args");
          return MaterialPageRoute(builder: (context) => AppBottomNavigation(args));   // Route de la page d'accueil : espace membre
        }

      case '/editAccount':
        return MaterialPageRoute(builder: (context) => EditAccount());   // Route de la page d'édition de compte
      case '/menuTransfer':
        return MaterialPageRoute(builder: (context) => MenuTransfer());   // Route de la page du Menu transfert d'argent
      case '/menuSubscription':
        return MaterialPageRoute(builder: (context) => MenuSubscription());   // Route de la page du Menu Abonnement
      case '/renewSubscription':
        return MaterialPageRoute(builder: (context) => RenewSubscription());   // Route de la page de renouvellement
      case '/verifyAccount':
        return MaterialPageRoute(builder: (context) => VerifyAccount());   // Route de la page de vérification de compte
      case '/payInvoice':
        return MaterialPageRoute(builder: (context) => PayInvoice());   // Route de la page de paiement de facture
      case '/reload':
        return MaterialPageRoute(builder: (context) => MenuReloadAccount());   // Route de la page de recharge de compte
      case '/check':
        return MaterialPageRoute(builder: (context) => CheckBalance());   // Route de la page de vérification de solde
      case '/withraw':
        return MaterialPageRoute(builder: (context) => Withrawal());   // Route de la page de retrait
      case '/withrawCard':
        return MaterialPageRoute(builder: (context) => WithrawalCard());   // Route de la page de retrait pour Smopaye
      case '/withrawAccount':
        return MaterialPageRoute(builder: (context) => WithrawalAccount());   // Route de la page de retrait par un opérateur
      case '/qr':
        return MaterialPageRoute(builder: (context) => QrCode());   // Route de la page de gestion de QR code
      case '/qrScan':
        return MaterialPageRoute(builder: (context) => QRScan());   // Route de la page de gestion de QR code
      case '/qrPay':
        return MaterialPageRoute(builder: (context) => QRPay());   // Route de la page de gestion de QR code
      case '/about':
        return MaterialPageRoute(builder: (context) => About());   // Route de la page A propos
      case '/legal':
        return MaterialPageRoute(builder: (context) => LegalInformations());   // Route de la page d'information légale
      case '/offers':
        return MaterialPageRoute(builder: (context) => SmopayeOffers()); // Route de la page d'offres
      case '/assistance':
        return MaterialPageRoute(builder: (context) => Assistance()); // Route de la page d'assistance
      case '/clientService':
        return MaterialPageRoute(builder: (context) => ClientService()); // Route de la page du service client
      case '/generalPublic':
        return MaterialPageRoute(builder: (context) => GeneralPublic()); // Route de la page de service client général
      case '/shops':
        return MaterialPageRoute(builder: (context) => SmopayeShops()); // Route de la page des points Smopaye
      case '/agencies':
        return MaterialPageRoute(builder: (context) => SmopayeAgencies()); // Route de la page des points Smopaye
      case '/google_map':
        return MaterialPageRoute(builder: (context) => MyGoogleMap()); // Route de la page montrant un service non disponible
      case '/historic':
        return MaterialPageRoute(builder: (context) => Historic()); // Route de la page aui liste les historiques
      case '/tutorial':
        return MaterialPageRoute(builder: (context) => Tutorial()); // Route de la page montrant le tutoriel
      case '/revenue':
        return MaterialPageRoute(builder: (context) => Revenue()); // Route de la page des recettes
      case '/manageAccounts':
        return MaterialPageRoute(builder: (context) => ManageAccounts()); // Route de la page de gestion des comptes
      case '/manageAcceptor':
        return MaterialPageRoute(builder: (context) => ManageAcceptor()); // Route de la page de gestion des accepteurs
      case '/manageUser':
        return MaterialPageRoute(builder: (context) => ManageUser()); // Route de la page de gestion des utilisateurs et agents
      case '/telecollectMenu':
        return MaterialPageRoute(builder: (context) => TeleCollectMenu()); // Route de la page du menu de retraît et de télécollecte
      case '/website':
        return MaterialPageRoute(builder: (context) => Website()); // Route de la page du site web
      case '/facebook':
        return MaterialPageRoute(builder: (context) => FacebookPage()); // Route de la page Facebook
      case '/twitter':
        return MaterialPageRoute(builder: (context) => TwitterPage()); // Route de la page twitter
      case '/debitHistory':
        return MaterialPageRoute(builder: (context) => DebitHistory()); // Route de la page d'historique de débit
      case '/refillHistory':
        return MaterialPageRoute(builder: (context) => RefillHistory()); // Route de la page d'historique de débit
      case '/telecollectHistory':
        return MaterialPageRoute(builder: (context) => TelecollectHistory()); // Route de la page d'historique de débit
      case '/transferHistory':
        return MaterialPageRoute(builder: (context) => TransferHistory()); // Route de la page d'historique de débit
      case '/online':
        return MaterialPageRoute(builder: (context) => OnlineSupport()); // Route de la page d'assistance en ligne
      
      
      // Cette page sera chargée par défaut au cas où on ait commit une erreur sur une route
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child:Text('Erreur 404 : Page Introuvable')
            )
          )
        );
    }
  }
}