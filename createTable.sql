-- Заказчики
create table Customers
(
   row_id int identity not null,
   name nvarchar(max) not null,           -- наименование заказчика

   constraint PK_Customers
      primary key nonclustered(row_id)
);

go

-- Заказы
create table Orders
(
   row_id int identity not null,
   parent_id int,                         -- row_id родительской группы
   group_name nvarchar(max),              -- наименование группы заказов
   customer_id int,                       -- row_id заказчика
   registered_at date                     -- дата регистрации заказа

   constraint PK_Orders
      primary key nonclustered (row_id),
   constraint FK_Orders_Folder
      foreign key (parent_id)
      references Orders(row_id)
      on delete no action
      on update no action,
   constraint FK_Customers
      foreign key (customer_id)
      references Customers(row_id)
      on delete cascade
      on update cascade
);
go

-- Позиции заказов
create table OrderItems
(
   row_id int identity not null,
   order_id int not null,                 -- row_id заказа
   name nvarchar(max) not null,           -- наименование позиции
   price int not null,                    -- стоимость позиции в рублях

   constraint PK_OrderItems
      primary key nonclustered (row_id),
   constraint FK_OrderItems_Orders
      foreign key (order_id)
      references Orders(row_id)
      on delete cascade
      on update cascade
);
go
