unit Stripe.Customer.Interfaces;

interface

uses
  Stripe.Customer.Entity;

type
  ICustomer = interface
  ['{84A8CE94-F958-4EFF-944D-365AF4DB8DCA}']
    function Name(AValue: string): ICustomer;
    function Email(AValue: string): ICustomer;
    function CreateCustomer: ICustomer;
    function RetrieveCustomer(AId: string): ICustomer;
    function This: TStripeCustomerEntity;
  end;

implementation

end.

