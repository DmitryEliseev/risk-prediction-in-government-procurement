  --Индекс по рекомендации от SQL Server
IF NOT EXISTS(SELECT * FROM sys.indexes WHERE name='idx_Nonclustered_f_OOS_Value_Price_RefLevelOrder' AND object_id = OBJECT_ID('DV.f_OOS_Value'))
BEGIN
  CREATE NONCLUSTERED INDEX idx_Nonclustered_f_OOS_Value_Price_RefLevelOrder
  ON DV.f_OOS_Value (Price, RefLevelOrder)
  INCLUDE (ID, PMP, RefOrg, RefSupplier, RefContract)
END
GO

--Индекс на org_stats.org_cntr_num для ускорения WHERE при сборе выборки
IF NOT EXISTS(SELECT * FROM sys.indexes WHERE name='idx_org_with_exp' AND object_id = OBJECT_ID('guest.org_stats'))
BEGIN
	CREATE NONCLUSTERED INDEX idx_org_with_exp ON guest.org_stats (org_cntr_num) WHERE org_cntr_num > 0
END
GO

--Индекс на sup_stats.sup_cntr_num для ускорения WHERE при сборе выборки
IF NOT EXISTS(SELECT * FROM sys.indexes WHERE name='idx_sup_with_exp' AND object_id = OBJECT_ID('guest.sup_stats'))
BEGIN
	CREATE NONCLUSTERED INDEX idx_sup_with_exp ON guest.sup_stats (sup_cntr_num) WHERE sup_cntr_num > 0
END
GO