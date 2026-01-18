-- This SQL for PostGRESQL:

CREATE TABLE customers (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  full_name TEXT,
  phone TEXT,
  created_at TIMESTAMP DEFAULT now()
);


CREATE TABLE products (
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  price NUMERIC(10,2) NOT NULL,
  stock INT NOT NULL DEFAULT 0,
  created_at TIMESTAMP DEFAULT now()
);


CREATE TABLE orders (
  id BIGSERIAL PRIMARY KEY,
  customer_id UUID REFERENCES customers(id),
  total_price NUMERIC(10,2) NOT NULL,
  status TEXT DEFAULT 'pending', -- pending, paid, cancelled
  created_at TIMESTAMP DEFAULT now()
);


CREATE TABLE order_items (
  id BIGSERIAL PRIMARY KEY,
  order_id BIGINT REFERENCES orders(id) ON DELETE CASCADE,
  product_id BIGINT REFERENCES products(id),
  quantity INT NOT NULL,
  unit_price NUMERIC(10,2) NOT NULL
);


CREATE TABLE coupons (
  id BIGSERIAL PRIMARY KEY,
  code TEXT UNIQUE NOT NULL,
  type TEXT NOT NULL, -- 'BUY_X_GET_Y'
  buy_qty INT,
  free_qty INT,
  is_active BOOLEAN DEFAULT true,
  start_date DATE,
  end_date DATE
);


CREATE TABLE coupon_usages (
  id BIGSERIAL PRIMARY KEY,
  coupon_id BIGINT REFERENCES coupons(id),
  order_id BIGINT REFERENCES orders(id),
  customer_id UUID REFERENCES customers(id),
  used_at TIMESTAMP DEFAULT now()
);
