unit Main.Controller;

interface

uses
  System.SysUtils, System.Net.HttpClient, System.Net.URLClient, System.NetConsts, System.Classes, Main.DTO;

type
  TBaseResponse = record
    Status: Integer;
    Json: string;

    StartDate: TDateTime;
    EndDate: TDateTime;

    function Time: TDateTime;
    procedure Clear;
  end;

  TMainController = class(TObject)
  private
    const
      BASE_URL = 'http://localhost:7000';
  public
    class function Get(const AResource: string = '/'): TBaseResponse;
    class function Post(const AResource: string; const AJsonDTO: TDTO): TBaseResponse;
    class function Put(const AResource: string; const AJsonDTO: TDTO): TBaseResponse;
    class function Delete(const AResource: string): TBaseResponse;
  end;

implementation

{ TBaseResponse }

function TBaseResponse.Time: TDateTime;
begin
  Result := EndDate - StartDate;
end;

procedure TBaseResponse.Clear;
begin
  Self := Default(TBaseResponse);
end;

{ TMainController }

class function TMainController.Get(const AResource: string): TBaseResponse;
var
  HttpClient: THTTPClient;
  HttpResponse: IHTTPResponse;
begin
  Result.StartDate := Now;

  HttpClient := THTTPClient.Create;
  try
    HttpResponse := HttpClient.Get(BASE_URL + AResource);

    Result.Status := HttpResponse.StatusCode;
    Result.Json := HttpResponse.ContentAsString;
  finally
    HttpClient.Free;
  end;

  Result.EndDate := Now;
end;

class function TMainController.Post(const AResource: string; const AJsonDTO: TDTO): TBaseResponse;
var
  HttpClient: THTTPClient;
  HttpResponse: IHTTPResponse;
  JsonToSend: TStringStream;
begin
  Result.StartDate := Now;

  HttpClient := THTTPClient.Create;
  try
    HttpClient.ContentType := 'application/json';

    JsonToSend := TStringStream.Create(UTF8Encode(AJsonDTO.AsJson));
    try
      HttpResponse := HttpClient.Post(BASE_URL + AResource, JsonToSend);

      Result.Status := HttpResponse.StatusCode;
      Result.Json := HttpResponse.ContentAsString;
    finally
      JsonToSend.Free;
    end;
  finally
    HttpClient.Free;
  end;

  Result.EndDate := Now;
end;

class function TMainController.Put(const AResource: string; const AJsonDTO: TDTO): TBaseResponse;
var
  HttpClient: THTTPClient;
  HttpResponse: IHTTPResponse;
  JsonToSend: TStringStream;
begin
  Result.StartDate := Now;

  HttpClient := THTTPClient.Create;
  try
    HttpClient.ContentType := 'application/json';

    JsonToSend := TStringStream.Create(UTF8Encode(AJsonDTO.AsJson));
    try
      HttpResponse := HttpClient.Put(BASE_URL + AResource, JsonToSend);

      Result.Status := HttpResponse.StatusCode;
      Result.Json := HttpResponse.ContentAsString;
    finally
      JsonToSend.Free;
    end;
  finally
    HttpClient.Free;
  end;

  Result.EndDate := Now;
end;

class function TMainController.Delete(const AResource: string): TBaseResponse;
var
  HttpClient: THTTPClient;
  HttpResponse: IHTTPResponse;
begin
  Result.StartDate := Now;

  HttpClient := THTTPClient.Create;
  try
    HttpResponse := HttpClient.Delete(BASE_URL + AResource);

    Result.Status := HttpResponse.StatusCode;
    Result.Json := HttpResponse.ContentAsString;
  finally
    HttpClient.Free;
  end;

  Result.EndDate := Now;
end;

end.

