# Customer Orders Data Cleaning – SQL

A data cleaning project in **SQLite** that turns a messy `customer_orders` table into a consistent dataset ready for analysis.

## Objective

Standardise text values, fix data types, tidy up customer names and remove duplicate orders, while keeping the original table unchanged. All cleaning is done with `SELECT` queries and CTEs.

## Tools

- **SQL (SQLite)**
- Functions used: `CASE`, `LIKE`, `LOWER`/`UPPER`, `SUBSTR`, `INSTR`, `REPLACE`, `CAST`, `COALESCE`, `TRIM`, `typeof`, `ROW_NUMBER()` and CTEs

## Cleaning Steps

| Column | Problem | Fix |
|---|---|---|
| `order_status` | Inconsistent spelling and case | Mapped to Delivered, Returned, Shipped, Pending, Refunded or Other using `CASE` + `LIKE` |
| `product_name` | Variations of the same product | Standardised to Apple Watch, Samsung Galaxy S22, Google Pixel, iPhone 14, MacBook Pro or Other |
| `quantity` | Stored as text, including the word "two" | Converted to an integer, with the check done using `typeof()` |
| `customer_name` | Mixed capitalisation | Split into first and last name, capitalised each part, then joined them back together |
| `price` | Contains `$` and `,` | Removed those symbols with `REPLACE` and cast to `REAL` |
| `country` | Several versions of the same country (USA, US, UK...) | Mapped to full country names |
| Duplicates | The same customer ordering the same product more than once | Flagged with `ROW_NUMBER()` over email + product, keeping only the first order |

## Final Output

The last query combines every cleaning step in a single CTE (`clean_data`) and returns one row per unique order with these columns:

`order_id`, `cleaned_customer_name`, `email`, `order_date`, `cleaned_product_name`, `cleaned_quantity`, `cleaned_price`, `cleaned_country`, `cleaned_order_status`, `notes`

## How to Run

1. Load the `customer_orders` table into SQLite, for example with DB Browser for SQLite.
2. Run the script section by section to see each cleaning step, or run only the final query to get the clean dataset.
