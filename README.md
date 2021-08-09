# sqlTask0808
> В тексте заданий используется диалект Microsoft SQL Server 2014, однако для решения можно
  пользоваться другими версиями Microsoft SQL Server, а также другими RDBMS (PostgreSQL либо SQLite).

#### [Создать таблицы](createTable.sql)
#### [Заполнить данными](insertData.sql)

## Оглавление
0. [Функция select_orders_by_item_name](#Задание-1)
1. [Функция calculate_total_price_for_orders_group](#Задание-2) - [решение](calculate_total_price_for_orders_group.sql)
1. [Все покупатели](#Задание-3)

## Задание 1
Написать функцию select_orders_by_item_name. 

Она получает один аргумент - наименование позиции (строка),
и должна найти все заказы, в которых имеется позиция с данным наименованием. 

Кроме того, она должна подсчитать количество позиций с указанным наименованием в каждом отдельном заказе. 

Результатом вызова функции должна быть таблица с тремя колонками:

- order_id (row_id заказа)
- customer (наименование заказчика)
- items_count (количество позиций с данным наименованием в этом заказе)

Примеры вызова функции:

```
select * from stack.select_orders_by_item_name(N'Факс')
-- 4     Иванов         1
-- 5     Иванов         1
-- 13    ИП Федоров     1

select * from stack.select_orders_by_item_name(N'Кассовый аппарат')
-- 5     Иванов         1
-- 6     Иванов         2
-- 7     Петров         1
-- 9     Петров         1

select * from stack.select_orders_by_item_name(N'Стулья')
-- 13    ИП Федоров     1
```

## Задание 2
Написать функцию calculate_total_price_for_orders_group. 

Она получает row_id группы (либо заказа), и возвращает суммарную стоимость всех позиций всех заказов в этой группе (заказе), причем 
суммирование должно выполняться по всему поддереву заказов, начинающемуся с данной группы.

Функция должна возвращать число.

Примеры вызова функции:

```
select stack.calculate_total_price_for_orders_group(1) as total_price   -- 703, все заказы
select stack.calculate_total_price_for_orders_group(2) as total_price   -- 513, группа 'Частные лица'
select stack.calculate_total_price_for_orders_group(3) as total_price   -- 510, группа 'Оргтехника'
select stack.calculate_total_price_for_orders_group(12) as total_price  -- 190, группа 'Юридические лица'
select stack.calculate_total_price_for_orders_group(13) as total_price  -- 190, заказ 'ИП Федоров'
```

## Задание 3
Написать запрос, возвращающий наименования всех покупателей, у которых каждый заказ в 2020 году содержит
как минимум одну позицию с наименованием "Кассовый аппарат".

Результатом выполнения запроса на тестовых данных будет таблица с одной строкой "Иванов".
