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
    FSessionCreateParams: IStripeCheckoutSessionCreateParams;
    FCheckoutEntity: TStripeCheckoutEntity;
    FHttpClient: IStripeHttpClient;
  protected
    constructor Create(AHttpClient: IStripeHttpClient);

    function SessionCreateParams: IStripeCheckoutSessionCreateParams;
    function CreateSession: ICheckout;
    function This: TStripeCheckoutEntity;
  public
    destructor Destroy; override;
    class function New(AHttpClient: IStripeHttpClient): ICheckout;
  end;

implementation

{ TCheckout }

constructor TCheckout.Create(AHttpClient: IStripeHttpClient);
begin
  FHttpClient := AHttpClient;
end;

function TCheckout.CreateSession: ICheckout;
var
  LParams: TStringList;
  LCheckoutURL, LContent, LCountry: string;
  LJSON: TJSONObject;
  LSessionLineItemParams: IStripeCheckoutSessionLineItemParams;
  LCount: Integer;
begin
  if not Assigned(FSessionCreateParams) then
    raise Exception.Create('Checkout session params is required');

  Result := Self;
  LParams := TStringList.Create;
  LCount := 0;
  try
    LJSON := TJSONObject.Create;
    try
      LCheckoutURL := Format('%s/%s', [cBASE_URL, cCHECKOUT_SESSIONS]);
      LParams.Add('success_url=' + FSessionCreateParams.SuccessUrl);
      LParams.Add('mode=' + TNetEncoding.URL.Encode(FSessionCreateParams.Mode));

      for LSessionLineItemParams in FSessionCreateParams.SessionLineItemParams do
      begin
        LParams.Add(Format('line_items[%d][price]=', [LCount]) +
          TNetEncoding.URL.Encode(LSessionLineItemParams.Price));
        LParams.Add(Format('line_items[%d][quantity]=', [LCount]) +
          TNetEncoding.URL.Encode(LSessionLineItemParams.Quantity.ToString));
        Inc(LCount);
      end;

      if Length(FSessionCreateParams.ShippingAddressCollection) > 0 then
      begin
        LCount := 0;
        for LCountry in FSessionCreateParams.ShippingAddressCollection do
        begin
          if LCountry.IsEmpty then
            raise Exception.Create(Format('Country at index %d cannot be empty', [LCount]));
          LParams.Add(Format('shipping_address_collection[allowed_countries][%d]=%s', [LCount, TNetEncoding.URL.Encode(LCountry)]));
          Inc(LCount);
        end;
      end;

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

class function TCheckout.New(AHttpClient: IStripeHttpClient): ICheckout;
begin
  Result := Self.Create(AHttpClient);
end;

function TCheckout.SessionCreateParams: IStripeCheckoutSessionCreateParams;
begin
  if not Assigned(FSessionCreateParams) then
    FSessionCreateParams := TStripeCheckoutSessionCreateParams.New(Self);
  Result := FSessionCreateParams;
end;

function TCheckout.This: TStripeCheckoutEntity;
begin
  Result := FCheckoutEntity;
end;

end.
