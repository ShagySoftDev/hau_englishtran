# Kare Kare — Hausa to English Translator

A PHP 8+/MySQL web app for a growing Hausa–English dictionary.

## Quick start

1. Create a MySQL database named `kare_kare` and import `database.sql`.
2. Update the credentials in `config.php` (or set `DB_HOST`, `DB_NAME`, `DB_USER`, and `DB_PASS`).
3. Optional, for `.xlsx` import/export: run `composer require phpoffice/phpspreadsheet` in this folder.
4. Run `php -S localhost:8000` and open `http://localhost:8000`.

The default administrator is `admin` / `admin`. Change it immediately after signing in.

## Spreadsheet columns

The importer accepts a header row with **Hausa Word**, **English Meaning**, and an optional **Example Sentence**. Header aliases (`hausa`, `english`, `meaning`, `example`) are accepted.

## Notes

This uses PDO prepared statements, password hashing, CSRF protection, server-side validation, activity logging, and role checks. Use HTTPS and configure a mail provider before enabling production password-reset delivery.
