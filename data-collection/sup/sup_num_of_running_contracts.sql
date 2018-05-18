CREATE FUNCTION guest.sup_num_of_running_contracts (@SupID INT)

/*
Количество контрактов у поставщика, исполняемых на данный момент
*/

RETURNS FLOAT
AS
BEGIN
  DECLARE @num_of_all_finished_contracts FLOAT = (
  	SELECT COUNT(cntr.ID)
  	FROM DV.f_OOS_Value AS val
  	INNER JOIN DV.d_OOS_Suppliers AS sup ON sup.ID = val.RefSupplier
  	INNER JOIN DV.d_OOS_Contracts AS cntr ON cntr.ID = val.RefContract
  	WHERE 
  		sup.ID = @SupID AND 
  		cntr.RefStage = 2
  )
  RETURN @num_of_all_finished_contracts
END