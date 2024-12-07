-- Создаем базу данных
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50),
    email VARCHAR(100),
    age INT,
    created_at TIMESTAMP
);




-- Заполняем данные
INSERT INTO users (username, email, age, created_at)
SELECT 
    'user_' || i,
    'user_' || i || '@gmail.com',
    (random() * 50 + 18)::int,
    timestamp '2020-01-01' + (random() * (interval '3 years'))
FROM generate_series(1, 1000000) i;




-- Создание индексов

-- B-tree индекс по одной колонке
CREATE INDEX btree_username_idx ON users USING btree (username);

-- Hash индекс по одной колонке
CREATE INDEX hash_email_idx ON users USING hash (email);

-- B-tree индекс по двум колонкам
CREATE INDEX btree_composite_idx ON users USING btree (age, created_at);

-- Bloom filter индекc по двум колонкам
CREATE EXTENSION bloom;
CREATE INDEX bloom_multi_idx ON users USING bloom (username, email);

-- GiST индекс по выражению
CREATE EXTENSION btree_gist;
CREATE INDEX gist_age_expr_idx ON users USING gist (EXTRACT(year FROM created_at));



-- Вывод результатов

SELECT 
pg_size_pretty(pg_relation_size('btree_username_idx')) as btree_size,
pg_size_pretty(pg_relation_size('hash_email_idx')) as hash_size,
pg_size_pretty(pg_relation_size('btree_composite_idx')) as composite_size,
pg_size_pretty(pg_relation_size('bloom_multi_idx')) as bloom_size,
pg_size_pretty(pg_relation_size('gist_age_idx')) as gist_size;
