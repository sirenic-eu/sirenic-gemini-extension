# Sirenic — extension Gemini CLI

Official **French and European company data** for AI agents, in 77 tools:
verify a supplier before paying it, KYB files, financial statements, default
risk, sanctions screening, public procurement, e-invoicing checks.

## Install

```bash
gemini extensions install https://github.com/sirenic-eu/sirenic-gemini-extension
```

Gemini CLI detects that the server requires authentication, discovers the OAuth
endpoints and registers itself. You sign in with a Sirenic account and
authorise — nothing to copy, no client ID, no secret.

## What it costs

A verified account gets **100 free calls per month** on routes priced at $0.01
or less. Beyond that, each call is charged to your prepaid credits at the price
shown on the route — the same price as a direct API call. Pricing:
<https://api.sirenic.eu/en/offres>

## Three prompts to get started

- *"I am about to pay a 12,000 EUR invoice to Danone. Check the company, its VAT
  number and its IBAN, and tell me whether I can pay."*
- *"Give me the default risk and the latest filed accounts for SIREN 552032534,
  and compare it with its sector average."*
- *"Is this company under sanctions, and does it have any BODACC gazette
  announcements in the last six months?"*

## Links

- Service and full route grid: <https://api.sirenic.eu/en>
- How to connect any assistant: <https://api.sirenic.eu/en/connectors>
- Privacy policy: <https://api.sirenic.eu/en/privacy>

Data from INSEE Sirene and INPI RNE under the Etalab 2.0 open licence.
