unit Stripe.Checkout.InvoiceCreation.Entity;

interface

uses
  Stripe.Checkout.InvoiceData.Entity;

type
  TStripeCheckoutInvoiceCreationEntity = class
  private
    FEnabled: Variant;
    FInvoiceData: TStripeCheckoutInvoiceDataEntity;
  public
    constructor Create;
    destructor Destroy; override;

    property Enabled: Variant read FEnabled write FEnabled;
    property InvoiceData: TStripeCheckoutInvoiceDataEntity read FInvoiceData write FInvoiceData;
  end;

implementation

{ TStripeCheckoutInvoiceCreationEntity }

constructor TStripeCheckoutInvoiceCreationEntity.Create;
begin
  FInvoiceData := TStripeCheckoutInvoiceDataEntity.Create;
end;

destructor TStripeCheckoutInvoiceCreationEntity.Destroy;
begin
  FInvoiceData.Free;
  inherited;
end;

end.
