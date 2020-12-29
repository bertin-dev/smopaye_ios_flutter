
class Endpoints {

  //Racine de l'API PRODUCTION
  //static String baseUrl = 'https://webservice.domaineteste.space.smopaye.fr/public/';

  //Racine de l'API TEST
  static String baseUrl = 'https://smp1020.webservice.api.domaine.test.ezpass.smopaye.fr/public/';
  
  //Routes d'authentification
  static String login = 'api/auth/login';
  static String reset_password = 'api/renitializePassword';
  static String profilUser = 'api/user/profile/';
  static String cardUser = 'api/user/';
  static String account_transfer = 'api/account/transaction/payment';


  static String register = '/register';
  static String autoRegister = '/autoregister';

}