unit Stripe.Checkout.Entity;

interface

uses
  System.Classes,
  System.SysUtils,
  System.JSON,
  System.Variants,
  System.Generics.Collections,
  Stripe.Checkout.AutomaticTax.Entity,
  Stripe.Checkout.CustomText.Entity,
  Stripe.Checkout.InvoiceCreation.Entity,
  Stripe.Checkout.PhoneNumberCollection.Entity,
  Stripe.Checkout.TotalDetails.Entity;

type
  TStripeCheckoutEntity = class
  private
    FMode: string;
    FPaymentMethodOptions: TObject;
    FCustomerCreation: string;
    FConsentCollection: Variant;
    FClientReferenceId: Variant;
    FSetupIntent: Variant;
    FCustomer: Variant;
    FCustomFields: TObjectList<TObject>;
    FCancelUrl: Variant;
    FCustomerDetails: Variant;
    FTotalDetails: TStripeCheckoutTotalDetailsEntity;
    FLocale: Variant;
    FCustomerEmail: Variant;
    FCreated: Int64;
    FBillingAddressCollection: Variant;
    FId: string;
    FStatus: string;
    FPaymentLink: Variant;
    FPhoneNumberCollection: TStripeCheckoutPhoneNumberCollectionEntity;
    FSubscription: Variant;
    FLiveMode: Variant;
    FConsent: Variant;
    FAllowPromotionCodes: Variant;
    FSubmitType: Variant;
    FRecoveredFrom: Variant;
    FAutomaticTax: TStripeCheckoutAutomaticTaxEntity;
    FAfterExpiration: Variant;
    FShippingOptions: TObjectList<TObject>;
    FPaymentIntent: Variant;
    FMetadata: TObject;
    FInvoiceCreation: TStripeCheckoutInvoiceCreationEntity;
    FUrl: string;
    FPaymentMethodTypes: TArray<string>;
    FPaymentStatus: string;
    FInvoice: Variant;
    FAmountSubtotal: Integer;
    FObject: string;
    FSuccessUrl: string;
    FPaymentMethodCollection: string;
    FExpiresAt: Int64;
    FCustomText: TStripeCheckoutCustomTextEntity;
    FShippingDetails: Variant;
    FShippingCost: Variant;
    FCurrency: string;
    FAmountTotal: Integer;
    FShippingAddressCollection: Variant;

    constructor Create(AJson: TJSONObject);

    function GetVariantValue(AJson: TJSONObject; const AKey: string): Variant;
    function GetValidJSONObject(const AJson: TJSONObject; const AKey: string): TJSONObject;
    procedure InitializeObjects;
  public
    class function New(AJson: TJSONObject): TStripeCheckoutEntity;
    destructor Destroy; override;

    property Id: string read FId write FId;
    property &Object: string read FObject write FObject;
    property AfterExpiration: Variant read FAfterExpiration write FAfterExpiration;
    property AllowPromotionCodes: Variant read FAllowPromotionCodes write FAllowPromotionCodes;
    property AmountSubtotal: Integer read FAmountSubtotal write FAmountSubtotal;
    property AmountTotal: Integer read FAmountTotal write FAmountTotal;
    property AutomaticTax: TStripeCheckoutAutomaticTaxEntity read FAutomaticTax write FAutomaticTax;
    property BillingAddressCollection: Variant read FBillingAddressCollection write FBillingAddressCollection;
    property CancelUrl: Variant read FCancelUrl write FCancelUrl;
    property ClientReferenceId: Variant read FClientReferenceId write FClientReferenceId;
    property Consent: Variant read FConsent write FConsent;
    property ConsentCollection: Variant read FConsentCollection write FConsentCollection;
    property Created: Int64 read FCreated write FCreated;
    property Currency: string read FCurrency write FCurrency;
    property CustomFields: TObjectList<TObject> read FCustomFields write FCustomFields;
    property CustomText: TStripeCheckoutCustomTextEntity read FCustomText write FCustomText;
    property Customer: Variant read FCustomer write FCustomer;
    property CustomerCreation: string read FCustomerCreation write FCustomerCreation;
    property CustomerDetails: Variant read FCustomerDetails write FCustomerDetails;
    property CustomerEmail: Variant read FCustomerEmail write FCustomerEmail;
    property ExpiresAt: Int64 read FExpiresAt write FExpiresAt;
    property Invoice: Variant read FInvoice write FInvoice;
    property InvoiceCreation: TStripeCheckoutInvoiceCreationEntity read FInvoiceCreation write FInvoiceCreation;
    property LiveMode: Variant read FLiveMode write FLiveMode;
    property Locale: Variant read FLocale write FLocale;
    property Metadata: TObject read FMetadata write FMetadata;
    property Mode: string read FMode write FMode;
    property PaymentIntent: Variant read FPaymentIntent write FPaymentIntent;
    property PaymentLink: Variant read FPaymentLink write FPaymentLink;
    property PaymentMethodCollection: string read FPaymentMethodCollection write FPaymentMethodCollection;
    property PaymentMethodOptions: TObject read FPaymentMethodOptions write FPaymentMethodOptions;
    property PaymentMethodTypes: TArray<string> read FPaymentMethodTypes write FPaymentMethodTypes;
    property PaymentStatus: string read FPaymentStatus write FPaymentStatus;
    property PhoneNumberCollection: TStripeCheckoutPhoneNumberCollectionEntity read FPhoneNumberCollection write FPhoneNumberCollection;
    property RecoveredFrom: Variant read FRecoveredFrom write FRecoveredFrom;
    property SetupIntent: Variant read FSetupIntent write FSetupIntent;
    property ShippingAddressCollection: Variant read FShippingAddressCollection write FShippingAddressCollection;
    property ShippingCost: Variant read FShippingCost write FShippingCost;
    property ShippingDetails: Variant read FShippingDetails write FShippingDetails;
    property ShippingOptions: TObjectList<TObject> read FShippingOptions write FShippingOptions;
    property Status: string read FStatus write FStatus;
    property SubmitType: Variant read FSubmitType write FSubmitType;
    property Subscription: Variant read FSubscription write FSubscription;
    property SuccessUrl: string read FSuccessUrl write FSuccessUrl;
    property TotalDetails: TStripeCheckoutTotalDetailsEntity read FTotalDetails write FTotalDetails;
    property Url: string read FUrl write FUrl;
  end;

implementation

{ TStripeCheckoutEntity }

function TStripeCheckoutEntity.GetValidJSONObject(const AJson: TJSONObject; const AKey: string): TJSONObject;
var
  AValue: TJSONValue;
begin
  Result := nil;
  AValue := AJson.GetValue(AKey);

  if (Assigned(AValue)) and (AValue is TJSONObject) then
    Result := TJSONObject(AValue)
end;

function TStripeCheckoutEntity.GetVariantValue(AJson: TJSONObject; const AKey: string): Variant;
var
  JsonValue: TJSONValue;
begin
  JsonValue := AJson.GetValue(AKey);
  if JsonValue.Null and (JsonValue is TJSONNull) then
    Exit(Null);

  if JsonValue is TJSONTrue then
    Exit(True)
  else if JsonValue is TJSONFalse then
    Exit(False)
  else if JsonValue is TJSONString then
    Exit(TJSONString(JsonValue).Value)
  else if JsonValue is TJSONNumber then
    Exit(TJSONNumber(JsonValue).AsDouble)
  else
    Exit(Null);
end;

constructor TStripeCheckoutEntity.Create(AJson: TJSONObject);
var
  LArray: TJSONArray;
  LJson: TJSONObject;
  LJsonValue: TJSONValue;
  I: Integer;
begin
  InitializeObjects;
  LArray := nil;

  FId := AJson.GetValue<string>('id');
  FObject := AJson.GetValue<string>('object');
  FAfterExpiration := GetVariantValue(AJson, 'after_expiration');
  FAllowPromotionCodes := GetVariantValue(AJson, 'allow_promotion_codes');
  FAmountSubtotal := AJson.GetValue<Integer>('amount_subtotal');
  FAmountTotal := AJson.GetValue<Integer>('amount_total');

  LJson := GetValidJSONObject(AJson, 'automatic_tax');
  if Assigned(LJson) then
  begin
    FAutomaticTax.Enabled := GetVariantValue(LJson, 'enabled');
    FAutomaticTax.Liability := GetVariantValue(LJson, 'liability');
    FAutomaticTax.Status := GetVariantValue(LJson, 'status');
  end;

  FBillingAddressCollection := GetVariantValue(AJson, 'billing_address_collection');
  FCancelUrl := GetVariantValue(AJson, 'cancel_url');
  FClientReferenceId := GetVariantValue(AJson, 'client_reference_id');
  FConsent := GetVariantValue(AJson, 'consent');
  FConsentCollection := GetVariantValue(AJson, 'consent_collection');
  FCreated := AJson.GetValue<Int64>('created');
  FCurrency := AJson.GetValue<string>('currency');
  FCustomer := GetVariantValue(AJson, 'customer');
  FCustomerCreation := AJson.GetValue<string>('customer_creation');
  FCustomerDetails := GetVariantValue(AJson, 'customer_details');
  FCustomerEmail := GetVariantValue(AJson, 'customer_email');
  FExpiresAt := AJson.GetValue<Int64>('expires_at');
  FInvoice := GetVariantValue(AJson, 'invoice');

  LJson := GetValidJSONObject(AJson, 'invoice_creation');
  if Assigned(LJson) then
  begin
    FInvoiceCreation.Enabled := GetVariantValue(LJson, 'enabled');
    LJson := GetValidJSONObject(AJson.GetValue<TJSONObject>('invoice_creation'), 'invoice_data');
    if Assigned(LJson) then
    begin
      FInvoiceCreation.InvoiceData.AccountTaxIds := GetVariantValue(LJson, 'account_tax_ids');
      FInvoiceCreation.InvoiceData.CustomFields := GetVariantValue(LJson, 'custom_fields');
      FInvoiceCreation.InvoiceData.Description := GetVariantValue(LJson, 'description');
      FInvoiceCreation.InvoiceData.Footer := GetVariantValue(LJson, 'footer');
      FInvoiceCreation.InvoiceData.Issuer := GetVariantValue(LJson, 'issuer');
      FInvoiceCreation.InvoiceData.Metadata := LJson.GetValue<TObject>('metadata');
      FInvoiceCreation.InvoiceData.RenderingOptions := GetVariantValue(LJson, 'rendering_options');
    end;
  end;
  FLiveMode := GetVariantValue(AJson, 'livemode');
  FLocale := GetVariantValue(AJson, 'locale');
  FMetadata := AJson.GetValue<TObject>('metadata');
  FMode := AJson.GetValue<string>('mode');
  FPaymentIntent := GetVariantValue(AJson, 'payment_intent');
  FPaymentLink := GetVariantValue(AJson, 'payment_link');
  FPaymentMethodCollection := AJson.GetValue<string>('payment_method_collection');
  FPaymentMethodOptions := AJson.GetValue<TObject>('payment_method_options');

  LJsonValue := AJson.GetValue('payment_method_types');
  if Assigned(LJsonValue) and (LJsonValue is TJSONArray) then
  begin
    LArray := LArray as TJSONArray;
    if LArray <> nil then
    begin
      SetLength(FPaymentMethodTypes, LArray.Count);
      for I := 0 to Pred(LArray.Count) do
        FPaymentMethodTypes[I] := LArray.Items[I].Value;
    end;
  end;

  FPaymentStatus := AJson.GetValue<string>('payment_status');

  LJson := GetValidJSONObject(AJson, 'phone_number_collection');
  if Assigned(LJson) then
    FPhoneNumberCollection.Enabled := GetVariantValue(LJson, 'enabled');

  FRecoveredFrom := GetVariantValue(AJson, 'recovered_from');
  FSetupIntent := GetVariantValue(AJson, 'setup_intent');
  FShippingAddressCollection := GetVariantValue(AJson, 'shipping_address_collection');
  FShippingCost := GetVariantValue(AJson, 'shipping_cost');
  FShippingDetails := GetVariantValue(AJson, 'shipping_details');
  FStatus := AJson.GetValue<string>('status');
  FSubmitType := GetVariantValue(AJson, 'submit_type');
  FSubscription := GetVariantValue(AJson, 'subscription');
  FSuccessUrl := AJson.GetValue<string>('success_url');

  LJson := GetValidJSONObject(AJson, 'total_details');
  if Assigned(LJson) then
  begin
    FTotalDetails.AmountDiscount := LJson.GetValue<Integer>('amount_discount');
    FTotalDetails.AmountShipping := LJson.GetValue<Integer>('amount_shipping');
    FTotalDetails.AmountTax := LJson.GetValue<Integer>('amount_tax');
  end;

  FUrl := AJson.GetValue<string>('url');

  LJson := GetValidJSONObject(AJson, 'custom_text');
  if Assigned(LJson) then
  begin
    FCustomText.Submit := GetVariantValue(LJson, 'submit');
    FCustomText.ShippingAddress := GetVariantValue(LJson, 'shipping_address');
  end;
end;

destructor TStripeCheckoutEntity.Destroy;
begin
  FPaymentMethodOptions.Free;
  FCustomFields.Free;
  FTotalDetails.Free;
  FPhoneNumberCollection.Free;
  FAutomaticTax.Free;
  FShippingOptions.Free;
  FInvoiceCreation.Free;
  FCustomText.Free;
  inherited;
end;

procedure TStripeCheckoutEntity.InitializeObjects;
begin
  FPaymentMethodOptions := TObject.Create;
  FCustomFields := TObjectList<TObject>.Create;
  FTotalDetails := TStripeCheckoutTotalDetailsEntity.Create;
  FPhoneNumberCollection := TStripeCheckoutPhoneNumberCollectionEntity.Create;
  FAutomaticTax := TStripeCheckoutAutomaticTaxEntity.Create;
  FShippingOptions := TObjectList<TObject>.Create;
  FInvoiceCreation := TStripeCheckoutInvoiceCreationEntity.Create;
  FCustomText := TStripeCheckoutCustomTextEntity.Create;
end;

class function TStripeCheckoutEntity.New(AJson: TJSONObject): TStripeCheckoutEntity;
begin
  if not Assigned(AJson) then
    Exit(nil);

  Result := Self.Create(AJson);
end;

end.
