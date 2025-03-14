unit Stripe;

interface

uses
  System.SysUtils,
  Stripe.Interfaces,
  Stripe.Customer.Interfaces,
  Stripe.Service.HttpClient.Interfaces,
  Stripe.Service.HttpClient,
  Stripe.Classes;

type
  TStripe = class(TInterfacedObject, IStripe)
  private
    FHttpClient: IStripeHttpClient;
    FCustomer: ICustomer;

    constructor Create(AApiKey: string);
  protected
    function Customer: ICustomer;
  public
    destructor Destroy; override;
    class function New(AApiKey: string): IStripe;
  end;

implementation

{ TStripe }

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

