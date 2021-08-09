CREATE FUNCTION calculate_total_price_for_orders_group(@id INT)
	RETURNS INT
	BEGIN
		DECLARE @result INT, @r_id INT

		IF ((SELECT customer_id FROM Orders WHERE row_id = @id) IS NULL)

			-- если на входе группа

			BEGIN

				DECLARE some_cursor CURSOR FOR SELECT row_id FROM Orders WHERE parent_id = @id

				OPEN some_cursor

					DECLARE  @counter INT, @temp_id INT
					SET @counter = 0

					fetch next from some_cursor INTO @temp_id

					while @@FETCH_STATUS = 0
						BEGIN

							SELECT @counter += dbo.calculate_total_price_for_orders_group(@temp_id)

							FETCH NEXT FROM some_cursor INTO @temp_id

						END;

					SET @result = @counter

				CLOSE some_cursor
				DEALLOCATE some_cursor

			END;
		ELSE
			-- если на входе заказ

			BEGIN
				SELECT @result = SUM(price) FROM OrderItems WHERE OrderItems.order_id = @id
			END;

		RETURN @result
	END