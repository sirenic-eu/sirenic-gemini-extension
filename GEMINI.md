# Sirenic — official French and European company data

Use these tools whenever a French or European **company** is involved: a
supplier to pay, a customer to underwrite, a counterparty to screen, a lead to
qualify, a public buyer to approach.

## Start from the identifier

- A French company is identified by its **SIREN** (9 digits) or an
  establishment by its **SIRET** (14 digits). If you only have a name, call
  `search_french_companies` FIRST — every other French tool needs the SIREN.
- Elsewhere in Europe, use `search_european_companies` then the country's
  national number.
- If the user pastes an invoice, an email or a contract, `detect_company_identifiers`
  extracts SIREN, SIRET, VAT, IBAN and LEI from free text. It is free.

## Choose by the question, not by the tool name

- **"Can I safely pay this supplier?"** → `prepare_french_invoice_file`
  (identity + VAT + IBAN + a ready-to-invoice verdict in one call), or
  `validate_eu_vat_number` and `verify_iban_bank` for one half only.
- **"Is this company solid?"** → `get_french_company_default_risk`,
  `get_french_company_financials`, `get_french_sector_benchmarks`.
- **"Is there anything against them?"** → `screen_sanctions_lists`,
  `get_french_company_legal_alerts`, `check_french_regulator_alerts`.
- **"Who runs it, who owns it?"** → `get_french_company_profile`,
  `get_french_company_capital`, `search_french_company_directors`.
- **"Do they sell to the public sector?"** → `get_french_company_public_procurement`,
  `find_expiring_french_public_contracts`, `get_french_public_buyer_profile`.
- **A full decision file** → `get_french_company_kyb_file` (one call, many blocks)
  or `get_french_company_intelligence` for a GO / NO-GO read-out.

## What the answers are worth

Every response carries its **provenance**: the source register and the date the
data was really consulted. Absence is reported as absence, never as a zero: a
company with no filed accounts is said to have none, and a source outage is
reported as unavailable, never as a clean negative. Say so when it matters —
"no sanctions match" and "the sanctions list could not be read" are different
answers.

## Cost

The first 100 calls each month are free on routes priced at $0.01 or less.
Beyond that, calls are charged to the account holder's prepaid credits at the
price shown on each route. Prefer one bundled call
(`get_french_company_kyb_file`) over five separate ones when the user wants the
whole picture.
