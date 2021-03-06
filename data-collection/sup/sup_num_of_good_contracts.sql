IF EXISTS(SELECT * FROM sysobjects WHERE type IN ('FN', 'TF') AND name='sup_num_of_good_contracts')
BEGIN
  DROP FUNCTION guest.sup_num_of_good_contracts
END
GO

CREATE FUNCTION guest.sup_num_of_good_contracts (@SupID INT)

/*
Количество хороших завершенных контрактов для конкретного поставщика
*/

RETURNS INT
AS
BEGIN
  DECLARE @num_of_good_contracts INT = (
    SELECT COUNT(cntr.ID)
  	FROM DV.f_OOS_Value AS val
    INNER JOIN DV.d_OOS_Suppliers AS sup ON sup.ID = val.RefSupplier
  	INNER JOIN DV.d_OOS_Contracts AS cntr ON cntr.ID = val.RefContract
		WHERE
			sup.ID = @SupID AND 
    	cntr.RefStage IN (3, 4) AND
			guest.pred_variable(cntr.ID) = 1
  )
  RETURN @num_of_good_contracts
END
GO