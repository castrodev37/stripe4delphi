unit Stripe.Checkout.AutomaticTax.Entity;

interface

type
  TStripeCheckoutAutomaticTaxEntity = class
  private
    FEnabled: Variant;
    FLiability: Variant;
    FStatus: Variant;
  public
    property Enabled: Variant read FEnabled write FEnabled;
    property Liability: Variant read FLiability write FLiability;
    property Status: Variant read FStatus write FStatus;
  end;

implementation

end.
