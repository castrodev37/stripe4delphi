unit Stripe.Service.HttpClient.Interfaces;

interface

uses
  System.Classes;

type
  IStripeHttpClient = interface
  ['{A813BE18-DEE4-41B6-B130-E467DBC59AE4}']
    function Post(AUrl: string; ABody: TStrings; AContentType: string = 'application/x-www-form-urlencoded'): IStripeHttpClient;
    function Get(AUrl: string; AContentType: string = 'application/x-www-form-urlencoded'): IStripeHttpClient;
    function Content: string;
  end;

implementation

end.

