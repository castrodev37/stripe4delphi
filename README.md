# Stripe4Delphi

Biblioteca para integração com a API Stripe em Delphi.

## Instalação

Para instalar a biblioteca via [Boss](https://github.com/HashLoad/boss):

```bash
boss install castrodev37/stripe4delphi
```
### Configuração da Secret Key
O projeto disponibiliza a unit Stripe.Config.EnvironmentVariables para facilitar a importação da Stripe Secret Key a partir de um arquivo .env.
Essa abordagem mantém as credenciais fora do código-fonte, seguindo boas práticas de segurança.

`Como usar`
Utilize o método GetEnvVariable para carregar a chave diretamente do arquivo .env:

```bash
LSecretKey := GetEnvVariable(ExpandFileName(ExtractFilePath(ParamStr(0)) + '.env'), 'STRIPE_SECRET_KEY');
```
_Importante:_

* O arquivo .env deve estar localizado no mesmo diretório do executável (.exe).
* O caminho base pode ser ajustado no argumento do método ExtractFilePath, conforme a estrutura do seu projeto.

Exemplo de conteúdo do arquivo .env:

```bash
STRIPE_SECRET_KEY=sk_test_xxxxxxxxxxxxxxxxxxxxxxxxx
```
