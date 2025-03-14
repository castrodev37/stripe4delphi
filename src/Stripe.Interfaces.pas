unit Stripe.Interfaces;

interface

uses
  Stripe.Customer.Interfaces;

type
  IStripe = interface
  ['{58FC0458-876F-447D-8088-39C756391FE4}']
    function Customer: ICustomer;
  end;

implementation

end.


