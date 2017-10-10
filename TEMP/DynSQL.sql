select 'as ps where ps.SOI_ID' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'Name_First' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'CDA' and umd.FieldName = 'First_Name')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.id = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Caregiver' and atp.PdfFileName = 'BIPIPSAC.pdf'
	
	union select 'as ps where ps.SOI_ID' as Constr,  'dbo' as sch, 'SOI' as tabl, 'Name_Last' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'CDA' and umd.FieldName = 'Name_Last')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.id = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Caregiver' and atp.PdfFileName = 'BIPIPSAC.pdf'

	union select ' as p join [SOI] ps on ps.Pref_Address = p.[SOI_Add_ID]  where ps.SOI_ID' as Constr,  'dbo' as sch, 'SOI_Addresses' as tabl, 'Address1' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'CDA' and umd.FieldName = 'Address1')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.id = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Caregiver' and atp.PdfFileName = 'BIPIPSAC.pdf'
	
	union select ' as p join [SOI] ps on ps.Pref_Address = p.[SOI_Add_ID]  where ps.SOI_ID' as Constr,  'dbo' as sch, 'SOI_Addresses' as tabl, 'City' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'CDA' and umd.FieldName = 'City')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.id = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Caregiver' and atp.PdfFileName = 'BIPIPSAC.pdf'

	union select ' as p join [SOI] ps on ps.Pref_Address = p.[SOI_Add_ID]  where ps.SOI_ID' as Constr,  'dbo' as sch, 'SOI_Addresses' as tabl, 'State' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'CDA' and umd.FieldName = 'State')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.id = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Caregiver' and atp.PdfFileName = 'BIPIPSAC.pdf'
	
	union select ' as p join [SOI] ps on ps.Pref_Address = p.[SOI_Add_ID]  where ps.SOI_ID' as Constr,  'dbo' as sch, 'SOI_Addresses' as tabl, 'Zip' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'CDA' and umd.FieldName = 'Zip')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.id = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Caregiver' and atp.PdfFileName = 'BIPIPSAC.pdf'

	select * from dbo.AlphaTrust_Merge