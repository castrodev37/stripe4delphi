unit Stripe;

interface

uses
  System.SysUtils,
  Stripe.Interfaces,
  Stripe.Customer.Interfaces,
  Stripe.Checkout.Interfaces,
  Stripe.Service.HttpClient.Interfaces,
  Stripe.Service.HttpClient,
  Stripe.Classes,
  Stripe.Checkout.SessionCreateParams;

type
  TStripe = class(TInterfacedObject, IStripe)
  private
    FHttpClient: IStripeHttpClient;
    FCustomer: ICustomer;
    FCheckout: ICheckout;

    constructor Create(AApiKey: string);
  protected
    function Customer: ICustomer;
    function Checkout: ICheckout;
  public
    destructor Destroy; override;
    class function New(AApiKey: string): IStripe;
  end;

implementation

{ TStripe }

function TStripe.Checkout: ICheckout;
begin
  if not Assigned(FCheckout) then
    FCheckout := TCheckout.New(TStripeCheckoutSessionCreateParams.Create,
      FHttpClient);
  Result := FCheckout;
end;

constructor TStripe.Create(AApiKey: string);
begin
  FHttpClient := TStripeHttpClient.New(AApiKey);
end;

function TStripe.Customer: ICustomer;
begin
  if not Assigned(FCustomer) then
    FCustomer := TCustomer.New(FHttpClient);
  Result := FCustomer;
end;

destructor TStripe.Destroy;
begin

  inherited;
end;

class function TStripe.New(AApiKey: string): IStripe;
begin
  Result := Self.Create(AApiKey);
end;

end.

