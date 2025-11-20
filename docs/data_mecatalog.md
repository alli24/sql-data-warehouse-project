📘 Gold Layer – Data Dictionary

⭐ 1. Table: gold.dim_customers (Customer Dimension)

Contains detailed information about customers and is used to join with the sales fact table.

| Column Name         | Description                                    | What this column does                                    |
| ------------------- | ---------------------------------------------- | -------------------------------------------------------- |
| **customer_key**    | Surrogate key generated in the data warehouse. | Uniquely identifies each customer and is used for joins. |
| **customer_id**     | Customer ID from the source system.            | Links the customer back to the original data source.     |
| **customer_number** | Business/customer reference number.            | Used for reporting or business tracking.                 |
| **first_name**      | Customer’s first name.                         | Stores the customer’s given name.                        |
| **last_name**       | Customer’s last name.                          | Stores the customer’s family name.                       |
| **country**         | Customer’s country.                            | Used for geographic analysis.                            |
| **marital_status**  | Customer’s marital status.                     | Helps categorize customers (e.g., Single/Married).       |
| **gender**          | Customer’s gender.                             | Supports demographic segmentation.                       |
| **birthdate**       | Customer’s date of birth.                      | Allows age calculations or age group analysis.           |
| **create_date**     | Record creation date in the source.            | Shows when the customer entered the system.              |


⭐ 2. Table: gold.dim_products (Product Dimension)

Contains detailed product attributes used for product-based reporting and analysis.

| Column Name        | Description                               | What this column does                                          |
| ------------------ | ----------------------------------------- | -------------------------------------------------------------- |
| **product_key**    | Surrogate key generated in the warehouse. | Uniquely identifies each product for joining with fact tables. |
| **product_id**     | Product ID from source system.            | Links the product back to the source dataset.                  |
| **product_number** | Business product number or SKU.           | Used for product management and reporting.                     |
| **product_name**   | Name of the product.                      | Identifies the product in reports.                             |
| **category_id**    | Category ID.                              | Maps the product to a category group.                          |
| **category**       | Product category.                         | Groups products (e.g., Electronics, Apparel).                  |
| **subcategory**    | More specific category.                   | Allows deeper product segmentation.                            |
| **maintenance**    | Indicates if related to maintenance.      | Answers: Is this a maintenance product? (Yes/No).              |
| **cost**           | Product cost.                             | Useful for margin calculations.                                |
| **product_line**   | Product line group.                       | Groups related products under a broader line.                  |
| **start_date**     | Product start/effective date.             | When the product became active.                                |

⭐ 3. Table: gold.fact_sales (Sales Fact Table)

Stores actual sales transactions and links to product and customer dimensions.

| Column Name       | Description                     | What this column does                     |
| ----------------- | ------------------------------- | ----------------------------------------- |
| **order_number**  | Unique sales order identifier.  | Distinguishes each sale transaction.      |
| **product_key**   | Foreign key to `dim_products`.  | Connects sale to a specific product.      |
| **customer_key**  | Foreign key to `dim_customers`. | Connects sale to a specific customer.     |
| **order_date**    | Date the order was placed.      | Used for time-based analysis.             |
| **shipping_date** | Date the order was shipped.     | Tracks shipment performance.              |
| **due_date**      | Expected delivery date.         | Used for delivery SLA analysis.           |
| **sales_amount**  | Total amount of the sale.       | Used for revenue calculations.            |
| **quantity**      | Number of units sold.           | Helps analyze sales volume.               |
| **price**         | Price per unit at time of sale. | Used for margin and revenue calculations. |
