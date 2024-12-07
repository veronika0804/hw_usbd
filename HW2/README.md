# 1 Часть

## Результаты
btree_size = 30 MB

hash_size = 32 MB

btree_composite_size = 30 MB

bloom_size = 15 MB

gist_size = 60 MB

# 2 Часть

1) $m = 2^{32}$ возможных значений хэша
2) $n = 2,000,000$ записей


$P_{noCollision} = \frac{m!}{(m-n)!} \cdot \frac{1}{m^n}$
 
$P_{noCollision} = m \cdot (m - 1) \cdot ... \cdot (m-n + 1) \cdot \frac{1}{m^n} =1 \cdot (1 - \frac{1}{m}) \cdot (1 - \frac{2}{m}) \cdot . \cdot (1 - \frac{n-1}{m})$
 
$\ln⁡(P_{noCollision})=\ln⁡(1)+\ln⁡(1−\frac{1}{m})+\ln⁡(1−\frac{2}{m})+ ... +\ln⁡(1−\frac{n-1}{m})$ $\ln⁡(P_{noCollision})=\sum_{k=1}^{n - 1}{\ln⁡(1−\frac{k}{m})}$

Поскольку m очень велико, используем приближение для малых x:
$\ln⁡(1−x)≈−x$

Тогда:

$\ln⁡(P_{noCollision})≈−\sum_{k=1}^{n - 1}{\frac{k}{m}}$

Сумма арифметической прогрессии от 1 до (n-1):
$\sum_{k=1}^{n−1}k = {\frac{(n−1)\cdot n}{2}}$

Подставляем:
$\ln⁡(P_{noCollision})≈\frac{−n\cdot (n−1)}{2m}$

Применяем экспоненту к обеим частям:
$P_{noCollision}≈\exp{\frac{−n\cdot (n−1)}{2m}}$
 
Для больших m и n используем приближение:
$P_{collision} \approx 1 - e^{-\frac{n(n-1)}{2m}}$
 
Подставляем значения:
$P_{collision} \approx 1 - e^{-\frac{2,000,000 \cdot 1,999,999}{2 \cdot 2^{32}}}$ $\approx 1 - e^{-0.465}$ $\approx 0.465$
 
Таким образом, вероятность возникновения хотя бы одной коллизии при вставке 2 млн записей составляет около 46.5%.
