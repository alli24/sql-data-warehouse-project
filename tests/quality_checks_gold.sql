/*
===============================================================================
SQL Script: Data Quality Tests for Gold Layer
===============================================================================
Script Purpose:
    Validates the integrity of the Gold Layer by checking:
      • Duplicate surrogate keys in dimension tables
      • Orphan fact records (foreign key issues)
    Ensures the Star Schema model is clean, consistent, and ready for analytics.
===============================================================================
*/



/* =============================================================================
   Test 1: Check for Duplicate Customers in gold.dim_customers
   Purpose:
       Ensures that customer_key is unique and correctly generated.
       A well-formed dimension table should contain no duplicate surrogate keys.
   ============================================================================= */

-- ====================================================================
-- Checking: gold.dim_customers
-- ====================================================================

SELECT 
      customer_key,
      COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;
GO



/* =============================================================================
   Test 2: Check for Duplicate Products in gold.dim_products
   Purpose:
       Ensures that product_key is unique and that the product dimension 
       maintains proper star-schema integrity.
   ============================================================================= */

-- ====================================================================
-- Checking: gold.dim_products
-- ====================================================================

SELECT 
      product_key,
      COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;
GO



/* =============================================================================
   Test 3: Detect Orphan Fact Records in gold.fact_sales
   Purpose:
       Identifies fact rows that reference missing dimension records.
       These represent foreign key integrity violations in the fact table.
   ============================================================================= */

-- ====================================================================
-- Checking: gold.fact_sales
-- ====================================================================

SELECT 
      f.*,
      c.customer_key,
      p.product_key
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products  p ON p.product_key  = f.product_key
WHERE c.customer_key IS NULL
   OR p.product_key IS NULL;
GO

