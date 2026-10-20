#cek tabel brands
SELECT *
FROM `project1-bike-store.bike_store_db.brands`;

#cek tabel categories
SELECT *
FROM `project1-bike-store.bike_store_db.categories`;

#cek jumlah kategori
SELECT COUNT(*) AS total_categories
FROM `project1-bike-store.bike_store_db.categories`;

#cek tabel customers
SELECT *
FROM `project1-bike-store.bike_store_db.customers`;

#Menampilkan data type
SELECT
    column_name,
    data_type,
    is_nullable
FROM `project1-bike-store.bike_store_db.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'customers'
ORDER BY ordinal_position;

# Ganti data type Zip Code
CREATE OR REPLACE TABLE
`project1-bike-store.bike_store_db.customers` AS

SELECT
    * EXCEPT(zip_code),
    CAST(zip_code AS STRING) AS zip_code
FROM
    `project1-bike-store.bike_store_db.customers`;

#Cek data type
SELECT
    column_name,
    data_type,
    is_nullable
FROM `project1-bike-store.bike_store_db.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'customers'
ORDER BY ordinal_position;

#Menampilkan 10 pelanggan pertama
SELECT *
FROM `project1-bike-store.bike_store_db.customers`
LIMIT 10;

#total pelanggan
SELECT
    COUNT(*) AS total_customers
FROM `project1-bike-store.bike_store_db.customers`;

#Jumlah pelanggan berdasarkan negara bagian
SELECT
    state,
    COUNT(*) AS total_customers
FROM `project1-bike-store.bike_store_db.customers`
GROUP BY state
ORDER BY total_customers DESC;

#Cek Order items
SELECT *
FROM `project1-bike-store.bike_store_db.order_items`;

#cek data type
SELECT
    column_name,
    data_type,
    is_nullable
FROM `project1-bike-store.bike_store_db.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'order_items'
ORDER BY ordinal_position;

#Cek jumlah data
SELECT
    COUNT(*) AS total_rows
FROM `project1-bike-store.bike_store_db.order_items`;

#Hitung total sales
SELECT
    order_id,
    product_id,
    quantity,
    list_price,
    discount,
    ROUND(
        quantity * list_price * (1 - discount),
        2
    ) AS total_sales
FROM `project1-bike-store.bike_store_db.order_items`;

#Order status
SELECT
    CASE
        WHEN order_status = 1 THEN 'Pending'
        WHEN order_status = 2 THEN 'Processing'
        WHEN order_status = 3 THEN 'Rejected'
        WHEN order_status = 4 THEN 'Completed'
        ELSE 'Unknown'
    END AS order_status_name,
    COUNT(*) AS total_orders
FROM `project1-bike-store.bike_store_db.orders`
GROUP BY order_status_name
ORDER BY total_orders DESC;

#Cek data orders
SELECT *
FROM `project1-bike-store.bike_store_db.orders`;

#Cek jumlah data dan pesanan unik
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS total_orders
FROM `project1-bike-store.bike_store_db.orders`;

#cek tabel products
SELECT *
FROM `project1-bike-store.bike_store_db.products`;

#cek data type products
SELECT
    column_name,
    data_type,
    is_nullable
FROM `project1-bike-store.bike_store_db.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'products'
ORDER BY ordinal_position;

#cek jumlah produk
SELECT
    COUNT(*) AS total_products
FROM `project1-bike-store.bike_store_db.products`;

#cek jumlah produk berdasarkan kategori
SELECT
    category_id,
    COUNT(*) AS total_products
FROM `project1-bike-store.bike_store_db.products`
GROUP BY category_id
ORDER BY total_products DESC;

#cek harga produk tertinggi dan terendah
SELECT
    MIN(list_price) AS min_price,
    MAX(list_price) AS max_price,
    ROUND(AVG(list_price), 2) AS avg_price
FROM `project1-bike-store.bike_store_db.products`;

# Top 5 Products by Revenue
SELECT
    product_name,
    ROUND(SUM(total_sales), 2) AS total_revenue,
    SUM(quantity) AS total_quantity_sold,
    COUNT(DISTINCT order_id) AS total_orders

FROM `project1-bike-store.bike_store_db.sales_dashboard`

GROUP BY
    product_name

ORDER BY
    total_revenue DESC

LIMIT 5;

#cek tabel staffs
SELECT *
FROM `project1-bike-store.bike_store_db.staffs`;

#cek data type staffs
SELECT
    column_name,
    data_type,
    is_nullable
FROM `project1-bike-store.bike_store_db.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'staffs'
ORDER BY ordinal_position;

#cek jumlah staff
SELECT
    COUNT(*) AS total_staff
FROM `project1-bike-store.bike_store_db.staffs`;

#cek jumlah staff berdasarkan toko
SELECT
    store_id,
    COUNT(*) AS total_staff
FROM `project1-bike-store.bike_store_db.staffs`
GROUP BY store_id
ORDER BY total_staff DESC;

#cek staff aktif dan tidak aktif
SELECT
    active,
    COUNT(*) AS total_staff
FROM `project1-bike-store.bike_store_db.staffs`
GROUP BY active
ORDER BY active DESC;

#cek tabel stocks
SELECT *
FROM `project1-bike-store.bike_store_db.stocks`;

#cek data type stocks
SELECT
    column_name,
    data_type,
    is_nullable
FROM `project1-bike-store.bike_store_db.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'stocks'
ORDER BY ordinal_position;

#cek jumlah data stocks
SELECT
    COUNT(*) AS total_rows
FROM `project1-bike-store.bike_store_db.stocks`;

#cek total stok produk
SELECT
    SUM(quantity) AS total_stock
FROM `project1-bike-store.bike_store_db.stocks`;

#cek stok berdasarkan toko
SELECT
    store_id,
    SUM(quantity) AS total_stock
FROM `project1-bike-store.bike_store_db.stocks`
GROUP BY store_id
ORDER BY total_stock DESC;

#cek produk dengan stok kosong
SELECT *
FROM `project1-bike-store.bike_store_db.stocks`
WHERE quantity = 0;

#cek tabel stores
SELECT *
FROM `project1-bike-store.bike_store_db.stores`;

#cek data type stores
SELECT
    column_name,
    data_type,
    is_nullable
FROM `project1-bike-store.bike_store_db.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'stores'
ORDER BY ordinal_position;

#cek jumlah toko
SELECT
    COUNT(*) AS total_stores
FROM `project1-bike-store.bike_store_db.stores`;

#cek lokasi toko
SELECT
    store_name,
    city,
    state
FROM `project1-bike-store.bike_store_db.stores`;

# Store Performance Analysis
SELECT
    store_name,
    ROUND(SUM(total_sales), 2) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_quantity_sold

FROM `project1-bike-store.bike_store_db.sales_dashboard`

GROUP BY
    store_name

ORDER BY
    total_revenue DESC;

#cek jumlah data semua tabel
SELECT
    table_id AS table_name,
    row_count AS total_rows
FROM `project1-bike-store.bike_store_db.__TABLES__`
ORDER BY table_name;

# Menampilkan seluruh tabel dalam database Bike Store
SELECT
    table_name
FROM `project1-bike-store.bike_store_db.INFORMATION_SCHEMA.TABLES`
WHERE table_type = 'BASE TABLE'
ORDER BY table_name;


#cek data type seluruh tabel
SELECT
    table_name,
    column_name,
    data_type
FROM `project1-bike-store.bike_store_db.INFORMATION_SCHEMA.COLUMNS`
ORDER BY table_name, ordinal_position;

#Cek primary
#cek primary key brands
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT brand_id) AS unique_brand_id
FROM `project1-bike-store.bike_store_db.brands`;

#cek primary key categories
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT category_id) AS unique_category_id
FROM `project1-bike-store.bike_store_db.categories`;

#cek primary key customers
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT customer_id) AS unique_customer_id
FROM `project1-bike-store.bike_store_db.customers`;

#cek primary key orders
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS unique_order_id
FROM `project1-bike-store.bike_store_db.orders`;

#cek primary key products
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT product_id) AS unique_product_id
FROM `project1-bike-store.bike_store_db.products`;

#cek primary key staffs
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT staff_id) AS unique_staff_id
FROM `project1-bike-store.bike_store_db.staffs`;

#cek primary key stores
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT store_id) AS unique_store_id
FROM `project1-bike-store.bike_store_db.stores`;

#CEk composite primary key

#cek primary key order_items
SELECT
    order_id,
    item_id,
    COUNT(*) AS total
FROM `project1-bike-store.bike_store_db.order_items`
GROUP BY order_id, item_id
HAVING COUNT(*) > 1;

#cek primary key stocks
SELECT
    store_id,
    product_id,
    COUNT(*) AS total
FROM `project1-bike-store.bike_store_db.stocks`
GROUP BY store_id, product_id
HAVING COUNT(*) > 1;

#cek hubungan orders dan customers
SELECT
    o.order_id,
    o.customer_id,
    c.first_name,
    c.last_name,
    o.order_date
FROM `project1-bike-store.bike_store_db.orders` o
LEFT JOIN `project1-bike-store.bike_store_db.customers` c
    ON o.customer_id = c.customer_id;

#cek customer_id yang tidak ditemukan
SELECT
    o.customer_id,
    COUNT(*) AS total_orders
FROM `project1-bike-store.bike_store_db.orders` o
LEFT JOIN `project1-bike-store.bike_store_db.customers` c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL
GROUP BY o.customer_id;

#cek jumlah data dan primary key orders
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS unique_order_id,
    COUNTIF(order_id IS NULL) AS null_order_id
FROM `project1-bike-store.bike_store_db.orders`;

#Missing value

#cek missing values brands
SELECT
    COUNTIF(brand_id IS NULL) AS null_brand_id,
    COUNTIF(brand_name IS NULL) AS null_brand_name
FROM `project1-bike-store.bike_store_db.brands`;

#cek missing values categories
SELECT
    COUNTIF(category_id IS NULL) AS null_category_id,
    COUNTIF(category_name IS NULL) AS null_category_name
FROM `project1-bike-store.bike_store_db.categories`;

#cek missing values customers
SELECT
    COUNTIF(customer_id IS NULL) AS null_customer_id,
    COUNTIF(first_name IS NULL) AS null_first_name,
    COUNTIF(last_name IS NULL) AS null_last_name,
    COUNTIF(phone IS NULL) AS null_phone,
    COUNTIF(email IS NULL) AS null_email,
    COUNTIF(street IS NULL) AS null_street,
    COUNTIF(city IS NULL) AS null_city,
    COUNTIF(state IS NULL) AS null_state,
    COUNTIF(zip_code IS NULL) AS null_zip_code
FROM `project1-bike-store.bike_store_db.customers`;

#cek missing values orders
SELECT
    COUNTIF(order_id IS NULL) AS null_order_id,
    COUNTIF(customer_id IS NULL) AS null_customer_id,
    COUNTIF(order_status IS NULL) AS null_order_status,
    COUNTIF(order_date IS NULL) AS null_order_date,
    COUNTIF(required_date IS NULL) AS null_required_date,
    COUNTIF(shipped_date IS NULL) AS null_shipped_date,
    COUNTIF(store_id IS NULL) AS null_store_id,
    COUNTIF(staff_id IS NULL) AS null_staff_id
FROM `project1-bike-store.bike_store_db.orders`;

#cek missing values order_items
SELECT
    COUNTIF(order_id IS NULL) AS null_order_id,
    COUNTIF(item_id IS NULL) AS null_item_id,
    COUNTIF(product_id IS NULL) AS null_product_id,
    COUNTIF(quantity IS NULL) AS null_quantity,
    COUNTIF(list_price IS NULL) AS null_list_price,
    COUNTIF(discount IS NULL) AS null_discount
FROM `project1-bike-store.bike_store_db.order_items`;

#cek missing values products
SELECT
    COUNTIF(product_id IS NULL) AS null_product_id,
    COUNTIF(product_name IS NULL) AS null_product_name,
    COUNTIF(brand_id IS NULL) AS null_brand_id,
    COUNTIF(category_id IS NULL) AS null_category_id,
    COUNTIF(model_year IS NULL) AS null_model_year,
    COUNTIF(list_price IS NULL) AS null_list_price
FROM `project1-bike-store.bike_store_db.products`;

#cek missing values staffs
SELECT
    COUNTIF(staff_id IS NULL) AS null_staff_id,
    COUNTIF(first_name IS NULL) AS null_first_name,
    COUNTIF(last_name IS NULL) AS null_last_name,
    COUNTIF(email IS NULL) AS null_email,
    COUNTIF(phone IS NULL) AS null_phone,
    COUNTIF(active IS NULL) AS null_active,
    COUNTIF(store_id IS NULL) AS null_store_id,
    COUNTIF(manager_id IS NULL) AS null_manager_id
FROM `project1-bike-store.bike_store_db.staffs`;

#cek missing values stocks
SELECT
    COUNTIF(store_id IS NULL) AS null_store_id,
    COUNTIF(product_id IS NULL) AS null_product_id,
    COUNTIF(quantity IS NULL) AS null_quantity
FROM `project1-bike-store.bike_store_db.stocks`;

#cek missing values stores
SELECT
    COUNTIF(store_id IS NULL) AS null_store_id,
    COUNTIF(store_name IS NULL) AS null_store_name,
    COUNTIF(phone IS NULL) AS null_phone,
    COUNTIF(email IS NULL) AS null_email,
    COUNTIF(street IS NULL) AS null_street,
    COUNTIF(city IS NULL) AS null_city,
    COUNTIF(state IS NULL) AS null_state,
    COUNTIF(zip_code IS NULL) AS null_zip_code
FROM `project1-bike-store.bike_store_db.stores`;

#cek phone kosong
SELECT
    COUNTIF(phone IS NULL) AS null_phone,
    COUNTIF(TRIM(phone) = '') AS empty_phone
FROM `project1-bike-store.bike_store_db.customers`;

#cek duplicate brands
SELECT
    brand_id,
    COUNT(*) AS total
FROM `project1-bike-store.bike_store_db.brands`
GROUP BY brand_id
HAVING COUNT(*) > 1;

#cek duplicate categories
SELECT
    category_id,
    COUNT(*) AS total
FROM `project1-bike-store.bike_store_db.categories`
GROUP BY category_id
HAVING COUNT(*) > 1;

#cek duplicate customers
SELECT
    customer_id,
    COUNT(*) AS total
FROM `project1-bike-store.bike_store_db.customers`
GROUP BY customer_id
HAVING COUNT(*) > 1;

#cek duplicate orders
SELECT
    order_id,
    COUNT(*) AS total
FROM `project1-bike-store.bike_store_db.orders`
GROUP BY order_id
HAVING COUNT(*) > 1;

#cek duplicate order_items
SELECT
    order_id,
    item_id,
    COUNT(*) AS total
FROM `project1-bike-store.bike_store_db.order_items`
GROUP BY order_id, item_id
HAVING COUNT(*) > 1;

#cek duplicate products
SELECT
    product_id,
    COUNT(*) AS total
FROM `project1-bike-store.bike_store_db.products`
GROUP BY product_id
HAVING COUNT(*) > 1;

#cek duplicate staffs
SELECT
    staff_id,
    COUNT(*) AS total
FROM `project1-bike-store.bike_store_db.staffs`
GROUP BY staff_id
HAVING COUNT(*) > 1;

#cek duplicate stocks
SELECT
    store_id,
    product_id,
    COUNT(*) AS total
FROM `project1-bike-store.bike_store_db.stocks`
GROUP BY store_id, product_id
HAVING COUNT(*) > 1;

#cek duplicate stores
SELECT
    store_id,
    COUNT(*) AS total
FROM `project1-bike-store.bike_store_db.stores`
GROUP BY store_id
HAVING COUNT(*) > 1;

#Invalid values check

#cek harga produk tidak valid
SELECT *
FROM `project1-bike-store.bike_store_db.products`
WHERE list_price <= 0;

#cek harga order_items tidak valid
SELECT *
FROM `project1-bike-store.bike_store_db.order_items`
WHERE list_price <= 0;

#cek quantity penjualan tidak valid
SELECT *
FROM `project1-bike-store.bike_store_db.order_items`
WHERE quantity <= 0;

#cek quantity stok negatif
SELECT *
FROM `project1-bike-store.bike_store_db.stocks`
WHERE quantity < 0;

#cek discount tidak valid
SELECT *
FROM `project1-bike-store.bike_store_db.order_items`
WHERE discount < 0 OR discount > 1;

# Discount Analysis
SELECT
    CASE
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount <= 0.10 THEN '1-10%'
        WHEN discount <= 0.20 THEN '11-20%'
        ELSE 'Above 20%'
    END AS discount_group,

    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(total_sales), 2) AS total_revenue

FROM `project1-bike-store.bike_store_db.sales_dashboard`

GROUP BY
    discount_group

ORDER BY
    total_revenue DESC;

#cek order status tidak valid
SELECT *
FROM `project1-bike-store.bike_store_db.orders`
WHERE order_status NOT IN (1, 2, 3, 4);

#cek tanggal pengiriman sebelum tanggal order
SELECT *
FROM `project1-bike-store.bike_store_db.orders`
WHERE SAFE_CAST(shipped_date AS DATE) < order_date;

#cek required_date sebelum order_date
SELECT *
FROM `project1-bike-store.bike_store_db.orders`
WHERE required_date < order_date;

#cek model year tidak valid
SELECT *
FROM `project1-bike-store.bike_store_db.products`
WHERE model_year < 1900
   OR model_year > EXTRACT(YEAR FROM CURRENT_DATE());

#cek status staff tidak valid
SELECT *
FROM `project1-bike-store.bike_store_db.staffs`
WHERE active NOT IN (0, 1);

#Data Consistency Check
#cek product_id order_items yang tidak ditemukan
SELECT
    oi.product_id
FROM `project1-bike-store.bike_store_db.order_items` oi
LEFT JOIN `project1-bike-store.bike_store_db.products` p
    ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

#cek order_id yang tidak ditemukan
SELECT
    oi.order_id
FROM `project1-bike-store.bike_store_db.order_items` oi
LEFT JOIN `project1-bike-store.bike_store_db.orders` o
    ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

#cek brand_id yang tidak ditemukan
SELECT
    p.brand_id
FROM `project1-bike-store.bike_store_db.products` p
LEFT JOIN `project1-bike-store.bike_store_db.brands` b
    ON p.brand_id = b.brand_id
WHERE b.brand_id IS NULL;

#cek category_id yang tidak ditemukan
SELECT
    p.category_id
FROM `project1-bike-store.bike_store_db.products` p
LEFT JOIN `project1-bike-store.bike_store_db.categories` c
    ON p.category_id = c.category_id
WHERE c.category_id IS NULL;

# Category Sales Analysis
SELECT
    category_name,
    ROUND(SUM(total_sales), 2) AS total_revenue,
    SUM(quantity) AS total_quantity_sold,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(
        100 * SUM(total_sales)
        / SUM(SUM(total_sales)) OVER (), 2
    ) AS revenue_percentage

FROM `project1-bike-store.bike_store_db.sales_dashboard`

GROUP BY
    category_name

ORDER BY
    total_revenue DESC;

#cek store_id pada orders yang tidak ditemukan
SELECT
    o.store_id
FROM `project1-bike-store.bike_store_db.orders` o
LEFT JOIN `project1-bike-store.bike_store_db.stores` s
    ON o.store_id = s.store_id
WHERE s.store_id IS NULL;

#cek staff_id pada orders yang tidak ditemukan
SELECT
    o.staff_id
FROM `project1-bike-store.bike_store_db.orders` o
LEFT JOIN `project1-bike-store.bike_store_db.staffs` s
    ON o.staff_id = s.staff_id
WHERE s.staff_id IS NULL;

#cek store_id pada stocks yang tidak ditemukan
SELECT
    st.store_id
FROM `project1-bike-store.bike_store_db.stocks` st
LEFT JOIN `project1-bike-store.bike_store_db.stores` s
    ON st.store_id = s.store_id
WHERE s.store_id IS NULL;

#cek product_id pada stocks yang tidak ditemukan
SELECT
    st.product_id
FROM `project1-bike-store.bike_store_db.stocks` st
LEFT JOIN `project1-bike-store.bike_store_db.products` p
    ON st.product_id = p.product_id
WHERE p.product_id IS NULL;

#Data Cleaning

#cek data type orders
SELECT
    column_name,
    data_type
FROM `project1-bike-store.bike_store_db.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'orders'
ORDER BY ordinal_position;

#cek shipped_date yang tidak valid
SELECT
    shipped_date
FROM `project1-bike-store.bike_store_db.orders`
WHERE shipped_date IS NOT NULL
AND SAFE_CAST(shipped_date AS DATE) IS NULL;

#buat tabel orders_clean
CREATE OR REPLACE TABLE
`project1-bike-store.bike_store_db.orders_clean` AS
SELECT
    * EXCEPT(shipped_date),
    SAFE_CAST(shipped_date AS DATE) AS shipped_date
FROM `project1-bike-store.bike_store_db.orders`;

#cleaning shipped_date dan required_date
CREATE OR REPLACE TABLE
`project1-bike-store.bike_store_db.orders_clean` AS
SELECT
    * EXCEPT(shipped_date, required_date),
    SAFE_CAST(required_date AS DATE) AS required_date,
    SAFE_CAST(shipped_date AS DATE) AS shipped_date
FROM `project1-bike-store.bike_store_db.orders`;

#cek data orders_clean
SELECT *
FROM `project1-bike-store.bike_store_db.orders_clean`
LIMIT 10;

#cek data type setelah cleaning
SELECT
    column_name,
    data_type
FROM `project1-bike-store.bike_store_db.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'orders_clean'
ORDER BY ordinal_position;

#cek jumlah data sebelum dan sesudah cleaning
SELECT
    'before_cleaning' AS status,
    COUNT(*) AS total_rows
FROM `project1-bike-store.bike_store_db.orders`

UNION ALL

SELECT
    'after_cleaning',
    COUNT(*)
FROM `project1-bike-store.bike_store_db.orders_clean`;

#cek tanggal pengiriman sebelum order
SELECT *
FROM `project1-bike-store.bike_store_db.orders_clean`
WHERE shipped_date < order_date;

#cek required_date sebelum order_date
SELECT *
FROM `project1-bike-store.bike_store_db.orders_clean`
WHERE required_date < order_date;

#Exploratory Data Analysis (EDA)

#hitung total revenue
SELECT
    ROUND(
        SUM(oi.quantity * oi.list_price * (1 - oi.discount)),
        2
    ) AS total_revenue
FROM `project1-bike-store.bike_store_db.order_items` oi
JOIN `project1-bike-store.bike_store_db.orders_clean` o
    ON oi.order_id = o.order_id
WHERE o.order_status = 4;

#hitung total orders
SELECT
    COUNT(DISTINCT order_id) AS total_orders
FROM `project1-bike-store.bike_store_db.orders_clean`
WHERE order_status = 4;

#hitung total quantity sold
SELECT
    SUM(oi.quantity) AS total_quantity_sold
FROM `project1-bike-store.bike_store_db.order_items` oi
JOIN `project1-bike-store.bike_store_db.orders_clean` o
    ON oi.order_id = o.order_id
WHERE o.order_status = 4;

#hitung average order value
SELECT
    ROUND(
        SAFE_DIVIDE(
            SUM(oi.quantity * oi.list_price * (1 - oi.discount)),
            COUNT(DISTINCT oi.order_id)
        ),
        2
    ) AS avg_order_value
FROM `project1-bike-store.bike_store_db.order_items` oi
JOIN `project1-bike-store.bike_store_db.orders_clean` o
    ON oi.order_id = o.order_id
WHERE o.order_status = 4;

#cek monthly sales trend
SELECT
    FORMAT_DATE('%Y-%m', o.order_date) AS order_month,
    ROUND(
        SUM(oi.quantity * oi.list_price * (1 - oi.discount)),
        2
    ) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM `project1-bike-store.bike_store_db.orders_clean` o
JOIN `project1-bike-store.bike_store_db.order_items` oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 4
GROUP BY order_month
ORDER BY order_month;

# Monthly Sales Trend Analysis
SELECT
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    FORMAT_DATE('%Y-%m', order_date) AS sales_month,
    ROUND(SUM(total_sales), 2) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders

FROM `project1-bike-store.bike_store_db.sales_dashboard`

GROUP BY
    year,
    month,
    sales_month

ORDER BY
    year,
    month;

#buat tabel untuk dashboard sales
CREATE OR REPLACE TABLE
`project1-bike-store.bike_store_db.sales_dashboard` AS

SELECT
    o.order_id,
    o.order_date,
    o.order_status,
    o.customer_id,
    o.store_id,
    s.store_name,
    oi.product_id,
    oi.quantity,
    oi.list_price,
    oi.discount,
    ROUND(
        oi.quantity * oi.list_price * (1 - oi.discount),
        2
    ) AS total_sales

FROM `project1-bike-store.bike_store_db.orders_clean` o

JOIN `project1-bike-store.bike_store_db.order_items` oi
    ON o.order_id = oi.order_id

LEFT JOIN `project1-bike-store.bike_store_db.stores` s
    ON o.store_id = s.store_id

WHERE o.order_status = 4;

#tambahkan product_name ke sales_dashboard
CREATE OR REPLACE TABLE
`project1-bike-store.bike_store_db.sales_dashboard` AS
SELECT
    s.*,
    p.product_name,
    p.category_id,
    p.brand_id
FROM `project1-bike-store.bike_store_db.sales_dashboard` s
LEFT JOIN `project1-bike-store.bike_store_db.products` p
    ON s.product_id = p.product_id;


#cek nama produk
SELECT
    product_id,
    product_name,
    total_sales
FROM `project1-bike-store.bike_store_db.sales_dashboard`
LIMIT 10;

#tambahkan category_name ke sales_dashboard
CREATE OR REPLACE TABLE
`project1-bike-store.bike_store_db.sales_dashboard` AS
SELECT
    s.*,
    c.category_name
FROM `project1-bike-store.bike_store_db.sales_dashboard` s
LEFT JOIN `project1-bike-store.bike_store_db.categories` c
    ON s.category_id = c.category_id;

#tambahkan brand_name ke sales_dashboard
CREATE OR REPLACE TABLE
`project1-bike-store.bike_store_db.sales_dashboard` AS
SELECT
    s.*,
    b.brand_name
FROM `project1-bike-store.bike_store_db.sales_dashboard` s
LEFT JOIN `project1-bike-store.bike_store_db.brands` b
    ON s.brand_id = b.brand_id;


