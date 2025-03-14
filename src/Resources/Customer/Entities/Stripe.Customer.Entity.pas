unit Stripe.Customer.Entity;

interface

uses
  System.SysUtils,
  System.JSON,
  Stripe.Customer.InvoiceSettings.Entity;

type
  TStripeCustomerEntity = class
  private
    FNextInvoiceSequence: Integer;
    FTaxExempt: string;
    FName: string;
    FInvoiceSettings: TStripeCustomerInvoiceSettingsEntity;
    FEmail: string;
    FPreferredLocales: TArray<string>;
    FDelinquent: Boolean;
    FPhone: string;
    FCreated: Int64;
    FId: string;
    FDiscount: string;
    FDescription: string;
    FObject: string;
    FLivemode: Boolean;
    FDefaultSource: string;
    FInvoicePrefix: string;
    FTestClock: string;
    FMetadata: TJSONObject;
    FBalance: Integer;
    FAddress: string;
    FShipping: string;
    FCurrency: string;
    FStripeCustomerInvoiceSettingsEntity: TStripeCustomerInvoiceSettingsEntity;

    constructor Create(AJson: TJSONObject);
   public
    class function New(AJson: TJSONObject): TStripeCustomerEntity;
    destructor Destroy; override;
    property Id: string read FId;
    property ObjectType: string read FObject;
    property Address: string read FAddress;
    property Balance: Integer read FBalance;
    property Created: Int64 read FCreated;
    property Currency: string read FCurrency;
    property DefaultSource: string read FDefaultSource;
    property Delinquent: Boolean read FDelinquent;
    property Description: string read FDescription;
    property Discount: string read FDiscount;
    property Email: string read FEmail;
    property InvoicePrefix: string read FInvoicePrefix;
    property InvoiceSettings: TStripeCustomerInvoiceSettingsEntity read FInvoiceSettings;
    property Livemode: Boolean read FLivemode;
    property Metadata: TJSONObject read FMetadata;
    property Name: string read FName;
    property NextInvoiceSequence: Integer read FNextInvoiceSequence;
    property Phone: string read FPhone;
    property PreferredLocales: TArray<string> read FPreferredLocales;
    property Shipping: string read FShipping;
    property TaxExempt: string read FTaxExempt;
    property TestClock: string read FTestClock;
  end;

implementation

{ TStripeCustomerEntity }

constructor TStripeCustomerEntity.Create(AJson: TJSONObject);
var
  LLocales: TJSONArray;
  I: Integer;
begin
  FId := AJson.GetValue<string>('id');
  FObject := AJson.GetValue<string>('object');
  FAddress := AJson.GetValue<string>('address');
  FBalance := AJson.GetValue<Integer>('balance');
  FCreated := AJson.GetValue<Int64>('created');
  FCurrency := AJson.GetValue<string>('currency');
  FDefaultSource := AJson.GetValue<string>('default_source');
  FDelinquent := AJson.GetValue<Boolean>('delinquent');
  FDescription := AJson.GetValue<string>('description');
  FDiscount := AJson.GetValue<string>('discount');
  FEmail := AJson.GetValue<string>('email');
  FInvoicePrefix := AJson.GetValue<string>('invoice_prefix');
  FLivemode := AJson.GetValue<Boolean>('livemode');
  FMetadata := AJson.GetValue<TJSONObject>('metadata');
  FName := AJson.GetValue<string>('name');
  FNextInvoiceSequence := AJson.GetValue<Integer>('next_invoice_sequence');
  FPhone := AJson.GetValue<string>('phone');
  FShipping := AJson.GetValue<string>('shipping');
  FTaxExempt := AJson.GetValue<string>('tax_exempt');
  FTestClock := AJson.GetValue<string>('test_clock');

  LLocales := AJson.GetValue<TJSONArray>('preferred_locales');
  if Assigned(LLocales) then
  begin
    SetLength(FPreferredLocales, LLocales.Count);
    for I := 0 to LLocales.Count - 1 do
      FPreferredLocales[I] := LLocales.Items[I].Value;
  end;
  FInvoiceSettings := TStripeCustomerInvoiceSettingsEntity.Create(AJson.GetValue<TJSONObject>('invoice_settings'));
end;

destructor TStripeCustomerEntity.Destroy;
begin
  FInvoiceSettings.Free;
  inherited;
end;

class function TStripeCustomerEntity.New(AJson: TJSONObject): TStripeCustomerEntity;
begin
  if not Assigned(AJson) then
    Exit(nil);

  Result := Self.Create(AJson);
end;

end.
