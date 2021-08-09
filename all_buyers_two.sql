SELECT Customers.Name

FROM (
	SELECT TrueTable.customer_id, COUNT(*) AS o_all, SUM(TrueTable.isTrue) AS o_all_true

    FROM (

		SELECT Orders.customer_id, Orders.row_id,

		CASE 
			WHEN EXISTS(SELECT 0 FROM OrderItems WHERE OrderItems.order_id = Orders.row_id AND OrderItems.name = 'Кассовый аппарат') 
			THEN 1 
			ELSE 0
		END AS isTrue

		FROM Orders
		WHERE Orders.customer_id IS NOT NULL AND YEAR(Orders.registered_at) = 2020

	) as TrueTable
	
    GROUP BY TrueTable.customer_id
	
) as ResultTable

JOIN Customers ON Customers.row_id = ResultTable.customer_id

WHERE o_all = o_all_true