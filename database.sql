-- File: database.sql
-- Jalankan: sqlite3 silentleak.db < database.sql

CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    email TEXT UNIQUE,
    telegram_chat_id TEXT,
    avatar TEXT DEFAULT 'default.jpg',
    reputation INTEGER DEFAULT 0,
    join_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE NOT NULL,
    icon TEXT DEFAULT 'folder'
);

CREATE TABLE listings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    description TEXT,
    price REAL NOT NULL,
    file_url TEXT,
    file_size TEXT,
    category_id INTEGER,
    seller_id INTEGER,
    status TEXT DEFAULT 'pending', -- pending, active, sold
    upload_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id),
    FOREIGN KEY (seller_id) REFERENCES users(id)
);

CREATE TABLE transactions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    listing_id INTEGER,
    buyer_id INTEGER,
    amount REAL,
    status TEXT DEFAULT 'pending',
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (listing_id) REFERENCES listings(id),
    FOREIGN KEY (buyer_id) REFERENCES users(id)
);

-- Insert default categories
INSERT INTO categories (name, icon) VALUES 
    ('Database', 'database'),
    ('Leaked Data', 'leak'),
    ('Tools', 'tool'),
    ('Exploits', 'exploit'),
    ('Accounts', 'account'),
    ('Tutorials', 'book'),
    ('Software', 'software'),
    ('Other', 'other');