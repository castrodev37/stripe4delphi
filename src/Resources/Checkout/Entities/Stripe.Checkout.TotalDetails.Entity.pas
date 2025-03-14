unit Stripe.Checkout.TotalDetails.Entity;

interface

type
  TStripeCheckoutTotalDetailsEntity = class
  private
    FAmountDiscount: Integer;
    FAmountTax: Integer;
    FAmountShipping: Integer;
  public
    property AmountDiscount: Integer read FAmountDiscount write FAmountDiscount;
    property AmountShipping: Integer read FAmountShipping write FAmountShipping;
    property AmountTax: Integer read FAmountTax write FAmountTax;
  end;

implementation

end.
