unit Stripe.Checkout.Interfaces;

interface

uses
  Stripe.Checkout.Entity;

type
  ICheckout = interface
  ['{6C880ECC-3585-4E5E-B7AE-0641B89D279D}']
    function SuccessUrl(AValue: string): ICheckout;
    function Price(AValue: string): ICheckout;
    function Quantity(AValue: Integer): ICheckout;
    function Mode(AValue: string): ICheckout;

    function CreateSession: ICheckout;
    function This: TStripeCheckoutEntity;
  end;

implementation

end.
