IF EXISTS(SELECT * FROM sysobjects WHERE type IN ('FN', 'TF') AND name='org_num_of_contracts_lvl')
BEGIN
  DROP FUNCTION guest.org_num_of_contracts_lvl
END
GO

CREATE FUNCTION guest.org_num_of_contracts_lvl (@OrgID INT, @Lvl INT)

/*
Количество завершенных контрактов по определенному уровню (федеральному, муниципальному, региональному)
для конкретного заказчика
*/

RETURNS INT
AS
BEGIN
  DECLARE @num_of_contracts_lvl INT = (
    SELECT COUNT(cntr.ID)
    FROM DV.f_OOS_Value AS val
    INNER JOIN DV.d_OOS_Org AS org ON org.ID = val.RefOrg
    INNER JOIN DV.d_OOS_Contracts AS cntr ON cntr.ID = val.RefContract
    WHERE 
  		org.ID = @OrgID AND 
  		cntr.RefStage IN (3, 4) AND 
      val.RefLevelOrder = @Lvl 
  )
  RETURN @num_of_contracts_lvl
END
GO