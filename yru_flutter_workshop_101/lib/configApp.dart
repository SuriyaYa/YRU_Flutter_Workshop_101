
bool userAuth = true;
const enableLog = true; ///For debug mode [Enable=true , Disable=false]

///Log
// ignore: non_constant_identifier_names
LogDebug(String message){
  if(enableLog == true) {
    print('[yru_flutter_workshop>>] $message');
  }
}

///Api Service
const yru_service = 'c8f6363073eb.ngrok.io';
const api_login = '/api/auth/login';
const api_user = '/api/users';
String accessTokenSave = '';