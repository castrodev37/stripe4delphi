unit Stripe.Customer.InvoiceSettings.Entity;

interface

uses
  System.JSON;

type
  TStripeCustomerInvoiceSettingsEntity = class
  private
    FCustomFields: string;
    FDefaultPaymentMethod: string;
    FFooter: string;
    FRenderingOptions: string;
  public
    constructor Create(AJson: TJSONObject);
  end;

implementation

{ TStripeCustomerInvoiceSettingsEntity }

constructor TStripeCustomerInvoiceSettingsEntity.Create(AJson: TJSONObject);
begin
  if Assigned(AJson) then
  begin
    FCustomFields := AJson.GetValue<string>('custom_fields');
    FDefaultPaymentMethod := AJson.GetValue<string>('default_payment_method');
    FFooter := AJson.GetValue<string>('footer');
    FRenderingOptions := AJson.GetValue<string>('rendering_options');
  end;
end;

end.
