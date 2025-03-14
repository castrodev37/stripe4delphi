unit Stripe.Checkout.CustomText.Entity;

interface

type
  TStripeCheckoutCustomTextEntity = class
  private
    FSubmit: Variant;
    FShippingAddress: Variant;
  public
    property ShippingAddress: Variant read FShippingAddress write FShippingAddress;
    property Submit: Variant read FSubmit write FSubmit;
  end;

implementation

end.
