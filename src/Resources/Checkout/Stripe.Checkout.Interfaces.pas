unit Stripe.Checkout.Interfaces;

interface

uses
  System.Generics.Collections,
  Stripe.Checkout.Entity;

type
  IStripeCheckoutSessionLineItemParams = interface;
  IStripeCheckoutSessionCreateParams = interface;

  ICheckout = interface
  ['{6C880ECC-3585-4E5E-B7AE-0641B89D279D}']
    function SessionCreateParams: IStripeCheckoutSessionCreateParams;
    function CreateSession: ICheckout;
    function This: TStripeCheckoutEntity;
  end;

  IStripeCheckoutSessionCreateParams = interface
  ['{9FE9E8C5-6C5E-409F-9E73-6A74189E9D49}']
    function SuccessUrl(AValue: string): IStripeCheckoutSessionCreateParams; overload;
    function SuccessUrl: string; overload;
    function CancelUrl(AValue: string): IStripeCheckoutSessionCreateParams; overload;
    function CancelUrl: string; overload;
    function Mode(AValue: string): IStripeCheckoutSessionCreateParams; overload;
    function Mode: string; overload;
    function SessionLineItemParams: TList<IStripeCheckoutSessionLineItemParams>;
    function AddSessionLineItem: IStripeCheckoutSessionLineItemParams;
    function ShippingAddressCollection(ACoutries: TArray<string>): IStripeCheckoutSessionCreateParams; overload;
    function ShippingAddressCollection: TArray<string>; overload;
    function &End: ICheckout;
  end;

  IStripeCheckoutSessionLineItemParams = interface
  ['{A4DAA694-A03C-40E9-9C39-F0EE28C23719}']
    function Price(AValue: string): IStripeCheckoutSessionLineItemParams; overload;
    function Price: string; overload;
    function Quantity(AValue: Integer): IStripeCheckoutSessionLineItemParams; overload;
    function Quantity: Integer; overload;
    function &End: IStripeCheckoutSessionCreateParams;
  end;

implementation

end.
