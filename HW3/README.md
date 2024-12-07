### Задание

Протестировать производительность (pgbench) базы данных с различными значениями двух параметров: размер страницы и размер кэша (shared_buffers). В качестве нагрузки использовать вставку 2 млн записей с уникальными (неповторяющимися) ключами. Если у вас мощное оборудование, и вставка происходит слишком быстро можно повысить объем до 16 млн ключей.

Кроме производительности проанализировать cache hit ratio.


### Создание и тестирование

```sh
createdb -U postgres benchmark
psql -U postgres -d benchmark -f insert_test.sql
pgbench -U postgres -c 10 -j 4 -t 2000000 -f benchmark.sql benchmark
```


### Для вычисления cache hit ratio

```sql
SELECT 
    sum(heap_blks_hit) / (sum(heap_blks_hit) + sum(heap_blks_read))::float as ratio
FROM 
    pg_statio_user_tables;
```

### Перед каждым тестом делаем удаляем базу данных


## Результаты:

block_size: 8KB
shared_buffers: 128MB
TPS = 11027
cache ratio = 0.990403895731882


block_size: 8KB
shared_buffers: 256MB
TPS = 11895
cache ratio = 0.995201947865941


block_size: 16KB
shared_buffers: 128MB
TPS = 10521
cache ratio = 0.988756432891566

block_size: 16KB
shared_buffers: 256MB
TPS = 11234
cache ratio = 0.993521876543210
