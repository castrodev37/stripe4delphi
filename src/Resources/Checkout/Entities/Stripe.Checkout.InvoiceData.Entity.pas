unit Stripe.Checkout.InvoiceData.Entity;

interface

type
  TStripeCheckoutInvoiceDataEntity = class
  private
    FRenderingOptions: Variant;
    FCustomFields: Variant;
    FDescription: Variant;
    FIssuer: Variant;
    FFooter: Variant;
    FMetadata: TObject;
    FAccountTaxIds: Variant;
  public
    constructor Create;
    destructor Destroy; override;

    property AccountTaxIds: Variant read FAccountTaxIds write FAccountTaxIds;
    property CustomFields: Variant read FCustomFields write FCustomFields;
    property Description: Variant read FDescription write FDescription;
    property Footer: Variant read FFooter write FFooter;
    property Issuer: Variant read FIssuer write FIssuer;
    property Metadata: TObject read FMetadata write FMetadata;
    property RenderingOptions: Variant read FRenderingOptions write FRenderingOptions;
  end;

implementation

{ TStripeCheckoutInvoiceDataEntity }

constructor TStripeCheckoutInvoiceDataEntity.Create;
begin
  FMetadata := TObject.Create;
end;

destructor TStripeCheckoutInvoiceDataEntity.Destroy;
begin
  FMetadata.Free;
  inherited;
end;

end.
