unit Stripe.Checkout.SessionCreateParams;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  Stripe.Checkout.SessionLineItemParams,
  Stripe.Checkout.Interfaces,
  Stripe.Constants;

type
  TStripeCheckoutSessionCreateParams = class(TInterfacedObject, IStripeCheckoutSessionCreateParams)
  private
    [weak]
    FParent: ICheckout;
    FSuccessUrl: string;
    FMode: string;
    FSessionLineItemParams: TList<IStripeCheckoutSessionLineItemParams>;
    FCancelUrl: string;
    FShippingAddressCollection: TArray<string>;

    function IsValid(AField, AFieldName: string): Boolean; overload;
  public
    constructor Create(AParent: ICheckout);
    destructor Destroy; override;
    class function New(AParent: ICheckout): IStripeCheckoutSessionCreateParams;
    function SuccessUrl(AValue: string): IStripeCheckoutSessionCreateParams; overload;
    function SuccessUrl: string; overload;
    function CancelUrl(AValue: string): IStripeCheckoutSessionCreateParams; overload;
    function CancelUrl: string; overload;
    function Mode(AValue: string): IStripeCheckoutSessionCreateParams; overload;
    function Mode: string; overload;
    function ShippingAddressCollection(ACoutries: TArray<string>): IStripeCheckoutSessionCreateParams; overload;
    function ShippingAddressCollection: TArray<string>; overload;
    function SessionLineItemParams: TList<IStripeCheckoutSessionLineItemParams>;
    function AddSessionLineItem: IStripeCheckoutSessionLineItemParams;
    function &End: ICheckout;
  end;

implementation

{ TStripeCheckoutSessionCreateParams }

function TStripeCheckoutSessionCreateParams.CancelUrl(AValue: string): IStripeCheckoutSessionCreateParams;
begin
  Result := Self;
  if IsValid(AValue, 'CancelUrl') then
    FCancelUrl := AValue;
end;

function TStripeCheckoutSessionCreateParams.&End: ICheckout;
begin
  Result := FParent;
end;

function TStripeCheckoutSessionCreateParams.IsValid(AField, AFieldName: string): Boolean;
begin
  Result := not AField.IsEmpty;
  if not Result then
    raise Exception.CreateFmt('%s field is not empty', [AFieldName]);
end;

function TStripeCheckoutSessionCreateParams.AddSessionLineItem: IStripeCheckoutSessionLineItemParams;
begin
  FSessionLineItemParams.Add(TStripeCheckoutSessionLineItemParams.New(Self));
  Result := FSessionLineItemParams.Last;
end;

function TStripeCheckoutSessionCreateParams.CancelUrl: string;
begin
  Result := FCancelUrl;
end;

constructor TStripeCheckoutSessionCreateParams.Create(AParent: ICheckout);
begin
  FParent := AParent;
  FSessionLineItemParams := TList<IStripeCheckoutSessionLineItemParams>.Create;
end;

destructor TStripeCheckoutSessionCreateParams.Destroy;
begin
  FSessionLineItemParams.Free;
  inherited;
end;

function TStripeCheckoutSessionCreateParams.Mode: string;
begin
  Result := FMode;
end;

class function TStripeCheckoutSessionCreateParams.New(AParent: ICheckout): IStripeCheckoutSessionCreateParams;
begin
  Result := Self.Create(AParent);
end;

function TStripeCheckoutSessionCreateParams.Mode(AValue: string): IStripeCheckoutSessionCreateParams;
begin
  Result := Self;
  if IsValid(AValue, 'Mode') then
    FMode := AValue;
end;

function TStripeCheckoutSessionCreateParams.SuccessUrl(AValue: string): IStripeCheckoutSessionCreateParams;
begin
  Result := Self;
  if IsValid(AValue, 'SuccessUrl') then
    FSuccessUrl := AValue;
end;

function TStripeCheckoutSessionCreateParams.SessionLineItemParams: TList<IStripeCheckoutSessionLineItemParams>;
begin
  Result := FSessionLineItemParams;
end;

function TStripeCheckoutSessionCreateParams.ShippingAddressCollection: TArray<string>;
begin
  Result := FShippingAddressCollection;
end;

function TStripeCheckoutSessionCreateParams.ShippingAddressCollection(ACoutries: TArray<string>): IStripeCheckoutSessionCreateParams;
var
  I: Integer;
  LCountry: string;
  LIsValid: Boolean;
begin
  Result := Self;
  for LCountry in ACoutries do
  begin
    LIsValid := False;
    for I := Low(ALLOWED_COUNTRIES) to High(ALLOWED_COUNTRIES) do
      if LCountry.Equals(ALLOWED_COUNTRIES[I]) then
      begin
        LIsValid := True;
        Break;
      end;

    if not LIsValid then
    raise Exception.CreateFmt('Invalid country code %s. Only two-letter ISO country codes are allowed.',
      [LCountry]);
  end;

  SetLength(FShippingAddressCollection, Length(ACoutries));
  FShippingAddressCollection := ACoutries;
end;

function TStripeCheckoutSessionCreateParams.SuccessUrl: string;
begin
  Result := FSuccessUrl;
end;

end.
