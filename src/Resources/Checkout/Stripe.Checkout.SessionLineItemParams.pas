unit Stripe.Checkout.SessionLineItemParams;

interface

type
  TStripeCheckoutSessionLineItemParams = class
  private
    FPrice: string;
    FQuantity: Integer;
  public
    property Price: string read FPrice write FPrice;
    property Quantity: Integer read FQuantity write FQuantity;
  end;

implementation

end.
