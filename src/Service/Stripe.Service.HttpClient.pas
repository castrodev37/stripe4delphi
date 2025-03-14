unit Stripe.Service.HttpClient;

interface

uses
  System.SysUtils,
  System.Net.HttpClient,
  System.Net.URLClient,
  System.NetEncoding,
  System.Classes,
  System.NetConsts,
  Stripe.Service.HttpClient.Interfaces,
  Stripe.Constants;

type
  TStripeHttpClient = class(TInterfacedObject, IStripeHttpClient)
  private
    FHttpClient: THTTPClient;
    FContent: string;

    constructor Create(AApiKey: string);
  public
    destructor Destroy; override;
    class function New(AApiKey: string): IStripeHttpClient;

    function Post(AUrl: string; ABody: TStrings; AContentType: string = 'application/x-www-form-urlencoded'): IStripeHttpClient;
    function Get(AUrl: string; AContentType: string = 'application/x-www-form-urlencoded'): IStripeHttpClient;
    function Content: string;
  end;

implementation

{ TStripeHttpClient }

function TStripeHttpClient.Content: string;
begin
  Result := FContent;
end;

constructor TStripeHttpClient.Create(AApiKey: string);
var
  LAuthHeader: string;
begin
  FHttpClient := THTTPClient.Create;
  FHttpClient.ContentType := '';

  LAuthHeader := TNetEncoding.Base64.Encode(AApiKey + ':');
  LAuthHeader := StringReplace(LAuthHeader, sLineBreak, '', [rfReplaceAll]);
  LAuthHeader := 'Basic ' + LAuthHeader;

  FHttpClient.CustomHeaders['Authorization'] := LAuthHeader;
end;

destructor TStripeHttpClient.Destroy;
begin
  FHttpClient.Free;
  inherited;
end;

function TStripeHttpClient.Get(AUrl: string; AContentType: string = 'application/x-www-form-urlencoded'): IStripeHttpClient;
var
  LResponse: IHTTPResponse;
begin
  Result := Self;
  try
    FHttpClient.ContentType := AContentType;

    LResponse := FHttpClient.Get(AUrl);

    if not (LResponse.StatusCode = cSTATUS_OK) then
      raise Exception.CreateFmt('%s - Status: %d', [LResponse.ContentAsString, LResponse.StatusCode]);

    FContent := LResponse.ContentAsString;
  except
    on E: Exception do
      raise Exception.CreateFmt('Failed on GET Customer request: %s', [E.Message]);
  end;
end;

class function TStripeHttpClient.New(AApiKey: string): IStripeHttpClient;
begin
  Result := Self.Create(AApiKey);
end;

function TStripeHttpClient.Post(AUrl: string; ABody: TStrings; AContentType: string = 'application/x-www-form-urlencoded'): IStripeHttpClient;
var
  LResponse: IHTTPResponse;
begin
  Result := Self;
  try
    FHttpClient.ContentType := AContentType;

    LResponse := FHttpClient.Post(AUrl, ABody, nil, TEncoding.UTF8);

    if not (LResponse.StatusCode = cSTATUS_OK) then
      raise Exception.CreateFmt('%s - Status: %d', [LResponse.ContentAsString, LResponse.StatusCode]);

    FContent := LResponse.ContentAsString;
  except
    on E: Exception do
      raise Exception.CreateFmt('Failed on POST request: %s', [E.Message]);
  end;
end;

end.

