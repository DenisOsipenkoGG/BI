use BIDEV_Offshore;
go
-------------------------------------------------------------------------------------M_lookups-and LookupValues----------------------------------------------------------------------------------------
merge into bur.Lookups as trg
using
(																												 
				select 'AT Contract Type'         as Name
	union select 'Contract Field Source Type' as Name
	union select 'Contract Data Type'	as Name
	union select 'Contract Status Type' as Name
	union select 'FATCA Codes' as Name
	union select 'Exempt Payee Codes' as Name
	union select  'Tax Classification Type' as Name
	union select	'Pdf Filed Type' as Name
	union select 'Path to contract' as Name

	
) as src
on trg.Name=src.Name
when not matched by target then insert (Name) values(src.Name);
go


-------------------------------------------------------------------------------------TempAlphaTrust_Contracts(NewContracts)----------------------------------------------------------------------------------------

merge dbo.AlphaTrust_Contracts trg
using
(
			select max(atc.Contract_Type)+1 as ConractType, 'BIPI Patient Spokesperson Agreement Patient' as ContractName, '2017-01-01' as DateFrom, '2099-07-07' as DateTo, 'All' as Brand from dbo.AlphaTrust_Contracts atc

		
) as src
on trg.Contract_Description = src.ContractName 
		when not matched by target then insert(Contract_Type, Contract_Description, Start_Date, End_Date, Brand)
			values(src.ConractType, src.ContractName, src.DateFrom, src.DateTo, src.Brand)
		;
go

merge dbo.AlphaTrust_Contracts trg
using
(
select max(atc.Contract_Type)+1 as ConractType, 'BNA' as ContractName, '2017-01-01' as DateFrom, '2099-07-07' as DateTo, 'All' as Brand from dbo.AlphaTrust_Contracts atc
) as src
on trg.Contract_Description = src.ContractName 
		when not matched by target then insert(Contract_Type, Contract_Description, Start_Date, End_Date, Brand)
			values(src.ConractType, src.ContractName, src.DateFrom, src.DateTo, src.Brand)
		;
go
merge dbo.AlphaTrust_Contracts trg
using
(
select max(atc.Contract_Type)+1 as ConractType, 'CDA' as ContractName, '2017-01-01' as DateFrom, '2099-07-07' as DateTo, 'All' as Brand from dbo.AlphaTrust_Contracts atc
) as src
 on	trg.Contract_Description = src.ContractName 
		when not matched by target then insert(Contract_Type, Contract_Description, Start_Date, End_Date, Brand)
			values(src.ConractType, src.ContractName, src.DateFrom, src.DateTo, src.Brand)
		;
go
merge dbo.AlphaTrust_Contracts trg
using
(
select max(atc.Contract_Type)+1 as ConractType, 'EFT' as ContractName, '2017-01-01' as DateFrom, '2099-07-07' as DateTo, 'All' as Brand from dbo.AlphaTrust_Contracts atc
) as src
on	trg.Contract_Description = src.ContractName 
		when not matched by target then insert(Contract_Type, Contract_Description, Start_Date, End_Date, Brand)
			values(src.ConractType, src.ContractName, src.DateFrom, src.DateTo, src.Brand)
		;
go
merge dbo.AlphaTrust_Contracts trg
using
(
select max(atc.Contract_Type)+1 as ConractType, 'W9' as ContractName, '2017-01-01' as DateFrom, '2099-07-07' as DateTo, 'All' as Brand from dbo.AlphaTrust_Contracts atc

		
) as src
on trg.Contract_Description = src.ContractName 
		when not matched by target then insert(Contract_Type, Contract_Description, Start_Date, End_Date, Brand)
			values(src.ConractType, src.ContractName, src.DateFrom, src.DateTo, src.Brand)
		;
go

merge dbo.AlphaTrust_Contracts trg
using
(
select max(atc.Contract_Type)+1 as ConractType, 'BIPI Patient Spokesperson Agreement Caregiver' as ContractName, '2017-01-01' as DateFrom, '2099-07-07' as DateTo, 'All' as Brand from dbo.AlphaTrust_Contracts atc
) as src
	on trg.Contract_Description = src.ContractName 
		when not matched by target then insert(Contract_Type, Contract_Description, Start_Date, End_Date, Brand)
			values(src.ConractType, src.ContractName, src.DateFrom, src.DateTo, src.Brand)
		;
go
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------




merge into bur.LookupValues as trg
using
(
				select l.ID as LookupID, 'W9' as Value from bur.Lookups as l where l.Name = 'AT Contract Type'
  union select l.ID as LookupID, 'EFT' as Value from bur.Lookups as l where l.Name = 'AT Contract Type'
  union select l.ID as LookupID, 'BNA' as Value from bur.Lookups as l where l.Name = 'AT Contract Type'
  union select l.ID as LookupID, 'BIPI Patient Spokesperson Agreement Patient' as Value from bur.Lookups as l where l.Name = 'AT Contract Type'
	union select l.ID as LookupID, 'BIPI Patient Spokesperson Agreement Caregiver' as Value from bur.Lookups as l where l.Name = 'AT Contract Type'	
	union select l.ID as LookupID, 'CDA' as Value from bur.Lookups as l where l.Name = 'AT Contract Type'
-------------------------------------------------------------------------------------ContractDataType----------------------------------------------------------------------------------------
	union select l.ID as LookupID, 'Database' as Value from bur.Lookups as l where l.Name = 'Contract Data Type'
	union select l.ID as LookupID, 'UI' as Value from bur.Lookups as l where l.Name = 'Contract Data Type'
	union select l.ID as LookupID, 'Database & UI' as Value from bur.Lookups as l where l.Name = 'Contract Data Type'
-------------------------------------------------------------------------------------Contract Field Source Type--------------------------------------------------------------------------------
	union select l.ID as LookupID, 'Text Box' as Value from bur.Lookups as l where l.Name = 'Contract Field Source Type'
-------------------------------------------------------------------------------------ContractStatus----------------------------------------------------------------------------------------
	
		union select l.ID as LookupID, 'Closed' as Value from bur.Lookups as l where l.Name = 'Contract Status Type'		
		union select l.ID as LookupID, 'Cancelled' as Value from bur.Lookups as l where l.Name = 'Contract Status Type'						
		union select l.ID as LookupID, 'Expired' as Value from bur.Lookups as l where l.Name = 'Contract Status Type'						
		union select l.ID as LookupID, 'Voided' as Value from bur.Lookups as l where l.Name = 'Contract Status Type'
		union select l.ID as LookupID, 'Pending' as Value from bur.Lookups as l where l.Name = 'Contract Status Type'
		union select l.ID as LookupID, 'Completed' as Value from bur.Lookups as l where l.Name = 'Contract Status Type'	
-------------------------------------------------------------------------------------PdfFieldType----------------------------------------------------------------------------------------
		union select l.ID as LookupID, 'Text' as Value from bur.Lookups as l where l.Name = 'Pdf Filed Type'		
		union select l.ID as LookupID, 'Date' as Value from bur.Lookups as l where l.Name = 'Pdf Filed Type'						
		union select l.ID as LookupID, 'Signer' as Value from bur.Lookups as l where l.Name = 'Pdf Filed Type'		
		union select l.ID as LookupID, 'CoSigner' as Value from bur.Lookups as l where l.Name = 'Pdf Filed Type'
		union select l.ID as LookupID, 'DateCoSingner' as Value from bur.Lookups as l where l.Name = 'Pdf Filed Type'		

) as src
on trg.LookupID = src.LookupID and src.Value = trg.Value
	when not matched by target then insert  (LookupID, Value) 
		values (src.LookupID, src.Value);
go	




merge into bur.LookupValues as trg
using
(
				
-------------------------------------------------------------------------------------Path to contract----------------------------------------------------------------------------------------
		select l.ID as LookupID, 'http://hs.hub4test.ru/BI-EContract/' as Description, 'Path' as Value from bur.Lookups as l where l.Name = 'Path to contract'
union select l.ID as LookupID, 'www.bispeakerconnection.com/iFLMx-BI' as Description, 'BIWebsite' as Value from bur.Lookups as l where l.Name = 'Path to contract'
) as src
on trg.LookupID = src.LookupID and src.Value = trg.Value 
	when not matched by target then insert  (LookupID, Value, Description ) 
		values (src.LookupID, src.Value, src.Description);
go	




merge into bur.LookupValues as trg
using
(
		
		 select l.ID as LookupID, 'C' as Value, 'C' as Description from bur.Lookups as l where l.Name = 'Tax Classification Type'	
		union select l.ID as LookupID, 'S' as Value, 'S' as Description from bur.Lookups as l where l.Name = 'Tax Classification Type'
		union select l.ID as LookupID, 'P' as Value, 'P' as Description from bur.Lookups as l where l.Name = 'Tax Classification Type'

) as src
on trg.LookupID = src.LookupID and src.Value = trg.Value
	when not matched by target then insert  (LookupID, Value, Description) 
		values (src.LookupID, src.Value, src.Description);
go

-------------------------------------------------------------------------------------InsertContract-AlphaTrustContract----------------------------------------------------------------------------------------

merge bur.AlphaTrustContract trg
using
(
				select 'W9'		as Name, 2018 as Year, '20170101' DateFrom, '20990707' DateTo, 1 as isRequired, lv.ID as ContractTypeID from bur.LookupValues lv join bur.Lookups l on l.ID = lv.LookupID where l.Name = 'AT Contract Type' and lv.Value ='W9' 
	union select 'EFT'	as Name, 2018 as Year, '20170101' DateFrom, '20990707' DateTo, 1 as isRequired, lv.ID as ContractTypeID from bur.LookupValues lv join bur.Lookups l on l.ID = lv.LookupID where l.Name = 'AT Contract Type' and lv.Value ='EFT' 
	union select 'BNA'	as Name, 2018 as Year, '20170101' DateFrom, '20990707' DateTo, 1 as isRequired, lv.ID as ContractTypeID from bur.LookupValues lv join bur.Lookups l on l.ID = lv.LookupID where l.Name = 'AT Contract Type' and lv.Value ='BNA' 
	union select 'BIPI Patient Spokesperson Agreement Caregiver'	as Name, 2018 as Year, '20170101' DateFrom, '20990707' DateTo, 1 as isRequired, lv.ID as ContractTypeID from bur.LookupValues lv join bur.Lookups l on l.ID = lv.LookupID where l.Name = 'AT Contract Type' and lv.Value ='BIPI Patient Spokesperson Agreement Caregiver' 
	union select 'BIPI Patient Spokesperson Agreement Patient'	as Name, 2018 as Year, '20170101' DateFrom, '20990707' DateTo, 1 as isRequired, lv.ID as ContractTypeID from bur.LookupValues lv join bur.Lookups l on l.ID = lv.LookupID where l.Name = 'AT Contract Type' and lv.Value ='BIPI Patient Spokesperson Agreement Patient' 
	union select 'CDA'	as Name, 2018 as Year, '20170101' DateFrom, '20990707' DateTo, 1 as isRequired, lv.ID as ContractTypeID from bur.LookupValues lv join bur.Lookups l on l.ID = lv.LookupID where l.Name = 'AT Contract Type' and lv.Value ='CDA' 
		
) as src
	on trg.AlphaTrustContractName = src.Name and src.Year = trg.Year
		when not matched by target then insert(AlphaTrustContractName, Year, DateFrom, DateTo, isRequired, ContractTypeID)
			values(src.Name, src.Year, src.DateFrom, src.DateTo, src.isRequired, src.ContractTypeID);
go
-------------------------------------------------------------------------------------Insert-AlphaTrustPDF----------------------------------------------------------------------------------------
merge bur.AlphaTrustPdf trg
using
(
	select 'W9.pdf' PdfFileName, l.ID as DataTypeID from bur.Lookups as l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Data Type'	and lv.Value = 'UI'
	union select 'EFT.pdf' PdfFileName, l.ID as DataTypeID from bur.Lookups as l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Data Type'	and lv.Value = 'Database' 
	union select 'BIPIPSAC.pdf' PdfFileName, l.ID as DataTypeID from bur.Lookups as l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Data Type'	and lv.Value = 'Database'
	union select 'BIPIPSA.pdf' PdfFileName, l.ID as DataTypeID from bur.Lookups as l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Data Type'	and lv.Value = 'UI'
	union select 'BNAIndividualCSA.pdf' PdfFileName, l.ID as DataTypeID from bur.Lookups as l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Data Type'	and lv.Value = 'Database'
	union select 'BNAInstitutionCSA.pdf' PdfFileName, l.ID as DataTypeID from bur.Lookups as l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Data Type'	and lv.Value = 'Database'
	union select 'CDA.pdf' PdfFileName, l.ID as DataTypeID from bur.Lookups as l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Data Type'	and lv.Value = 'Database & UI'
		
) as src
	on 	src.PdfFileName = trg.PdfFileName	and src.DataTypeID = trg.DataTypeID
		when not matched by target then insert(PdfFileName, DataTypeID)
			values(src.PdfFileName, src.DataTypeID);
go

-------------------------------------------------------------------------------------InsertContractDetail----------------------------------------------------------------------------------------
merge bur.ContractDetail trg
using
(
		select (select atc.ID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName = 'W9') as ContractID, atp.ID as AlphaTrustPdfID	 from bur.AlphaTrustPdf atp where atp.PdfFileName = 'W9.pdf'
		union	select (select atc.ID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName = 'EFT') as ContractID, atp.ID as AlphaTrustPdfID	 from bur.AlphaTrustPdf atp where atp.PdfFileName = 'EFT.pdf'
		union	select (select atc.ID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName = 'BNA') as ContractID, atp.ID as AlphaTrustPdfID	 from bur.AlphaTrustPdf atp where atp.PdfFileName = 'BNAIndividualCSA.pdf'
		union	select (select atc.ID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName = 'BNA') as ContractID, atp.ID as AlphaTrustPdfID	 from bur.AlphaTrustPdf atp where atp.PdfFileName = 'BNAInstitutionCSA.pdf'
		union	select (select atc.ID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Caregiver') as ContractID, atp.ID as AlphaTrustPdfID	 from bur.AlphaTrustPdf atp where atp.PdfFileName = 'BIPIPSAC.pdf'
		union	select (select atc.ID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Patient') as ContractID, atp.ID as AlphaTrustPdfID	 from bur.AlphaTrustPdf atp where atp.PdfFileName = 'BIPIPSA.pdf'
		union	select (select atc.ID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName = 'CDA') as ContractID, atp.ID as AlphaTrustPdfID	 from bur.AlphaTrustPdf atp where atp.PdfFileName = 'CDA.pdf'
		
) as src
	on 	src.ContractID = trg.ContractID and trg.AlphaTrustPdfID = src.AlphaTrustPdfID
		when not matched by target then insert(ContractID, AlphaTrustPdfID)
			values(src.ContractID, src.AlphaTrustPdfID);
go
-------------------------------------------------------------------------------------InsertPdfMergeDictionary----------------------------------------------------------------------------------------
merge into bur.PdfMergeDictionary as trg
using
(
	select				'FullName' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'BusinessName' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'BusinessType' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'BusinessTypeLimited' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'BusinessTypeOther' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'ExemptCode' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'FATCACode' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'Address' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'City' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'State' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'Zip' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'RequestersNameAddress' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'AccountList' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'TIN1' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'TIN2' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'SSN1' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'SSN2' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'SSN3' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'pronto_signer1' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'pronto_signer1_date' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
-------------------------------------------------------------------------------------EFT_Contract----------------------------------------------------------------------------------------
	union select	'FullName' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'EFT.pdf'
	union select  'PayIDMask' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'EFT.pdf'
	union select  'BankName' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'EFT.pdf'
	union select  'BankAddress1' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'EFT.pdf'
	union select  'BankAddress2' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'EFT.pdf'
	union select  'BankCity' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'EFT.pdf'
	union select  'BankState' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'EFT.pdf'
	union select  'BankZip' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'EFT.pdf'
	union select  'BankContact' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'EFT.pdf'
	union select  'BankPhone' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'EFT.pdf'
	union select  'RoutingNumber' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'EFT.pdf'
	union select  'AccountNumber' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'EFT.pdf'
	union select  'AccountName' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'EFT.pdf'
	union select  'pronto_signer1' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'EFT.pdf'
	union select  'pronto_signer1_date' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'EFT.pdf'
) as src
on trg.PdfFieldName = src.PdfFieldName and trg.PdfID = src.TemplateFieldID
	when not matched by target then insert(PdfFieldName,Formula, PdfID)
		values(src.PdfFieldName,src.Formula,src.TemplateFieldID);
go

-------------------------------------------------------------------------------------Insert-bur.UiMergeDictionary----------------------------------------------------------------------------------------
merge bur.UiMergeDictionary trg
using
(
		select				'FullName' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='W9'
		union select  'BusinessName' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='W9'
		union select  'BusinessType' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='W9' 
		union select  'BusinessTypeLimited' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='W9'
		union select  'BusinessTypeOther' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='W9'	
		union select  'ExemptCode' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='W9' 	
		union select  'FATCACode' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='W9'	
		union select  'Address' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='W9'
		union select  'City' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='W9'
		union select  'State' as FieldName,(select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='W9' 
		union select  'Zip' as FieldName,(select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='W9' 
		union select  'RequestersNameAddress' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='W9'	
		union select  'AccountList' as FieldName,(select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='W9' 
		union select  'TIN1' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='W9'
		union select  'TIN2' as FieldName,(select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='W9' 
		union select  'SSN1' as FieldName,(select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='W9' 
		union select  'SSN2' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='W9'
		union select  'SSN3' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='W9'
-------------------------------------------------------------------------------------EFT-Contract----------------------------------------------------------------------------------------
		union select	'AccountName' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='EFT'
		union select  'AccountNumber' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='EFT'
		union select  'BankAddress1' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='EFT' 
		union select  'BankAddress2' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='EFT'
		union select  'BankCity' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='EFT'	
		union select  'BankContact' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='EFT' 	
		union select  'BankName' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='EFT'	
		union select  'BankPhone' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='EFT'
		union select  'BankState' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='EFT'
		union select  'BankZip' as FieldName,(select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='EFT' 
		union select  'FullName' as FieldName,(select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='EFT' 
		union select  'PayIDMask' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='EFT'	
		union select  'RoutingNumber' as FieldName,(select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='EFT' 
			
) as src
	on trg.ContractID=src.ContractID and trg.FieldName = src.FieldName
		when not matched by target  then insert(ContractID,FieldName,FieldType)
			values(src.ContractID, src.FieldName, src.FieldType);
go

-------------------------------------------------------------------------------------InsertContractFieldDetail----------------------------------------------------------------------------------------
merge bur.ContractFieldDetail trg
using
(
-------------------------------------------------------------------------------------W9----------------------------------------------------------------------------------------
	select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'pronto_signer1' and atp.PdfFileName = 'W9.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'FullName'   and atc.AlphaTrustContractName ='W9'
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'FullName' and atp.PdfFileName = 'W9.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'FullName'   and atc.AlphaTrustContractName ='W9'
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'BusinessName' and atp.PdfFileName = 'W9.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'BusinessName'   and atc.AlphaTrustContractName ='W9'
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'AccountList' and atp.PdfFileName = 'W9.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'AccountList'   and atc.AlphaTrustContractName ='W9'
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Address' and atp.PdfFileName = 'W9.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'Address'   and atc.AlphaTrustContractName ='W9'
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'BusinessType' and atp.PdfFileName = 'W9.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'BusinessType'   and atc.AlphaTrustContractName ='W9' 
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'BusinessTypeLimited' and atp.PdfFileName = 'W9.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'BusinessTypeLimited'   and atc.AlphaTrustContractName ='W9'
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'BusinessTypeOther' and atp.PdfFileName = 'W9.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'BusinessTypeOther'   and atc.AlphaTrustContractName ='W9'
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'City' and atp.PdfFileName = 'W9.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'City'   and atc.AlphaTrustContractName ='W9' 
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'ExemptCode' and atp.PdfFileName = 'W9.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'ExemptCode'   and atc.AlphaTrustContractName ='W9'
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'FATCACode' and atp.PdfFileName = 'W9.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'FATCACode'   and atc.AlphaTrustContractName ='W9'
union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'RequestersNameAddress' and atp.PdfFileName = 'W9.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'RequestersNameAddress'   and atc.AlphaTrustContractName ='W9' 
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'SSN1' and atp.PdfFileName = 'W9.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'SSN1'   and atc.AlphaTrustContractName ='W9'
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'SSN2' and atp.PdfFileName = 'W9.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'SSN2'   and atc.AlphaTrustContractName ='W9'
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'SSN3' and atp.PdfFileName = 'W9.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'SSN3'   and atc.AlphaTrustContractName ='W9' 
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'TIN1' and atp.PdfFileName = 'W9.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'TIN1'   and atc.AlphaTrustContractName ='W9'
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'TIN2' and atp.PdfFileName = 'W9.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'TIN2'   and atc.AlphaTrustContractName ='W9'
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Zip' and atp.PdfFileName = 'W9.pdf') as PdfFieldID,
		umd.ID as UiFieldID	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'Zip'   and atc.AlphaTrustContractName ='W9'
 -------------------------------------------------------------------------------------EFT----------------------------------------------------------------------------------------
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'pronto_signer1' and atp.PdfFileName = 'EFT.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'AccountName'   and atc.AlphaTrustContractName ='EFT'
  
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'AccountNumber' and atp.PdfFileName = 'EFT.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'AccountNumber'   and atc.AlphaTrustContractName ='EFT'
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'BankAddress1' and atp.PdfFileName = 'EFT.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'BankAddress1'   and atc.AlphaTrustContractName ='EFT'
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'BankAddress2' and atp.PdfFileName = 'EFT.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'BankAddress2'   and atc.AlphaTrustContractName ='EFT'
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'BankCity' and atp.PdfFileName = 'EFT.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'BankCity'   and atc.AlphaTrustContractName ='EFT' 
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'BankContact' and atp.PdfFileName = 'EFT.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'BankContact'   and atc.AlphaTrustContractName ='EFT'
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'BankName' and atp.PdfFileName = 'EFT.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'BankName'   and atc.AlphaTrustContractName ='EFT'
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'BankPhone' and atp.PdfFileName = 'EFT.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'BankPhone'   and atc.AlphaTrustContractName ='EFT' 
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'BankState' and atp.PdfFileName = 'EFT.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'BankState'   and atc.AlphaTrustContractName ='EFT'
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'BankZip' and atp.PdfFileName = 'EFT.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'BankZip'   and atc.AlphaTrustContractName ='EFT'
union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'FullName' and atp.PdfFileName = 'EFT.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'FullName'   and atc.AlphaTrustContractName ='EFT' 
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'PayIDMask' and atp.PdfFileName = 'EFT.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'PayIDMask'   and atc.AlphaTrustContractName ='EFT'
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'RoutingNumber' and atp.PdfFileName = 'EFT.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'RoutingNumber'   and atc.AlphaTrustContractName ='EFT'
) as src 
	on src.PdfFieldID = trg.PdfFieldID and trg.UiFieldID = src.UiFieldID 
		when not matched by target then insert(PdfFieldID, UiFieldID)
			values(src.PdfFieldID, src.UiFieldID);
go

-------------------------------------------------------------------------------------FA LookupValues----------------------------------------------------------------------------------------
create table #temptable ( Value varchar(15), Description varchar(255) );
insert into #temptable
values
('A', 'A-An organization exempt from tax under section 501(a) or any individual retirement plan as defined in section 7701(a)(37)' ), 
('B', 'B-The United States or any of its agencies or instrumentalities' ), 
('C', 'C-A state, the District of Columbia, a U.S. commonwealth or possession, or any of their political subdivisions or instrumentalities' ), 
('C','D-A corporation the stock of which is regularly traded on one or more established securities markets, as described in Regulations section 1.1472-1(c)(1)(i)' ), 
('E', 'E-A corporation that is a member of the same expanded affiliated group as a corporation described in Regulations section 1.1472-1(c)(1)(i)' ), 
('F','F-A dealer in securities, commodities, or derivative financial instruments (including notional principal contracts, futures, forwards, and options) that is registered as such under the laws of the United States or any state' ), 
('G','G-A real estate investment trust' ), 
('H','H-A regulated investment company as defined in section 851 or an entity registered at all times during the tax year under the Investment Company Act of 1940' ), 
('I','I-A common trust fund as defined in section 584(a)' ), 
('J', 'J-A bank as defined in section 581' ), 
('K', 'K-A broker' ), 
('L', 'L-A trust exempt from tax under section 664 or described in section 4947(a)(1)' ), 
('M','M-A tax exempt trust under a section 403(b) plan or section 457(g) plan' ), 
('N/A','N/A' );
merge bur.LookupValues trg
using
(
	select t.Value, t.Description, (select l.ID from bur.Lookups l where l.Name = 'FATCA Codes') as LookupID  from #temptable t
		
) as src
	on  trg.LookupID = src.LookupID and src.Value = trg.Value
		when not matched by target then insert(Value, Description, LookupID)
			values(src.Value, src.Description, src.LookupID);
go
drop table #temptable;
-------------------------------------------------------------------------------------CodePay----------------------------------------------------------------------------------------
create table #Ex ( Value varchar(15), Description varchar(255) );
insert into #Ex
values
( '1','1-An organization exempt from tax under section 501(a), any IRA, or a custodial account under section 403(b)(7) if the account satisfies the requirements of section 401(f)(2)' ), 
( '10','10-A common trust fund operated by a bank under section 584(a)' ), 
( '11','11-A financial institution' ), 
( '12','12-A middleman known in the investment community as a nominee or custodian' ), 
( '13','13-A trust exempt from tax under section 664 or described in section 4947' ), 
( '2','2-The United States or any of its agencies or instrumentalities' ), 
( '3','3-A state, the District of Columbia, a U.S. commonwealth or possession, or any of their political subdivisions or instrumentalities' ), 
( '4','4-A foreign government or any of its political subdivisions, agencies, or instrumentalities' ), 
( '5','5-A corporation' ), 
( '6','6-A dealer in securities or commodities required to register in the United States, the District of Columbia, or a U.S. commonwealth or possession' ), 
( '7','7-A futures commission merchant registered with the Commodity Futures Trading Commission' ), 
( '8','8-A real estate investment trust' ), 
( '9','9-An entity registered at all times during the tax year under the Investment Company Act of 1940' );
merge bur.LookupValues trg
using
(
	select t.Value, t.Description, (select l.ID from bur.Lookups l where l.Name = 'Exempt Payee Codes') as LookupID  from #Ex t
		
) as src
	on  trg.LookupID = src.LookupID and src.Value = trg.Value
		when not matched by target then insert(Value, Description, LookupID)
			values(src.Value, src.Description, src.LookupID);
go
drop table #Ex;

-------------------------------------------------------------------------------------UpdatePdfFildType(PdfMergeDictionary)----------------------------------------------------------------------------------------
merge into bur.PdfMergeDictionary as trg
using
(
	select				'FullName' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula , (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'BusinessName' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'BusinessType' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'BusinessTypeLimited' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'BusinessTypeOther' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'ExemptCode' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'FATCACode' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'Address' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'City' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'State' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'Zip' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'RequestersNameAddress' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'AccountList' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'TIN1' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'TIN2' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'SSN1' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'SSN2' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'SSN3' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'pronto_signer1' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Signer') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	union select  'pronto_signer1_date' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Date') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'W9.pdf'
	
-------------------------------------------------------------------------------------EFT_Contract----------------------------------------------------------------------------------------
	union select	'FullName' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId  from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'EFT.pdf'
	union select  'PayIDMask' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'EFT.pdf'
	union select  'BankName' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'EFT.pdf'
	union select  'BankAddress1' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'EFT.pdf'
	union select  'BankAddress2' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'EFT.pdf'
	union select  'BankCity' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'EFT.pdf'
	union select  'BankState' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'EFT.pdf'
	union select  'BankZip' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'EFT.pdf'
	union select  'BankContact' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'EFT.pdf'
	union select  'BankPhone' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'EFT.pdf'
	union select  'RoutingNumber' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'EFT.pdf'
	union select  'AccountNumber' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'EFT.pdf'
	union select  'AccountName' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'EFT.pdf'
	union select  'pronto_signer1' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Signer') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'EFT.pdf'
	union select  'pronto_signer1_date' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Date') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'EFT.pdf'
	
) as src
on trg.PdfFieldName = src.PdfFieldName and trg.PdfID = src.TemplateFieldID and src.PdfFieldTypeId <> trg.PdfFieldTypeId 
	when  matched    then update set trg.PdfFieldTypeId = src.PdfFieldTypeId;
go

update bur.PdfMergeDictionary set PdfFieldTypeId = (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') where PdfFieldName = 'Date' and PdfID = (select atp.ID from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'CDA.pdf');

-------------------------------------------------------------------------------------CDA----------------------------------------------------------------------------------------
merge into bur.PdfMergeDictionary as trg
using
(
	select				'Date' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula , (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'CDA.pdf'
	union select  'FullName' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'CDA.pdf'
	union select  'Address' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'CDA.pdf'
	union select  'Signer1' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Signer') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'CDA.pdf'
	union select  'Signer2' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'CDA.pdf'
	union select  'Signer2Date' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'CDA.pdf'
	--union select  'Signer1Date' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Date') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'CDA.pdf'
	union select  'ServiceDescription' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'CDA.pdf'
	union select  'Signer2Name' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'CDA.pdf'
	union select  'Signer2Title' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'CDA.pdf'

	
) as src
on trg.PdfFieldName = src.PdfFieldName and trg.PdfID = src.TemplateFieldID
	when not matched by target then insert(PdfFieldName,Formula, PdfID, PdfFieldTypeId)
		values(src.PdfFieldName,src.Formula,src.TemplateFieldID, src.PdfFieldTypeId);
go



-------------------------------------------------------------------------------------CDA-UI----------------------------------------------------------------------------------------
merge bur.UiMergeDictionary trg
using
(
		select				'First_Name' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='CDA'
		union select  'Name_Last' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='CDA'
		union select  'Address1' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='CDA'
		union select  'City' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='CDA'
		union select  'State' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='CDA'
		union select  'Zip' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='CDA'
		union select  'ServiceDescription' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='CDA'
		union select  'Signer2Name' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='CDA'
		union select  'Signer2Title' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='CDA'
		union select  'Signer2Date' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='CDA'
		union select  'Signer2' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='CDA'
		union select  'Date' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='CDA'
		
	
) as src
	on trg.ContractID=src.ContractID and trg.FieldName = src.FieldName
		when not matched by target  then insert(ContractID,FieldName,FieldType)
			values(src.ContractID, src.FieldName, src.FieldType);
go


-------------------------------------------------------------------------------------CDA-Map----------------------------------------------------------------------------------------
merge bur.ContractFieldDetail trg
using
(
-------------------------------------------------------------------------------------CDA----------------------------------------------------------------------------------------
	select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Signer1' and atp.PdfFileName = 'CDA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'First_Name'   and atc.AlphaTrustContractName ='CDA'
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Signer1' and atp.PdfFileName = 'CDA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'Name_Last'   and atc.AlphaTrustContractName ='CDA'

union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Date' and atp.PdfFileName = 'CDA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'Date'   and atc.AlphaTrustContractName ='CDA'

	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'FullName' and atp.PdfFileName = 'CDA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'First_Name'   and atc.AlphaTrustContractName ='CDA'
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'FullName' and atp.PdfFileName = 'CDA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'Name_Last'   and atc.AlphaTrustContractName ='CDA'

	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Address' and atp.PdfFileName = 'CDA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'Address1'   and atc.AlphaTrustContractName ='CDA'
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Address' and atp.PdfFileName = 'CDA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'City'   and atc.AlphaTrustContractName ='CDA'
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Address' and atp.PdfFileName = 'CDA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'State'   and atc.AlphaTrustContractName ='CDA'
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Address' and atp.PdfFileName = 'CDA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'Zip'   and atc.AlphaTrustContractName ='CDA'

union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'ServiceDescription' and atp.PdfFileName = 'CDA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'ServiceDescription'   and atc.AlphaTrustContractName ='CDA'


	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Signer2Name' and atp.PdfFileName = 'CDA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'Signer2Name'   and atc.AlphaTrustContractName ='CDA'
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Signer2Title' and atp.PdfFileName = 'CDA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'Signer2Title'   and atc.AlphaTrustContractName ='CDA'

union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Signer2Date' and atp.PdfFileName = 'CDA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'Signer2Date'   and atc.AlphaTrustContractName ='CDA'
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Signer2' and atp.PdfFileName = 'CDA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'Signer2'   and atc.AlphaTrustContractName ='CDA'
	

) as src 
	on src.PdfFieldID = trg.PdfFieldID and trg.UiFieldID = src.UiFieldID 
		when not matched by target then insert(PdfFieldID, UiFieldID)
			values(src.PdfFieldID, src.UiFieldID);

merge bur.MergeDictionary trg
using
(
	select 'as ps where ps.SOI_ID' as Constr,  'dbo' as sch, 'SOI' as tabl, 'Name_First' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'CDA' and umd.FieldName = 'First_Name')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'CDA' and atp.PdfFileName = 'CDA.pdf'
	
	union select 'as ps where ps.SOI_ID' as Constr,  'dbo' as sch, 'SOI' as tabl, 'Name_Last' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'CDA' and umd.FieldName = 'Name_Last')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'CDA' and atp.PdfFileName = 'CDA.pdf'

	union select ' as p join [SOI] ps on ps.Pref_Address = p.[SOI_Add_ID]  where ps.SOI_ID' as Constr,  'dbo' as sch, 'SOI_Addresses' as tabl, 'Address1' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'CDA' and umd.FieldName = 'Address1')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'CDA' and atp.PdfFileName = 'CDA.pdf'
	
	union select ' as p join [SOI] ps on ps.Pref_Address = p.[SOI_Add_ID]  where ps.SOI_ID' as Constr,  'dbo' as sch, 'SOI_Addresses' as tabl, 'City' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'CDA' and umd.FieldName = 'City')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'CDA' and atp.PdfFileName = 'CDA.pdf'

	union select ' as p join [SOI] ps on ps.Pref_Address = p.[SOI_Add_ID]  where ps.SOI_ID' as Constr,  'dbo' as sch, 'SOI_Addresses' as tabl, 'State' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'CDA' and umd.FieldName = 'State')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'CDA' and atp.PdfFileName = 'CDA.pdf'
	
	union select ' as p join [SOI] ps on ps.Pref_Address = p.[SOI_Add_ID]  where ps.SOI_ID' as Constr,  'dbo' as sch, 'SOI_Addresses' as tabl, 'Zip' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'CDA' and umd.FieldName = 'Zip')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'CDA' and atp.PdfFileName = 'CDA.pdf'


) as src
	on 	src.UiFieldID = trg.UiFieldID and src.Field = trg.ATField
		when not matched by target then insert(Constr, ATScheme, ATTable, ATField, UiFieldID, ContractDetailID)
			values(src.Constr, src.sch, src.tabl, src.Field, src.UiFieldID, src.ID);
go


-------------------------------------------------------------------------------------'BIPI Patient Spokesperson Agreement Caregiver' PDF----------------------------------------------------------------------------------------
merge into bur.PdfMergeDictionary as trg
using
(
	select				'Date' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula , (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BIPIPSAC.pdf'
	union select  'FullName' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BIPIPSAC.pdf'
	union select  'Address' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BIPIPSAC.pdf'
	union select  'Signer1' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Signer') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BIPIPSAC.pdf'
	union select  'Signer2' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BIPIPSAC.pdf'
	--union select  'Signer1Date' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Date') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BIPIPSAC.pdf'
	union select  'Disease' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BIPIPSAC.pdf'
	union select  'activity' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BIPIPSAC.pdf'
	union select  'ActivityName' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BIPIPSAC.pdf'
	union select  'Scope' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BIPIPSAC.pdf'
	union select  'DiseaseProduct' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BIPIPSAC.pdf'
	union select  'Compensation' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BIPIPSAC.pdf'
	union select  'MediaMessage' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BIPIPSAC.pdf'
	union select  'Term' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Date') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BIPIPSAC.pdf'
	union select  'Phone' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BIPIPSAC.pdf'
	union select  'CityStateZip' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BIPIPSAC.pdf'
	
) as src
on trg.PdfFieldName = src.PdfFieldName and trg.PdfID = src.TemplateFieldID
	when not matched by target then insert(PdfFieldName,Formula, PdfID, PdfFieldTypeId)
		values(src.PdfFieldName,src.Formula,src.TemplateFieldID, src.PdfFieldTypeId);
go

---------------------------------------------------------------------------------------'BIPI Patient Spokesperson Agreement Caregiver' UI----------------------------------------------------------------------------------------
merge bur.UiMergeDictionary trg
using
(
		
		 select  'speaker_address' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Caregiver'
		union select  'City' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Caregiver'
		union select  'State' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Caregiver'
		union select  'Zip' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Caregiver'
		union select  'speaker_csz' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Caregiver'
		union select  'activity' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Caregiver'
		union select  'activityname' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Caregiver'
		union select  'scope' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Caregiver'
    union select  'DiseaseProduct' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Caregiver'
		 union select  'Disease' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Caregiver'
		union select  'compensation' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Caregiver'
		union select  'FullName' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Caregiver' --?
		union select  'mediamessage' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Caregiver'
		union select  'term' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Caregiver'
		union select  'speaker_phone' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Caregiver'
		union select  'Signer2' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Caregiver'
		union select  'Date' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Caregiver'
		
	
) as src
	on trg.ContractID=src.ContractID and trg.FieldName = src.FieldName
		when not matched by target  then insert(ContractID,FieldName,FieldType)
			values(src.ContractID, src.FieldName, src.FieldType);
go
-------------------------------------------------------------------------------------'BIPI Patient Spokesperson Agreement Caregiver' MergeDictionary----------------------------------------------------------------------------------------
merge bur.MergeDictionary trg
using
(
	select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BIPI Patient Spokesperson Agreement Caregiver'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, ' concat(Name_First, '' '', Name_Last)' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Caregiver' and umd.FieldName = 'FullName')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Caregiver' and atp.PdfFileName = 'BIPIPSAC.pdf'
	
	--union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BIPI Patient Spokesperson Agreement Caregiver'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'brand' as Field,
	--				(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Caregiver' and umd.FieldName = 'Product')  as UiFieldID, cd.ID 
	--from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Caregiver' and atp.PdfFileName = 'BIPIPSAC.pdf'

	union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BIPI Patient Spokesperson Agreement Caregiver'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'speaker_address' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Caregiver' and umd.FieldName = 'speaker_address')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Caregiver' and atp.PdfFileName = 'BIPIPSAC.pdf'
	
		union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BIPI Patient Spokesperson Agreement Caregiver'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'speaker_address' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Caregiver' and umd.FieldName = 'speaker_address')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Caregiver' and atp.PdfFileName = 'BIPIPSAC.pdf'

	union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BIPI Patient Spokesperson Agreement Caregiver'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'disease' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Caregiver' and umd.FieldName = 'Disease')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Caregiver' and atp.PdfFileName = 'BIPIPSAC.pdf'

	union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BIPI Patient Spokesperson Agreement Caregiver'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'speaker_csz' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Caregiver' and umd.FieldName = 'speaker_csz')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Caregiver' and atp.PdfFileName = 'BIPIPSAC.pdf'
	
	union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BIPI Patient Spokesperson Agreement Caregiver'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'activity' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Caregiver' and umd.FieldName = 'activity')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Caregiver' and atp.PdfFileName = 'BIPIPSAC.pdf'	
	
	union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BIPI Patient Spokesperson Agreement Caregiver'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'activityname' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Caregiver' and umd.FieldName = 'activityname')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Caregiver' and atp.PdfFileName = 'BIPIPSAC.pdf'	

		union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BIPI Patient Spokesperson Agreement Caregiver'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'scope' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Caregiver' and umd.FieldName = 'scope')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Caregiver' and atp.PdfFileName = 'BIPIPSAC.pdf'	
	
		union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BIPI Patient Spokesperson Agreement Caregiver'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'compensation' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Caregiver' and umd.FieldName = 'compensation')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Caregiver' and atp.PdfFileName = 'BIPIPSAC.pdf'	

		union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BIPI Patient Spokesperson Agreement Caregiver'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'mediamessage' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Caregiver' and umd.FieldName = 'mediamessage')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Caregiver' and atp.PdfFileName = 'BIPIPSAC.pdf'	
	
	union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BIPI Patient Spokesperson Agreement Caregiver'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'term' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Caregiver' and umd.FieldName = 'term')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Caregiver' and atp.PdfFileName = 'BIPIPSAC.pdf'

			union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BIPI Patient Spokesperson Agreement Caregiver'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'speaker_phone' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Caregiver' and umd.FieldName = 'speaker_phone')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Caregiver' and atp.PdfFileName = 'BIPIPSAC.pdf'

) as src
	on 	src.UiFieldID = trg.UiFieldID and src.Field = trg.ATField
		when not matched by target then insert(Constr, ATScheme, ATTable, ATField, UiFieldID, ContractDetailID)
			values(src.Constr, src.sch, src.tabl, src.Field, src.UiFieldID, src.ID);
go
----------------------------------------------------------------------------------------------ready-----------------------------------------------------------------

-------------------------------------------------------------------------------------===================================================----------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------'BIPI Patient Spokesperson Agreement Patient' PDF----------------------------------------------------------------------------------------
merge into bur.PdfMergeDictionary as trg
using
(
	
	select				'Date' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula , (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Date') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BIPIPSA.pdf'
	union select  'FullName' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BIPIPSA.pdf'
	union select  'Address' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BIPIPSA.pdf'
	union select  'Signer1' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Signer') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BIPIPSA.pdf'
	union select  'Signer2' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BIPIPSA.pdf'
--	union select  'Signer1Date' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Date') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BIPIPSA.pdf'
	union select  'Disease' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BIPIPSA.pdf'
	union select  'ActivityName' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BIPIPSA.pdf'
	union select  'Scope' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BIPIPSA.pdf'
	union select  'DiseaseProduct' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BIPIPSA.pdf'
	union select  'Compensation' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BIPIPSA.pdf'
	union select  'MediaMessage' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BIPIPSA.pdf'
	union select  'Term' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BIPIPSA.pdf'
	union select  'Phone' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BIPIPSA.pdf'
	union select  'CityStateZip' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BIPIPSA.pdf'
	union select  'Activity' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BIPIPSA.pdf'
	union select  'Product' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BIPIPSA.pdf'
) as src
on trg.PdfFieldName = src.PdfFieldName and trg.PdfID = src.TemplateFieldID
	when not matched by target then insert(PdfFieldName,Formula, PdfID, PdfFieldTypeId)
		values(src.PdfFieldName,src.Formula,src.TemplateFieldID, src.PdfFieldTypeId);
go

---------------------------------------------------------------------------------------'BIPI Patient Spokesperson Agreement Patient' UI----------------------------------------------------------------------------------------
merge bur.UiMergeDictionary trg
using
(
		select				'FullName' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Patient'
		union select  'speaker_address' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Patient'
		union select  'City' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Patient'
		union select  'State' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Patient'
		union select  'Zip' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Patient'
		
		union select  'speaker_csz' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Patient'
		
		union select  'activity' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Patient'
		union select  'disease' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Patient'
		union select  'activityname' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Patient'
		union select  'scope' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Patient'

		union select  'DiseaseProduct' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Patient'
		union select  'compensation' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Patient'
		
		union select  'mediamessage' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Patient'
		union select  'term' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Patient'
		union select  'Signer2' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Patient'
		union select  'speaker_phone' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Patient'
		union select  'Product' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Patient'
		union select  'Date' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Patient'
		
	
) as src
	on trg.ContractID=src.ContractID and trg.FieldName = src.FieldName
		when not matched by target  then insert(ContractID,FieldName,FieldType)
			values(src.ContractID, src.FieldName, src.FieldType);
go
-------------------------------------------------------------------------------------'BIPI Patient Spokesperson Agreement Patient' MergeDictionary----------------------------------------------------------------------------------------
merge bur.MergeDictionary trg
using
(
		select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BIPI Patient Spokesperson Agreement Patient'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, ' concat(Name_First, '' '', Name_Last)' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Patient' and umd.FieldName = 'FullName')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Patient' and atp.PdfFileName = 'BIPIPSA.pdf'
	
	union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BIPI Patient Spokesperson Agreement Patient'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, ' concat(disease, '' '', brand)' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Patient' and umd.FieldName = 'DiseaseProduct')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Patient' and atp.PdfFileName = 'BIPIPSA.pdf'

	union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BIPI Patient Spokesperson Agreement Patient'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'disease' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Patient' and umd.FieldName = 'Disease')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Patient' and atp.PdfFileName = 'BIPIPSA.pdf'

	union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BIPI Patient Spokesperson Agreement Patient'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'speaker_address' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Patient' and umd.FieldName = 'speaker_address')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Patient' and atp.PdfFileName = 'BIPIPSA.pdf'
	
	union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BIPI Patient Spokesperson Agreement Patient'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'speaker_csz' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Patient' and umd.FieldName = 'speaker_csz')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Patient' and atp.PdfFileName = 'BIPIPSA.pdf'
	
	union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BIPI Patient Spokesperson Agreement Patient'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'activity' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Patient' and umd.FieldName = 'activity')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Patient' and atp.PdfFileName = 'BIPIPSA.pdf'	
	
	union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BIPI Patient Spokesperson Agreement Patient'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'activityname' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Patient' and umd.FieldName = 'activityname')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Patient' and atp.PdfFileName = 'BIPIPSA.pdf'	

		union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BIPI Patient Spokesperson Agreement Patient'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'scope' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Patient' and umd.FieldName = 'scope')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Patient' and atp.PdfFileName = 'BIPIPSA.pdf'	
	
		union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BIPI Patient Spokesperson Agreement Patient'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'compensation' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Patient' and umd.FieldName = 'compensation')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Patient' and atp.PdfFileName = 'BIPIPSA.pdf'	

		union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BIPI Patient Spokesperson Agreement Patient'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'mediamessage' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Patient' and umd.FieldName = 'mediamessage')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Patient' and atp.PdfFileName = 'BIPIPSA.pdf'	

			union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BIPI Patient Spokesperson Agreement Patient'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'term' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Patient' and umd.FieldName = 'term')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Patient' and atp.PdfFileName = 'BIPIPSA.pdf'

		union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BIPI Patient Spokesperson Agreement Patient'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'speaker_phone' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Patient' and umd.FieldName = 'speaker_phone')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Patient' and atp.PdfFileName = 'BIPIPSA.pdf'

	union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BIPI Patient Spokesperson Agreement Patient'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'brand' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Patient' and umd.FieldName = 'Product')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Patient' and atp.PdfFileName = 'BIPIPSA.pdf'

) as src
	on 	src.UiFieldID = trg.UiFieldID and src.Field = trg.ATField
		when not matched by target then insert(Constr, ATScheme, ATTable, ATField, UiFieldID, ContractDetailID)
			values(src.Constr, src.sch, src.tabl, src.Field, src.UiFieldID, src.ID);
go


 -------------------------------------------------------------------------------------TempCosigners----------------------------------------------------------------------------------------


merge into bur.ContractCosigner trg
using
(
				select l.ID as LinkID, 'ssherman' as Username, 'Password@987' as Password, 'kizhakk+1@gmail.com' as Email, 'Scott Sherman' as SignatureName, 1 as isDefault from bur.AlphaTrustContract as l where l.AlphaTrustContractName = 'BNA'
	union select l.ID as LinkID, 'rfolts' as Username, 'Password@987' as Password, 'kizhakk+2@gmail.com' as Email, 'Robb Folts' as SignatureName, 1 as isDefault from bur.AlphaTrustContract as l where l.AlphaTrustContractName = 'CDA'
	union select l.ID as LinkID, 'ssmolinski' as Username, 'Password@987' as Password, 'kizhakk+3@gmail.com' as Email, 'R. Duane Clark' as SignatureName, 1 as isDefault from bur.AlphaTrustContract as l where l.AlphaTrustContractName = 'EFT'
	union select l.ID as LinkID, 'rwaywood' as Username, 'Password@987' as Password, 'kizhakk+4@gmail.com' as Email, 'Richard J. Waywood' as SignatureName, 1 as isDefault from bur.AlphaTrustContract as l where l.AlphaTrustContractName = 'W9'
	union select l.ID as LinkID, 'jchien' as Username, 'Password@987' as Password, 'kizhakk+5@gmail.com' as Email, 'Jennifer Chien' as SignatureName, 1 as isDefault from bur.AlphaTrustContract as l where l.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Patient'
	union select l.ID as LinkID, 'mschneider' as Username, 'Password@987' as Password, 'kizhakk+6@gmail.com' as Email, 'Michael Schneider' as SignatureName, 1 as isDefault from bur.AlphaTrustContract as l where l.AlphaTrustContractName = 'BIPI Patient Spokesperson Agreement Caregiver'
  union select null as LinkID, 'Default' as Username, '333333' as Password, 'kizhakk+6@gmail.com' as Email, 'Default' as SignatureName, 1 as isDefault 
) as src
on  src.Username = trg.Username  and src.Email = trg.Email 
 when not matched by target then insert  (Username, Password,Email,SignatureName,LinkID,isDefault) 
  values (src.Username, src.Password, src.Email, src.SignatureName, src.LinkID,src.isDefault);
go

merge bur.ContractFieldDetail trg
using
(

	
-------------------------------------------------------------------------------------BIPI Patient Spokesperson Agreement Caregiver----------------------------------------------------------------------------------------
	select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'FullName' and atp.PdfFileName = 'BIPIPSAC.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'FullName'   and atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Caregiver'
	--union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'FullName' and atp.PdfFileName = 'BIPIPSAC.pdf') as PdfFieldID,
	--	umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'Name_Last'   and atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Caregiver'

union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Address' and atp.PdfFileName = 'BIPIPSAC.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'speaker_address'   and atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Caregiver'

	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'CityStateZip' and atp.PdfFileName = 'BIPIPSAC.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'speaker_csz'   and atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Caregiver'
	
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'ActivityName' and atp.PdfFileName = 'BIPIPSAC.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'activityname'   and atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Caregiver'

		union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'activity' and atp.PdfFileName = 'BIPIPSAC.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'activity'   and atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Caregiver'

	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Scope' and atp.PdfFileName = 'BIPIPSAC.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'scope'   and atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Caregiver'

		
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Disease' and atp.PdfFileName = 'BIPIPSAC.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'Disease'   and atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Caregiver'

	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'DiseaseProduct' and atp.PdfFileName = 'BIPIPSAC.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'DiseaseProduct'   and atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Caregiver'

	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Compensation' and atp.PdfFileName = 'BIPIPSAC.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'compensation'   and atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Caregiver'
		-------------------------------------------------------------------------------------temp----------------------------------------------------------------------------------------
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'MediaMessage' and atp.PdfFileName = 'BIPIPSAC.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'mediamessage'   and atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Caregiver'

union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Phone' and atp.PdfFileName = 'BIPIPSAC.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'speaker_phone'   and atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Caregiver'


	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Term' and atp.PdfFileName = 'BIPIPSAC.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'term'   and atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Caregiver'

			union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Date' and atp.PdfFileName = 'BIPIPSAC.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'Date'   and atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Caregiver'

			union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Signer2' and atp.PdfFileName = 'BIPIPSAC.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'Signer2'   and atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Caregiver'

		union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Signer1' and atp.PdfFileName = 'BIPIPSAC.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'FullName'   and atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Caregiver'

) as src 
	on src.PdfFieldID = trg.PdfFieldID and trg.UiFieldID = src.UiFieldID 
		when not matched by target then insert(PdfFieldID, UiFieldID)
			values(src.PdfFieldID, src.UiFieldID);

-------------------------------------------------------------------------------------'BIPI Patient Spokesperson Agreement'----------------------------------------------------------------------------------------
	merge bur.ContractFieldDetail trg
using
(
			select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'FullName' and atp.PdfFileName = 'BIPIPSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'FullName'   and atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Patient'

	--union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'FullName' and atp.PdfFileName = 'BIPIPSA.pdf') as PdfFieldID,
	--	umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'Name_Last'   and atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Patient'

union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Address' and atp.PdfFileName = 'BIPIPSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'speaker_address'   and atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Patient'

	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'CityStateZip' and atp.PdfFileName = 'BIPIPSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'speaker_csz'   and atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Patient'
	
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'ActivityName' and atp.PdfFileName = 'BIPIPSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'activityname'   and atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Patient'

		union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Activity' and atp.PdfFileName = 'BIPIPSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'activity'   and atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Patient'

	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Scope' and atp.PdfFileName = 'BIPIPSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'scope'   and atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Patient'
		
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'DiseaseProduct' and atp.PdfFileName = 'BIPIPSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'DiseaseProduct'   and atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Patient'

		union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Disease' and atp.PdfFileName = 'BIPIPSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'Disease'   and atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Patient'

		union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Product' and atp.PdfFileName = 'BIPIPSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'Product'   and atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Patient'

	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Compensation' and atp.PdfFileName = 'BIPIPSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'compensation'   and atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Patient'
		-------------------------------------------------------------------------------------temp----------------------------------------------------------------------------------------
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'MediaMessage' and atp.PdfFileName = 'BIPIPSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'mediamessage'   and atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Patient'

union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Phone' and atp.PdfFileName = 'BIPIPSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'speaker_phone'   and atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Patient'


	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Term' and atp.PdfFileName = 'BIPIPSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'term'   and atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Patient'

		union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Date' and atp.PdfFileName = 'BIPIPSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'Date'   and atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Patient'
		union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Signer2' and atp.PdfFileName = 'BIPIPSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'Signer2'   and atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Patient'
		union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Signer1' and atp.PdfFileName = 'BIPIPSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'FullName'   and atc.AlphaTrustContractName ='BIPI Patient Spokesperson Agreement Patient'



) as src 
	on src.PdfFieldID = trg.PdfFieldID and trg.UiFieldID = src.UiFieldID 
		when not matched by target then insert(PdfFieldID, UiFieldID)
			values(src.PdfFieldID, src.UiFieldID);


-------------------------------------------------------------------------------------BNAIndividual----------------------------------------------------------------------------------------
merge into bur.PdfMergeDictionary as trg
using
(
	select	'Date' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula , (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Date') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAIndividualCSA.pdf'
	union select  'FullName' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAIndividualCSA.pdf'
	union select  'Address' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAIndividualCSA.pdf'
	union select  'Signer1' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Signer') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAIndividualCSA.pdf'
	union select  'Signer2' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAIndividualCSA.pdf'
--	union select  'Signer1Date' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Date') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAIndividualCSA.pdf'
	union select  'Signer2Date' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAIndividualCSA.pdf'
	union select  'CityStateZip' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAIndividualCSA.pdf'
	union select  'Signer2Name' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAIndividualCSA.pdf'
	union select  'Signer2Title' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAIndividualCSA.pdf'
--	union select  'Signer3' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAIndividualCSA.pdf'
	
	union select  'BIPOName' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAIndividualCSA.pdf'
	union select  'BIPOTitle' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAIndividualCSA.pdf'
	union select  'BIPOAddress' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAIndividualCSA.pdf'
	union select  'BIPOPhone' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAIndividualCSA.pdf'
	union select  'BIPOEmail' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAIndividualCSA.pdf'
	union select  'ConsultantPhone' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAIndividualCSA.pdf'
	union select  'ConsultantEmail' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAIndividualCSA.pdf'
	union select  'disease' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAIndividualCSA.pdf'
	
	union select  'department' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAIndividualCSA.pdf'
	union select  'ScopeOfService' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAIndividualCSA.pdf'
	union select  'ActivityCompensation' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAIndividualCSA.pdf'
	union select  'ActivityHours' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAIndividualCSA.pdf'
	union select  'TravelCompensation' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAIndividualCSA.pdf'
	union select  'FeeTotal' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAIndividualCSA.pdf'
	union select  'Incidentals' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAIndividualCSA.pdf'
) as src
on trg.PdfFieldName = src.PdfFieldName and trg.PdfID = src.TemplateFieldID
	when not matched by target then insert(PdfFieldName,Formula, PdfID, PdfFieldTypeId)
		values(src.PdfFieldName,src.Formula,src.TemplateFieldID, src.PdfFieldTypeId);
go

-------------------------------------------------------------------------------------BNAIndividual(UI)----------------------------------------------------------------------------------------
merge bur.UiMergeDictionary trg
using
(
						select	'FullName' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BNA'
	union select  'speaker_address' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BNA'
	union select  'CityStateZip' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BNA'
	union select  'BIPOName' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BNA'
	union select  'BIPOTitle' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BNA'
		
	union select  'BIPOAddress' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BNA'
		
	union select  'BIPOPhone' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BNA'
	union select  'BIPOEmail' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BNA'
	union select  'speaker_phone' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BNA'
	union select  'email' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BNA'

	union select  'ConsultantPhone' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BNA'
	union select  'ConsultantEmail' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BNA'
	
	union select  'Signer2' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BNA'
	union select  'Signer2Name' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BNA'
	union select  'Signer2Title' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BNA'
	union select  'Signer2Date' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BNA'
	union select  'Signer1' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BNA'
	--union select  'Signer1Date' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BNA'
	union select  'Signer3' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BNA'
	union select  'Signer3Date' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BNA'


	union select  'disease' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BNA'
	union select  'department' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BNA'
		
	union select  'ScopeofService' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BNA'
	union select  'ActivityCompensation' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BNA'

	union select  'Date' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BNA'
	union select  'ActivityHours' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BNA'
	union select  'TravelCompensation' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BNA'
	union select  'FeeTotal' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BNA'
	union select  'Incidentals' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BNA'
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	union select  'InstitutionName' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BNA'
	union select  'Address' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BNA'
	union select  'CompanyConsultant' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BNA'
	union select  'ConsultantAddress' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BNA'

	union select  'ConsultantPhone' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BNA'
	union select  'ConsultantEmail' as FieldName, (select lv.ID from bur.Lookups l join bur.LookupValues lv on lv.LookupID = l.ID where l.Name = 'Contract Field Source Type' and lv.Value = 'Text Box') as FieldType, atc.ID as ContractID from bur.AlphaTrustContract atc where atc.AlphaTrustContractName ='BNA'
		
) as src
	on trg.ContractID=src.ContractID and trg.FieldName = src.FieldName
		when not matched by target  then insert(ContractID,FieldName,FieldType)
			values(src.ContractID, src.FieldName, src.FieldType);

-------------------------------------------------------------------------------------BNAInd(Map)----------------------------------------------------------------------------------------

merge bur.MergeDictionary trg
using
(
	select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, ' concat(Name_First, '' '', Name_Last)' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'FullName')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAIndividualCSA.pdf'
	
	union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'Signer2Name' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'Signer2')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAIndividualCSA.pdf'

	union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'Signer2Name' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'Signer2Name')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAIndividualCSA.pdf'
	
	union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'Signer2Title' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'Signer2Title')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAIndividualCSA.pdf'

	
	union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'speaker_address' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'speaker_address')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAIndividualCSA.pdf'
	
	union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'speaker_csz' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'CityStateZip')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAIndividualCSA.pdf'
			
	union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'BIPOName' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'BIPOName')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAIndividualCSA.pdf'	

		union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'BIPOTitle' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'BIPOTitle')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAIndividualCSA.pdf'	
	
		union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'BIPOAddress' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'BIPOAddress')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAIndividualCSA.pdf'	

		union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'BIPOPhone' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'BIPOPhone')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAIndividualCSA.pdf'	

			union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'BIPOEmail' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'BIPOEmail')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAIndividualCSA.pdf'

	union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'speaker_phone' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'ConsultantPhone')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAIndividualCSA.pdf'	

			union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'email' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'ConsultantEmail')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAIndividualCSA.pdf'
	
			union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'disease' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'disease')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAIndividualCSA.pdf'	

			union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'department' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'department')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAIndividualCSA.pdf'
  
				union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'scope' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'ScopeofService')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAIndividualCSA.pdf'
	
				union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'compensation' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'ActivityCompensation')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAIndividualCSA.pdf'
	
				union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'hours' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'ActivityHours')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAIndividualCSA.pdf'
	
				union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'travelcompensation' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'TravelCompensation')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAIndividualCSA.pdf'
	
				union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'feetotal' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'FeeTotal')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAIndividualCSA.pdf'

					union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'incidentals' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'Incidentals')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAIndividualCSA.pdf'	

) as src
	on 	src.UiFieldID = trg.UiFieldID and src.Field = trg.ATField
		when not matched by target then insert(Constr, ATScheme, ATTable, ATField, UiFieldID, ContractDetailID)
			values(src.Constr, src.sch, src.tabl, src.Field, src.UiFieldID, src.ID);
go

-------------------------------------------------------------------------------------BNA(Ins)----------------------------------------------------------------------------------------
merge into bur.PdfMergeDictionary as trg
using
(
	select	'Date' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula , (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAInstitutionCSA.pdf'
	union select  'FullName' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAInstitutionCSA.pdf'
	union select  'Address' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAInstitutionCSA.pdf'

	union select  'ConsultantAddress' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAInstitutionCSA.pdf'
	
	union select  'Signer1' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Signer') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAInstitutionCSA.pdf'
	union select  'Signer2' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAInstitutionCSA.pdf'
	union select  'Signer1Date' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Date') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAInstitutionCSA.pdf'
	union select  'Signer2Date' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAInstitutionCSA.pdf'
	union select  'Signer2Name' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAInstitutionCSA.pdf'
	union select  'Signer2Title' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAInstitutionCSA.pdf'
	union select  'Signer3' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAInstitutionCSA.pdf'
	union select  'Signer3Date' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Date') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAInstitutionCSA.pdf'
	
	
	union select  'CityStateZip' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAInstitutionCSA.pdf'
	
	union select  'BIPOName' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAInstitutionCSA.pdf'

	union select  'CityStateZip' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAInstitutionCSA.pdf'

	union select  'BIPOTitle' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAInstitutionCSA.pdf'
	union select  'BIPOAddress' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAInstitutionCSA.pdf'
	union select  'BIPOPhone' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAInstitutionCSA.pdf'
	union select  'BIPOEmail' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAInstitutionCSA.pdf'
	union select  'ConsultantPhone' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAInstitutionCSA.pdf'
	union select  'ConsultantEmail' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAInstitutionCSA.pdf'
	union select  'disease' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAInstitutionCSA.pdf'
	
	union select  'department' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAInstitutionCSA.pdf'
	union select  'ScopeOfService' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAInstitutionCSA.pdf'
	union select  'ActivityCompensation' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAInstitutionCSA.pdf'
	union select  'ActivityHours' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAInstitutionCSA.pdf'
	union select  'TravelCompensation' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAInstitutionCSA.pdf'
	union select  'FeeTotal' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAInstitutionCSA.pdf'
	union select  'Incidentals' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAInstitutionCSA.pdf'
	union select	'InstitutionName' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula , (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAInstitutionCSA.pdf'
	union select  'Address' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAInstitutionCSA.pdf'
	union select  'CompanyConsultant' as PdfFieldName, atp.ID as TemplateFieldID, null as Formula, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where l.Name = 'Pdf Filed Type' and lv.Value = 'Text') as PdfFieldTypeId from bur.AlphaTrustPdf as atp where atp.PdfFileName = 'BNAInstitutionCSA.pdf'
) as src
on trg.PdfFieldName = src.PdfFieldName and trg.PdfID = src.TemplateFieldID
	when not matched by target then insert(PdfFieldName,Formula, PdfID, PdfFieldTypeId)
		values(src.PdfFieldName,src.Formula,src.TemplateFieldID, src.PdfFieldTypeId);
go
-------------------------------------------------------------------------------------BNAIns----------------------------------------------------------------------------------------

merge bur.MergeDictionary trg
using
(
	
	select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'Signer2Name' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'Signer2Name')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAInstitutionCSA.pdf'
	
	union	select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'Signer2Title' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'Signer2Title')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAInstitutionCSA.pdf'

	union	select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'Signer2Name' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'Signer2')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAInstitutionCSA.pdf'

	union	select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'speaker_csz' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'CityStateZip')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAInstitutionCSA.pdf'

	union	select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'speaker_phone' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'ConsultantPhone')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAInstitutionCSA.pdf'

	union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'email' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'ConsultantEmail')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAInstitutionCSA.pdf'
	-------------------------------------------------------------------------------------Concat----------------------------------------------------------------------------------------
	
	union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, ' concat(speaker_address, '', '', speaker_csz)' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'ConsultantAddress')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAInstitutionCSA.pdf'

	union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, ' concat(Name_First, '' '', Name_Last)' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'FullName')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAInstitutionCSA.pdf'
  	
	--union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, ' concat(Name_First, '' '', Name_Last)' as Field,
	--				(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'CompanyConsultant')  as UiFieldID, cd.ID 
	--from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAInstitutionCSA.pdf'
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------			
	union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'BIPOName' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'BIPOName')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAInstitutionCSA.pdf'	

		union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'BIPOTitle' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'BIPOTitle')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAInstitutionCSA.pdf'	
	
		union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'BIPOAddress' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'BIPOAddress')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAInstitutionCSA.pdf'	

		union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'BIPOPhone' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'BIPOPhone')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAInstitutionCSA.pdf'	

			union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'BIPOEmail' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'BIPOEmail')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAInstitutionCSA.pdf'

	union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'speaker_phone' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'ConsultantPhone')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAInstitutionCSA.pdf'	

			union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'email' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'ConsultantEmail')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAInstitutionCSA.pdf'
	
			union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'disease' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'disease')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAInstitutionCSA.pdf'	

			union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'department' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'department')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAInstitutionCSA.pdf'
  
				union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'scope' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'ScopeofService')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAInstitutionCSA.pdf'
	
				union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'compensation' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'ActivityCompensation')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAInstitutionCSA.pdf'
	
				union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'hours' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'ActivityHours')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAInstitutionCSA.pdf'
	
				union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'travelcompensation' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'TravelCompensation')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAInstitutionCSA.pdf'
	
				union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'feetotal' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'FeeTotal')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAInstitutionCSA.pdf'

					union select ' as atm where atm.Contract_Type = (select atc.Contract_Type from dbo.AlphaTrust_Contracts atc where atc.Contract_Description = ''BNA'') and atm.SOI_ID ' as Constr,  'dbo' as sch, 'AlphaTrust_Merge' as tabl, 'incidentals' as Field,
					(select umd.ID from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where atc.AlphaTrustContractName = 'BNA' and umd.FieldName = 'Incidentals')  as UiFieldID, cd.ID 
	from bur.ContractDetail cd join bur.AlphaTrustContract atc on atc.ID = cd.ContractID join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID where atc.AlphaTrustContractName = 'BNA' and atp.PdfFileName = 'BNAInstitutionCSA.pdf'	

) as src
	on 	src.UiFieldID = trg.UiFieldID and src.Field = trg.ATField
		when not matched by target then insert(Constr, ATScheme, ATTable, ATField, UiFieldID, ContractDetailID)
			values(src.Constr, src.sch, src.tabl, src.Field, src.UiFieldID, src.ID);
go

merge bur.ContractFieldDetail trg
using
(
			select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Signer2Name' and atp.PdfFileName = 'BNAIndividualCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'Signer2Name'   and atc.AlphaTrustContractName ='BNA'

	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Signer2' and atp.PdfFileName = 'BNAIndividualCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'Signer2'   and atc.AlphaTrustContractName ='BNA'
 
	union	select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Signer2Title' and atp.PdfFileName = 'BNAIndividualCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'Signer2Title'   and atc.AlphaTrustContractName ='BNA'

	union	select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'FullName' and atp.PdfFileName = 'BNAIndividualCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'FullName'   and atc.AlphaTrustContractName ='BNA'

	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Address' and atp.PdfFileName = 'BNAIndividualCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'speaker_address'   and atc.AlphaTrustContractName ='BNA'

	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'CityStateZip' and atp.PdfFileName = 'BNAIndividualCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'CityStateZip'   and atc.AlphaTrustContractName ='BNA'
	
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Date' and atp.PdfFileName = 'BNAIndividualCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'Date'   and atc.AlphaTrustContractName ='BNA'
				
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'BIPOName' and atp.PdfFileName = 'BNAIndividualCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'BIPOName'   and atc.AlphaTrustContractName ='BNA'

	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'BIPOTitle' and atp.PdfFileName = 'BNAIndividualCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'BIPOTitle'   and atc.AlphaTrustContractName ='BNA'
				
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'BIPOAddress' and atp.PdfFileName = 'BNAIndividualCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'BIPOAddress'   and atc.AlphaTrustContractName ='BNA'
		
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'BIPOPhone' and atp.PdfFileName = 'BNAIndividualCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'BIPOPhone'   and atc.AlphaTrustContractName ='BNA'

	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'BIPOEmail' and atp.PdfFileName = 'BNAIndividualCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'BIPOEmail'   and atc.AlphaTrustContractName ='BNA'
		-------------------------------------------------------------------------------------temp----------------------------------------------------------------------------------------
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'ConsultantPhone' and atp.PdfFileName = 'BNAIndividualCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'ConsultantPhone'   and atc.AlphaTrustContractName ='BNA'

union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'ConsultantEmail' and atp.PdfFileName = 'BNAIndividualCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'ConsultantEmail'   and atc.AlphaTrustContractName ='BNA'


	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'disease' and atp.PdfFileName = 'BNAIndividualCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'disease'   and atc.AlphaTrustContractName ='BNA'

		
		union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'department' and atp.PdfFileName = 'BNAIndividualCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'department'   and atc.AlphaTrustContractName ='BNA'
		
		
		union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'ScopeofService' and atp.PdfFileName = 'BNAIndividualCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'ScopeofService'   and atc.AlphaTrustContractName ='BNA'
-------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------
		union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'ActivityCompensation' and atp.PdfFileName = 'BNAIndividualCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'ActivityCompensation'   and atc.AlphaTrustContractName ='BNA'


		union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'ActivityHours' and atp.PdfFileName = 'BNAIndividualCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'ActivityHours'   and atc.AlphaTrustContractName ='BNA'

		
		union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'TravelCompensation' and atp.PdfFileName = 'BNAIndividualCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'TravelCompensation'   and atc.AlphaTrustContractName ='BNA'
		
		
		union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'FeeTotal' and atp.PdfFileName = 'BNAIndividualCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'FeeTotal'   and atc.AlphaTrustContractName ='BNA'

		union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Incidentals' and atp.PdfFileName = 'BNAIndividualCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'Incidentals'   and atc.AlphaTrustContractName ='BNA'
-------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------
		union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Signer1' and atp.PdfFileName = 'BNAIndividualCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'FullName'   and atc.AlphaTrustContractName ='BNA'
		
		
		
		union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Signer2Name' and atp.PdfFileName = 'BNAIndividualCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'Signer2Name'   and atc.AlphaTrustContractName ='BNA'
		
		union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Signer2Title' and atp.PdfFileName = 'BNAIndividualCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'Signer2Title'   and atc.AlphaTrustContractName ='BNA'

		union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Signer2Date' and atp.PdfFileName = 'BNAIndividualCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'Signer2Date'   and atc.AlphaTrustContractName ='BNA'

) as src 
	on src.PdfFieldID = trg.PdfFieldID and src.UiFieldID = trg.UiFieldID 
		when not matched by target then insert(PdfFieldID, UiFieldID)
			values(src.PdfFieldID, src.UiFieldID);

go

			merge bur.ContractFieldDetail trg
using
(
			select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'FullName' and atp.PdfFileName = 'BNAInstitutionCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'FullName'   and atc.AlphaTrustContractName ='BNA'

		union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Address' and atp.PdfFileName = 'BNAInstitutionCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'Address'   and atc.AlphaTrustContractName ='BNA'

	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'CityStateZip' and atp.PdfFileName = 'BNAInstitutionCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'CityStateZip'   and atc.AlphaTrustContractName ='BNA'
	
	
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Date' and atp.PdfFileName = 'BNAInstitutionCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'Date'   and atc.AlphaTrustContractName ='BNA'
				
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'BIPOName' and atp.PdfFileName = 'BNAInstitutionCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'BIPOName'   and atc.AlphaTrustContractName ='BNA'

	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'BIPOTitle' and atp.PdfFileName = 'BNAInstitutionCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'BIPOTitle'   and atc.AlphaTrustContractName ='BNA'
				
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'BIPOAddress' and atp.PdfFileName = 'BNAInstitutionCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'BIPOAddress'   and atc.AlphaTrustContractName ='BNA'
		
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'BIPOPhone' and atp.PdfFileName = 'BNAInstitutionCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'BIPOPhone'   and atc.AlphaTrustContractName ='BNA'

	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'ConsultantAddress' and atp.PdfFileName = 'BNAInstitutionCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'ConsultantAddress'   and atc.AlphaTrustContractName ='BNA'

	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'BIPOEmail' and atp.PdfFileName = 'BNAInstitutionCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'BIPOEmail'   and atc.AlphaTrustContractName ='BNA'
		-------------------------------------------------------------------------------------temp----------------------------------------------------------------------------------------
	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'ConsultantPhone' and atp.PdfFileName = 'BNAInstitutionCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'ConsultantPhone'   and atc.AlphaTrustContractName ='BNA'

union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'ConsultantEmail' and atp.PdfFileName = 'BNAInstitutionCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'ConsultantEmail'   and atc.AlphaTrustContractName ='BNA'


	union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'disease' and atp.PdfFileName = 'BNAInstitutionCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'disease'   and atc.AlphaTrustContractName ='BNA'

		
		union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'department' and atp.PdfFileName = 'BNAInstitutionCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'department'   and atc.AlphaTrustContractName ='BNA'
		
		
		union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'ScopeofService' and atp.PdfFileName = 'BNAInstitutionCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'ScopeofService'   and atc.AlphaTrustContractName ='BNA'
-------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------
		union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'ActivityCompensation' and atp.PdfFileName = 'BNAInstitutionCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'ActivityCompensation'   and atc.AlphaTrustContractName ='BNA'


		union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'ActivityHours' and atp.PdfFileName = 'BNAInstitutionCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'ActivityHours'   and atc.AlphaTrustContractName ='BNA'

		
		union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'TravelCompensation' and atp.PdfFileName = 'BNAInstitutionCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'TravelCompensation'   and atc.AlphaTrustContractName ='BNA'
		
		
		union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'FeeTotal' and atp.PdfFileName = 'BNAInstitutionCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'FeeTotal'   and atc.AlphaTrustContractName ='BNA'

		union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Incidentals' and atp.PdfFileName = 'BNAInstitutionCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'Incidentals'   and atc.AlphaTrustContractName ='BNA'
-------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------
		union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Signer1' and atp.PdfFileName = 'BNAInstitutionCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'FullName'   and atc.AlphaTrustContractName ='BNA'

		--union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Signer1Date' and atp.PdfFileName = 'BNAInstitutionCSA.pdf') as PdfFieldID,
		--umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'Signer1Date'   and atc.AlphaTrustContractName ='BNA'
		
		union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Signer2' and atp.PdfFileName = 'BNAInstitutionCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'Signer2'   and atc.AlphaTrustContractName ='BNA'

		union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Signer2Name' and atp.PdfFileName = 'BNAInstitutionCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'Signer2Name'   and atc.AlphaTrustContractName ='BNA'

		union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Signer2Title' and atp.PdfFileName = 'BNAInstitutionCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'Signer2Title'   and atc.AlphaTrustContractName ='BNA'

		union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Signer2Date' and atp.PdfFileName = 'BNAInstitutionCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'Signer2Date'   and atc.AlphaTrustContractName ='BNA'

		union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Signer3' and atp.PdfFileName = 'BNAInstitutionCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'FullName'   and atc.AlphaTrustContractName ='BNA'

-------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------
		union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'CompanyConsultant' and atp.PdfFileName = 'BNAInstitutionCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'FullName'   and atc.AlphaTrustContractName ='BNA'

		union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'CompanyConsultant' and atp.PdfFileName = 'BNAInstitutionCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'InstitutionName'   and atc.AlphaTrustContractName ='BNA'

		union select (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'InstitutionName' and atp.PdfFileName = 'BNAInstitutionCSA.pdf') as PdfFieldID,
		umd.ID as UiFieldID 	from bur.UiMergeDictionary umd join bur.AlphaTrustContract atc on atc.ID = umd.ContractID where     umd.FieldName =		'InstitutionName'   and atc.AlphaTrustContractName ='BNA'
				
) as src 
	on src.PdfFieldID = trg.PdfFieldID and src.UiFieldID = trg.UiFieldID 
		when not matched by target then insert(PdfFieldID, UiFieldID)
			values(src.PdfFieldID, src.UiFieldID);