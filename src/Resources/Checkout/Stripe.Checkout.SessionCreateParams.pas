unit Stripe.Checkout.SessionCreateParams;

interface

uses
  System.Generics.Collections,
  Stripe.Checkout.SessionLineItemParams;

type
  TStripeCheckoutSessionCreateParams = class
  private
    FSuccessUrl: string;
    FMode: string;
    FSessionLineItemParams: TObjectList<TStripeCheckoutSessionLineItemParams>;
  public
    constructor Create;
    destructor Destroy; override;
    property SuccessUrl: string read FSuccessUrl write FSuccessUrl;
    property Mode: string read FMode write FMode;
    property SessionLineItemParams: TObjectList<TStripeCheckoutSessionLineItemParams> read FSessionLineItemParams write FSessionLineItemParams;
  end;

implementation

{ TStripeCheckoutSessionCreateParams }

constructor TStripeCheckoutSessionCreateParams.Create;
begin
  FSessionLineItemParams := TObjectList<TStripeCheckoutSessionLineItemParams>.Create;
end;

destructor TStripeCheckoutSessionCreateParams.Destroy;
begin
  FSessionLineItemParams.Free;
  inherited;
end;

end.
