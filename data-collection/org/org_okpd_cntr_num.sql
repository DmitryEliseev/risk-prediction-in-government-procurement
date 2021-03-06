IF EXISTS(SELECT * FROM sysobjects WHERE type IN ('FN', 'TF') AND name='org_okpd_cntr_num')
BEGIN
  DROP FUNCTION guest.org_okpd_cntr_num
END
GO

CREATE FUNCTION guest.org_okpd_cntr_num (@OrgID INT,  @OkpdID INT)

/*
Количество контрактов для конкретного ОКПД и заказчика
*/

RETURNS INT
AS
BEGIN
  DECLARE @cur_okpd_contracts_num INT = (
    SELECT COUNT(*)
    FROM
    (
      SELECT DISTINCT cntr.ID
      FROM DV.f_OOS_Product AS prod
      INNER JOIN DV.d_OOS_Org AS org ON org.ID = prod.RefOrg
      INNER JOIN DV.d_OOS_Contracts AS cntr ON cntr.ID = prod.RefContract
      INNER JOIN DV.d_OOS_Products AS prods ON prods.ID = prod.RefProduct
      WHERE 
        org.ID = @OrgID AND 
        cntr.RefStage IN (3, 4) AND
        prods.RefOKPD2 = @OkpdID
    )t
  )
  RETURN @cur_okpd_contracts_num
END
GO