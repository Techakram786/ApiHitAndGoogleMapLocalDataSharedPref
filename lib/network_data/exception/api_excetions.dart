class AppExceptions implements Exception{

  final _message;
  final _prifix;

  AppExceptions([this._message,this._prifix]);

  String toString(){
    return '$_message$_prifix';
  }
}

class InternetException extends AppExceptions{
  InternetException([String? message]):super(message,'No Internet Exception');

}

class RequestTimeOutException extends AppExceptions{
  RequestTimeOutException([String? message]):super(message,'Request Time Out Exception');

}

class InternalServerException extends AppExceptions{
  InternalServerException([String? message]):super(message,'Internal Server Exception');

}

class InvalidUrlException extends AppExceptions{
  InvalidUrlException([String? message]):super(message,'');

}

class FetchDataException extends AppExceptions{
  FetchDataException([String? message]):super(message,'Error while communication to server');

}