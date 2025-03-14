unit Stripe.Customer;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  System.RegularExpressions,
  System.NetEncoding,
  Stripe.Customer.Interfaces,
  Stripe.Service.HttpClient.Interfaces,
  Stripe.Customer.Entity,
  Stripe.Constants;

type
  TCustomer = class(TInterfacedObject, ICustomer)
  private
    FHttpClient: IStripeHttpClient;
    FCustomerEntity: TStripeCustomerEntity;
    FName: string;
    FEmail: string;

    constructor Create(AHttpClient: IStripeHttpClient);

    function IsValid(AFieldText, AFieldName: string): Boolean;
    function IsValidEmail(AEmail: string): Boolean;
    function ValidateFields: Boolean;
  protected
    function Name(AValue: string): ICustomer;
    function Email(AValue: string): ICustomer;
    function Id: string;
    function CreateCustomer: ICustomer;
    function RetrieveCustomer(AId: string): TStripeCustomerEntity;
  public
    class function New(AHttpClient: IStripeHttpClient): ICustomer;
  end;

const
  cEMAIL_REGEX = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

implementation

{ TCustomer }

constructor TCustomer.Create(AHttpClient: IStripeHttpClient);
begin
  FHttpClient := AHttpClient;
end;

function TCustomer.CreateCustomer: ICustomer;
var
  LParams: TStringList;
  LCustomerURL, LContent: string;
  LJSON: TJSONObject;
begin
  if not ValidateFields then
    raise Exception.Create('Preencha os dados do cliente');

  Result := Self;
  LParams := TStringList.Create;
  try
    LJSON := TJSONObject.Create;
    try
      LCustomerURL := Format('%s/%s', [cBASE_URL, cCUSTOMERS_RESOURCE]);
      LParams.Add('name=' + TNetEncoding.URL.Encode(FName));
      LParams.Add('email=' + TNetEncoding.URL.Encode(FEmail));

      LContent := FHttpClient.Post(LCustomerURL, LParams).Content;
      LJSON := TJSONObject.ParseJSONValue(LContent) as TJSONObject;
      FCustomerEntity := TStripeCustomerEntity.New(LJSON);
    finally
      LJSON.Free;
    end;
  finally
    LParams.Free;
  end;
end;

function TCustomer.Email(AValue: string): ICustomer;
begin
  Result := Self;
  if IsValid(AValue, 'E-mail') and IsValidEmail(AValue) then
    FEmail := AValue;
end;

function TCustomer.Id: string;
begin
  if not Assigned(FCustomerEntity) then
    Exit('');
  Result := FCustomerEntity.Id;
end;

function TCustomer.IsValid(AFieldText, AFieldName: string): Boolean;
begin
  Result := not AFieldText.IsEmpty;
  if not Result then
    raise Exception.CreateFmt('Campo %s não pode ser vazio', [AFieldName]);
end;

function TCustomer.IsValidEmail(AEmail: string): Boolean;
begin
  Result := TRegex.IsMatch(AEmail, cEMAIL_REGEX);
  if not Result then
    raise Exception.Create('Error formatting email');
end;

function TCustomer.Name(AValue: string): ICustomer;
begin
  Result := Self;
  if IsValid(AValue, 'Name') then
    FName := AValue;
end;

class function TCustomer.New(AHttpClient: IStripeHttpClient): ICustomer;
begin
  Result := Self.Create(AHttpClient);
end;

function TCustomer.RetrieveCustomer(AId: string): TStripeCustomerEntity;
var
  LCustomerURL, LContent: string;
  LJSON: TJSONObject;
begin
  if AId.IsEmpty then
    raise Exception.Create('Customer ID is required');

  LCustomerURL := Format('%s/%s/%s', [cBASE_URL, cCUSTOMERS_RESOURCE, AId]);

  LContent := FHttpClient.Get(LCustomerURL).Content;
  LJSON := TJSONObject.ParseJSONValue(LContent) as TJSONObject;
  Result := TStripeCustomerEntity.New(LJSON);
end;

function TCustomer.ValidateFields: Boolean;
begin
  Result := not (FName.IsEmpty and FEmail.IsEmpty);
end;

end.
