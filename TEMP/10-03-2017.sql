select * from bur.ATContractMergeField
select * from bur.ATUserContract
select * from bur.ATDocumentDetail

select * from dbo.AlphaTrust_Merge atm where atm.SOI_ID = 3552868
select * from dbo.AlphaTrust_Contracts

update dbo.AlphaTrust_Merge set Signer2Name = 'TestSigner2Name', Signer2Title ='TestSigner2Title' where id in (34763,34764,34765,34766,34767,34768,34769,34770,34771,34772,34773,34774,34778,34779)



select * from bur.AlphaTrustContract
select * from bur.AlphaTrustPdf
select * from p


select * from bur.ATDocumentDetail

--delete from bur.ATDocumentDetail where UserContractID in (81, 83)
delete from bur.ATUserContract where ContractID in (9, 5)
select * from bur.UiMergeDictionary umd where umd.ID = 120
select * from bur.

EXEC bur.MergeUIFieldValue 2727747,9,'Date','10 October 2017'


select * from bur.ContractFieldDetail where PdfFieldID = 226


delete from bur.ContractFieldDetail where PdfFieldID = (select pmd.ID from bur.PdfMergeDictionary pmd	 join bur.AlphaTrustPdf atp on atp.ID = pmd.PdfID where pmd.PdfFieldName = 'Signer1Date' and atp.PdfFileName = 'BNAInstitutionCSA.pdf') 







-------------------------------------------------------------------------------------SP----------------------------------------------------------------------------------------
exec bur.MergeConsultContract 3826833, 4
exec bur.MergeATContractFiled 'EFE6B9AC-A097-4CB9-ABF9-AF7A1E40CCE5'	 6813C6A1-2497-4447-8383-73EF79C64CDD
exec [bur].[GetPdfFileNameATSpeakerContractFieldByGuid] @Guid = 'EFE6B9AC-A097-4CB9-ABF9-AF7A1E40CCE5' 
exec bur.GetPdfFieldNameValueContractNameTypeByGUID 'EFE6B9AC-A097-4CB9-ABF9-AF7A1E40CCE5'	

select * from bur.LookupValues





