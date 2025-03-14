unit Stripe.Customer.Interfaces;

interface

type
  ICustomer = interface
  ['{84A8CE94-F958-4EFF-944D-365AF4DB8DCA}']
    function Name(AValue: string): ICustomer;
    function Email(AValue: string): ICustomer;
    function Id: string;
    function CreateCustomer: ICustomer;
  end;

implementation

end.

