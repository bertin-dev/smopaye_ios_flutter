
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
  static String cardUser2 = '/children';
  static String account_transfer = 'api/account/transaction/payment';
  static String card_transfer = 'api/card/transaction/payment';
  static String toggle_balance1 = 'api/card/';
  static String toggle_balance2 = '/toggleUnityDeposit';
  static String checkBalance = 'api/card/';
  static String transaction = 'api/card/transaction/payment';
  static String qr_code1 = 'api/card/';
  static String qr_code2 = '/UserCard';
  static String retraitCompte = 'api/account/';
  static String retrait = 'retrait';
  static String retraitCarte = 'api/card/';
  static String rechargeCartebyCompte = 'api/account/';
  static String rechargecarte = '/rechargecarte';
  static String recharge = '/recharge';
  static String checkpayment = '/checkpayment';







  static String register = '/register';
  static String autoRegister = '/autoregister';

}