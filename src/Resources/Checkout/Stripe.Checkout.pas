unit Stripe.Checkout;

interface

uses
  System.SysUtils,
  System.Classes,
  SYstem.JSON,
  System.NetEncoding,
  Stripe.Service.HttpClient.Interfaces,
  Stripe.Checkout.Interfaces,
  Stripe.Checkout.SessionCreateParams,
  Stripe.Checkout.SessionLineItemParams,
  Stripe.Checkout.Entity,
  Stripe.Constants;

type
  TCheckout = class(TInterfacedObject, ICheckout)
  private
    FParams: TStripeCheckoutSessionCreateParams;
    FLineItemParams: TStripeCheckoutSessionLineItemParams;
    FCheckoutEntity: TStripeCheckoutEntity;
    FHttpClient: IStripeHttpClient;

    function IsValid(AFieldText, AFieldName: string): Boolean;
    function ValidateFields: Boolean;
  protected
    function SuccessUrl(AValue: string): ICheckout;
    function Price(AValue: string): ICheckout;
    function Quantity(AValue: Integer): ICheckout;
    function Mode(AValue: string): ICheckout;

    function CreateSession: ICheckout;
    function This: TStripeCheckoutEntity;
  public
    constructor Create(AParams: TStripeCheckoutSessionCreateParams; AHttpClient: IStripeHttpClient);
    destructor Destroy; override;
    class function New(AParams: TStripeCheckoutSessionCreateParams; AHttpClient: IStripeHttpClient): ICheckout;
  end;

implementation

{ TCheckout }

constructor TCheckout.Create(AParams: TStripeCheckoutSessionCreateParams; AHttpClient: IStripeHttpClient);
begin
  FHttpClient := AHttpClient;

  FParams := AParams;
  FParams.SessionLineItemParams.Add(TStripeCheckoutSessionLineItemParams.Create);
  FLineItemParams := FParams.SessionLineItemParams.Last;
end;

function TCheckout.CreateSession: ICheckout;
var
  LParams: TStringList;
  LCheckoutURL, LContent: string;
  LJSON: TJSONObject;
begin
  if not ValidateFields then
    raise Exception.Create('Checkout session params is required');

  Result := Self;
  LParams := TStringList.Create;
  try
    LJSON := TJSONObject.Create;
    try
      LCheckoutURL := Format('%s/%s', [cBASE_URL, cCHECKOUT_SESSIONS]);
      LParams.Add('success_url=' + FParams.SuccessUrl);
      LParams.Add('mode=' + TNetEncoding.URL.Encode(FParams.Mode));
      LParams.Add('line_items[0][price]=' + TNetEncoding.URL.Encode(FLineItemParams.Price));
      LParams.Add('line_items[0][quantity]=' + TNetEncoding.URL.Encode(FLineItemParams.Quantity.ToString));

      LContent := FHttpClient.Post(LCheckoutURL, LParams).Content;
      LJSON := TJSONObject.ParseJSONValue(LContent) as TJSONObject;
      FCheckoutEntity := TStripeCheckoutEntity.New(LJSON);
    finally
      LJSON.Free;
    end;
  finally
    LParams.Free;
  end;
end;

destructor TCheckout.Destroy;
begin

  inherited;
end;

function TCheckout.IsValid(AFieldText, AFieldName: string): Boolean;
begin
  Result := not AFieldText.IsEmpty;
  if not Result then
    raise Exception.CreateFmt('%s field is not empty', [AFieldName]);
end;

function TCheckout.Mode(AValue: string): ICheckout;
begin
  Result := Self;
  if IsValid(AValue, 'Mode') then
    FParams.Mode := AValue;
end;

class function TCheckout.New(AParams: TStripeCheckoutSessionCreateParams; AHttpClient: IStripeHttpClient): ICheckout;
begin
  Result := Self.Create(AParams, AHttpClient);
end;

function TCheckout.Price(AValue: string): ICheckout;
begin
  Result := Self;
  if IsValid(AValue, 'Price') then
    FLineItemParams.Price := AValue;
end;

function TCheckout.Quantity(AValue: Integer): ICheckout;
begin
  Result := Self;
  if AValue <= 0 then
    raise Exception.Create('Invalid Quantity Field');
  FLineItemParams.Quantity := AValue;
end;

function TCheckout.SuccessUrl(AValue: string): ICheckout;
begin
  Result := Self;
  if IsValid(AValue, 'SuccessUrl') then
    FParams.SuccessUrl := AValue;
end;

function TCheckout.This: TStripeCheckoutEntity;
begin
  Result := FCheckoutEntity;
end;

function TCheckout.ValidateFields: Boolean;
begin
  Result := not (
    FParams.Mode.IsEmpty
    and FParams.SuccessUrl.IsEmpty
    and FParams.SessionLineItemParams.Last.Price.IsEmpty
    and (FParams.SessionLineItemParams.Last.Quantity = 0));
end;

end.
