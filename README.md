# Stripe4Delphi

Biblioteca para integração com a API Stripe em Delphi.

## Instalação

Para instalar a biblioteca via [Boss](https://github.com/HashLoad/boss):

```bash
boss install castrodev37/stripe4delphi
```
## Authentication
Stripe autentica as requisições da API usando a chave secreta da conta. Ela deve ser fornecida para inicializar a interface `IStripe`.

### Configuração da Secret Key
O projeto disponibiliza a unit Stripe.Config.EnvironmentVariables para facilitar a importação da Stripe Secret Key a partir de um arquivo .env.

`Como usar`
Utilize o método GetEnvVariable para carregar a chave diretamente do arquivo .env:

```bash
LSecretKey := GetEnvVariable(ExpandFileName(ExtractFilePath(ParamStr(0)) + '.env'), 'STRIPE_SECRET_KEY');
LStripe := TStripe.New(LSecretKey);
```
_Importante:_

* O arquivo .env deve estar localizado no mesmo diretório do executável (.exe).
* O caminho base pode ser ajustado no argumento do método ExtractFilePath, conforme a estrutura do seu projeto.

Exemplo de conteúdo do arquivo .env:

```bash
STRIPE_SECRET_KEY=sk_test_xxxxxxxxxxxxxxxxxxxxxxxxx
```
## Criando um Cliente
Para adicionar um novo cliente, utilize a interface ICustomer.

```bash
var
  LCustomer: ICustomer;
begin
  LCustomer := TStripe.New(LSecretKey)
      .Customer
        .Name('foo')
        .Email('foo@example.com')
        .CreateCustomer;

  Writeln(LCustomer.This.Id);
end;
```
## Criando uma Sessão de Checkout
Use a interface ICheckout para definir os parâmetros da sessão.

```bash
var
  LCheckout: ICheckout;
begin
  LCheckout := LStripe
    .Checkout
      .SessionCreateParams
        .SuccessUrl('https://example.com/success')
        .CancelUrl('https://example.com/cancel')
        .Mode('payment')
        .AddSessionLineItem
          .Price('price_1R2uGWBL9pXT2oEjGk5BLSTA')
          .Quantity(1)
        .&End
      .&End
      .CreateSession;

  Writeln(LCheckout.This.Id);
  Writeln(LCheckout.This.Url);
end;
```

