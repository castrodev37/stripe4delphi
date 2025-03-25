unit Stripe.Checkout.SessionLineItemParams;

interface

uses
  System.SysUtils,
  Stripe.Checkout.Interfaces;

type
  TStripeCheckoutSessionLineItemParams = class(TInterfacedObject, IStripeCheckoutSessionLineItemParams)
  private
    [weak]
    FParent: IStripeCheckoutSessionCreateParams;
    FPrice: string;
    FQuantity: Integer;

    function IsValid(AField, AFieldName: string): Boolean; overload;
    function IsValid(AField: Integer; AFieldName: string): Boolean; overload;
  protected
    constructor Create(AParent: IStripeCheckoutSessionCreateParams);

    function Price(AValue: string): IStripeCheckoutSessionLineItemParams; overload;
    function Price: string; overload;
    function Quantity(AValue: Integer): IStripeCheckoutSessionLineItemParams; overload;
    function Quantity: Integer; overload;
    function &End: IStripeCheckoutSessionCreateParams;
  public
    destructor Destroy; override;
    class function New(AParent: IStripeCheckoutSessionCreateParams): IStripeCheckoutSessionLineItemParams;
  end;

implementation

{ TStripeCheckoutSessionLineItemParams }

function TStripeCheckoutSessionLineItemParams.Price(AValue: string): IStripeCheckoutSessionLineItemParams;
begin
  Result := Self;
  if IsValid(AValue, 'Price') then
    FPrice := AValue;
end;

function TStripeCheckoutSessionLineItemParams.Quantity(AValue: Integer): IStripeCheckoutSessionLineItemParams;
begin
  Result := Self;
  if IsValid(AValue, 'Quantity') then
    FQuantity := AValue;
end;

constructor TStripeCheckoutSessionLineItemParams.Create(AParent: IStripeCheckoutSessionCreateParams);
begin
  FParent := AParent;
end;

destructor TStripeCheckoutSessionLineItemParams.Destroy;
begin

  inherited;
end;

function TStripeCheckoutSessionLineItemParams.&End: IStripeCheckoutSessionCreateParams;
begin
  Result := FParent;
end;

function TStripeCheckoutSessionLineItemParams.IsValid(AField: Integer; AFieldName: string): Boolean;
begin
  Result := not (AField = 0);
  if not Result then
    raise Exception.CreateFmt('%s field is not zero or empty', [AFieldName]);
end;

function TStripeCheckoutSessionLineItemParams.IsValid(AField, AFieldName: string): Boolean;
begin
  Result := not AField.IsEmpty;
  if not Result then
    raise Exception.CreateFmt('%s field is not empty', [AFieldName]);
end;

class function TStripeCheckoutSessionLineItemParams.New(AParent: IStripeCheckoutSessionCreateParams): IStripeCheckoutSessionLineItemParams;
begin
  Result := Self.Create(AParent);
end;

function TStripeCheckoutSessionLineItemParams.Price: string;
begin
  Result := FPrice;
end;

function TStripeCheckoutSessionLineItemParams.Quantity: Integer;
begin
  Result := FQuantity;
end;

end.
