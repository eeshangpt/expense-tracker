-- Create database and user (if not using environment variables)
-- CREATE DATABASE IF NOT EXISTS dashboard_db;
-- CREATE USER IF NOT EXISTS dashboard_user WITH PASSWORD 'dashboard_password';
-- GRANT ALL PRIVILEGES ON DATABASE dashboard_db TO dashboard_user;

-- Connect to the database
\c dashboard_db;

-- Users table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    currency VARCHAR(3) DEFAULT 'USD' NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Budgets table (monthly budgets per user)
CREATE TABLE budgets (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    month INTEGER NOT NULL CHECK (month >= 1 AND month <= 12),
    year INTEGER NOT NULL,
    total_budget DECIMAL(12,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, month, year)
);

-- Expense categories (global categories that users can use)
CREATE TABLE expense_categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    color VARCHAR(20) DEFAULT 'BLUE',
    icon VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Expenditures table (individual expenses)
CREATE TABLE expenditures (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    category_id INTEGER REFERENCES expense_categories(id),
    amount DECIMAL(12,2) NOT NULL,
    description TEXT,
    date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Summary metrics (calculated view per user)
CREATE TABLE summary_metrics (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    metric_name VARCHAR(50) NOT NULL,
    amount DECIMAL(12,2),
    percentage DECIMAL(5,2),
    month INTEGER,
    year INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, metric_name, month, year)
);

-- Chart data points (for trend charts per user)
CREATE TABLE chart_data (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    series_name VARCHAR(100) NOT NULL,
    month INTEGER NOT NULL,
    year INTEGER NOT NULL,
    value DECIMAL(10,2) NOT NULL,
    color VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, series_name, month, year)
);

-- User-specific category budgets (optional - for category-level budgeting)
CREATE TABLE user_category_budgets (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    category_id INTEGER REFERENCES expense_categories(id) ON DELETE CASCADE,
    budget_amount DECIMAL(10,2) NOT NULL,
    month INTEGER NOT NULL,
    year INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, category_id, month, year)
);

-- Indexes for better performance
CREATE INDEX idx_expenditures_user_date ON expenditures(user_id, date);
CREATE INDEX idx_expenditures_category ON expenditures(category_id);
CREATE INDEX idx_budgets_user_month_year ON budgets(user_id, month, year);
CREATE INDEX idx_chart_data_user_month_year ON chart_data(user_id, month, year);
CREATE INDEX idx_summary_metrics_user_month_year ON summary_metrics(user_id, month, year);

-- Insert default expense categories
INSERT INTO expense_categories (name, color, icon) VALUES
('Food & Dining', 'BLUE', 'restaurant'),
('Transportation', 'GREEN', 'directions_car'),
('Shopping', 'ORANGE', 'shopping_cart'),
('Entertainment', 'PURPLE', 'movie'),
('Bills & Utilities', 'RED', 'receipt'),
('Healthcare', 'CYAN', 'local_hospital'),
('Education', 'INDIGO', 'school'),
('Travel', 'TEAL', 'flight'),
('Other', 'GREY', 'category');

-- Insert sample user (for testing)
INSERT INTO users (username, email, password_hash, currency) VALUES
('demo_user', 'demo@example.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj6fMmiLpBqG', 'USD');

-- Insert sample budget for demo user
INSERT INTO budgets (user_id, month, year, total_budget) VALUES
(1, EXTRACT(MONTH FROM CURRENT_DATE), EXTRACT(YEAR FROM CURRENT_DATE), 5000.00);

-- Insert sample expenditures for demo user
INSERT INTO expenditures (user_id, category_id, amount, description, date) VALUES
(1, 1, 820.00, 'Monthly groceries and dining out', CURRENT_DATE),
(1, 2, 340.00, 'Gas and public transport', CURRENT_DATE),
(1, 3, 560.00, 'Clothing and household items', CURRENT_DATE),
(1, 4, 180.00, 'Movies and subscriptions', CURRENT_DATE),
(1, 5, 1060.00, 'Electricity, water, internet', CURRENT_DATE);

-- Insert sample summary metrics for demo user
INSERT INTO summary_metrics (user_id, metric_name, amount, percentage, month, year) VALUES
(1, 'balance', 5240.00, 12.5, EXTRACT(MONTH FROM CURRENT_DATE), EXTRACT(YEAR FROM CURRENT_DATE)),
(1, 'income', 8200.00, NULL, EXTRACT(MONTH FROM CURRENT_DATE), EXTRACT(YEAR FROM CURRENT_DATE)),
(1, 'expenses', 2960.00, NULL, EXTRACT(MONTH FROM CURRENT_DATE), EXTRACT(YEAR FROM CURRENT_DATE));

-- Insert sample chart data for demo user
INSERT INTO chart_data (user_id, series_name, month, year, value, color) VALUES
-- Green Line (Income)
(1, 'Income', 1, EXTRACT(YEAR FROM CURRENT_DATE), 1.0, 'LIGHT_GREEN'),
(1, 'Income', 2, EXTRACT(YEAR FROM CURRENT_DATE), 0.5, 'LIGHT_GREEN'),
(1, 'Income', 3, EXTRACT(YEAR FROM CURRENT_DATE), 1.4, 'LIGHT_GREEN'),
(1, 'Income', 4, EXTRACT(YEAR FROM CURRENT_DATE), 1.9, 'LIGHT_GREEN'),
(1, 'Income', 5, EXTRACT(YEAR FROM CURRENT_DATE), 5.0, 'LIGHT_GREEN'),
(1, 'Income', 6, EXTRACT(YEAR FROM CURRENT_DATE), 4.8, 'LIGHT_GREEN'),
-- Pink Line (Expenses)
(1, 'Expenses', 1, EXTRACT(YEAR FROM CURRENT_DATE), 1.0, 'PINK'),
(1, 'Expenses', 2, EXTRACT(YEAR FROM CURRENT_DATE), 1.5, 'PINK'),
(1, 'Expenses', 3, EXTRACT(YEAR FROM CURRENT_DATE), 1.4, 'PINK'),
(1, 'Expenses', 4, EXTRACT(YEAR FROM CURRENT_DATE), 1.9, 'PINK'),
(1, 'Expenses', 5, EXTRACT(YEAR FROM CURRENT_DATE), 2.0, 'PINK'),
(1, 'Expenses', 6, EXTRACT(YEAR FROM CURRENT_DATE), 1.8, 'PINK'),
-- Cyan Line (Savings)
(1, 'Savings', 1, EXTRACT(YEAR FROM CURRENT_DATE), 1.0, 'CYAN'),
(1, 'Savings', 2, EXTRACT(YEAR FROM CURRENT_DATE), 0.5, 'CYAN'),
(1, 'Savings', 3, EXTRACT(YEAR FROM CURRENT_DATE), 3.2, 'CYAN'),
(1, 'Savings', 4, EXTRACT(YEAR FROM CURRENT_DATE), 4.5, 'CYAN'),
(1, 'Savings', 5, EXTRACT(YEAR FROM CURRENT_DATE), 6.0, 'CYAN'),
(1, 'Savings', 6, EXTRACT(YEAR FROM CURRENT_DATE), 5.0, 'CYAN');