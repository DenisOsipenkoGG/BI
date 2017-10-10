--select * from bur.ATUserContract
-- =======================================================
-- sample						exec [bur].[GetPdfFileNameATSpeakerContractFieldByGuid] @Guid = 'A0F25AAC-B517-4F37-9436-0AA9C7D52998' 
-- modify date:    09/02/2017
-- author:          Denis Osipenko osipenko.denis@geekgroupllc.com
-- mod description: Get records from bur.AlphaTrustContract, bur.ATSpeackerContract
-- =======================================================
if exists (select 1 from sys.objects where object_id = object_id(N'[bur].[GetPdfFileNameATSpeakerContractFieldByGuid]') and type in (N'P', N'PC'))
	drop procedure bur.GetPdfFileNameATSpeakerContractFieldByGuid;
go


create procedure bur.GetPdfFileNameATSpeakerContractFieldByGuid
(
			@Guid varchar(max)
	  ,	@ActiveOnly bit = null

) as 
begin

	set nocount on;

			select distinct 
				atc.UserID as ATUserID
			,	atp.PdfFileName
			, atp.ID as PdfID
			, atp.DataTypeID as DataTypeID
			, (select atcc1.AlphaTrustContractName from bur.AlphaTrustContract atcc1
				join bur.Lookups l on l.Name = 'Contract Status Type'
				join bur.LookupValues lv on lv.LookupID = l.ID and lv.ID = atc.ContractStatusID and lv.Value <> 'Completed'
			 where atcc1.ID = atcc.ReqID ) as DependentContract
			, (select lv.Value from bur.LookupValues lv where atcc.ContractTypeID = lv.ID ) as ContractType
		from bur.ATUserContract as atc
		join bur.AlphaTrustContract atcc on atc.ContractID = atcc.ID
		join bur.ContractDetail cfd on atcc.ID = cfd.ContractID
		join bur.AlphaTrustPdf atp on atp.ID = cfd.AlphaTrustPdfID 
		where 1=1
			and	atc.GUID = convert(uniqueidentifier, @Guid) 
			and 1 = case 
								when isnull(@ActiveOnly, 0) = 0 then 1
								when atc.isDeleted = 0 then 1
								else 0
							end
end;
go

-------------------------------------------------------------------------------------GetPdfFieldName----------------------------------------------------------------------------------------
-- =======================================================
-- author:           Denis Osipenko 
-- sample            exec [bur].[GetPdfFieldName] @PdfFileNameID = 9
-- create date:      02/09/2017
-- =======================================================
if exists (select 1 from sys.objects where object_id = object_id(N'[bur].[GetPdfFieldName]') and type in (N'P', N'PC'))
	drop procedure bur.GetPdfFieldName;
go

create procedure bur.GetPdfFieldName
(
	@PdfFileNameID int = null	
) as 
begin

	set nocount on;

	
	select 
		  ct.ID as UIFieldID
			, pmd.PdfFieldName 
			, ct.FieldName as UIFieldName
		from bur.AlphaTrustPdf atp
		join	bur.PdfMergeDictionary pmd  on atp.ID = pmd.PdfID
		join bur.ContractFieldDetail pmdd on pmd.ID = pmdd.PdfFieldID
		left join bur.UiMergeDictionary ct on ct.ID = pmdd.UiFieldID
		where atp.ID = coalesce(@PdfFileNameID, atp.ID)

end;
go



-------------------------------------------------------------------------------------MergeContractStatusByDocStatus----------------------------------------------------------------------------------------
-- =======================================================
-- sample           exec bur.MergeContractStatusByDocStatus
-- modify date:     02/09/2017
-- author:          Denis Osipenko osipenko.denis@geekgroupllc.com
-- mod description  update ContractStatusID and CompletedUrl by DocStatus 
-- =======================================================
if exists (select 1 from sys.objects where object_id = object_id(N'[bur].[MergeContractStatusByDocStatus]') and type in (N'P', N'PC'))
	drop procedure bur.MergeContractStatusByDocStatus;
go

create procedure bur.MergeContractStatusByDocStatus
(
	  @TransID int
	, @DocStatus int 
	, @CompletedUrl varchar(255) = null
	,	@UserID int = -1		

) as 
begin

	set nocount on;
	declare @MerTab as table(DocStatusID int, CompletedURL varchar(500), ContractStatusID int)
	--begin tran
	--begin try
	merge into bur.ATUserContract as trg
	using
	(
	 select 
			@TransID as TransID 
		, @CompletedUrl as CompletedUrl
		, case
				when @DocStatus = 2 then (select c.ID from bur.LookupValues c where c.Value = 'Pending')
				when @DocStatus = 4 then (select c.ID from bur.LookupValues c where c.Value = 'Completed')
				when @DocStatus = 7 then (select c.ID from bur.LookupValues c where c.Value = 'Closed')
				when @DocStatus = 8 then (select c.ID from bur.LookupValues c where c.Value = 'Cancelled')
				when @DocStatus = 9 then (select c.ID from bur.LookupValues c where c.Value = 'Expired')
				when @DocStatus = 10 then (select c.ID from bur.LookupValues c where c.Value = 'Voided')
				else null
			end as ContractStatusID		
	) as src
	on src.TransID = trg.TransID
		when matched then update set 
				trg.CompletedURL = src.CompletedUrl
			, trg.ContractStatusID = src.ContractStatusID
			, trg.DateModified = getdate()
			, trg.ModifiedBy = @UserID	
	;
	--merge dbo.AlphaTrust_Merge trg
	--using
	--(
	--	select 
			
	--) as src
	--	on 
	--		when not matched by target then insert()
	--			values()
	--		when matched then update set
	--			;
	--go

	--commit tran
	--end try
	--begin catch
	--if @@trancount > 0
	--rollback transaction
	--throw;
	
	--end catch	
	end
go
-------------------------------------------------------------------------------------MergeTransIDPandignURLbyGuid----------------------------------------------------------------------------------------
-- =======================================================
-- sample           bur.MergeTransIDPadingUrlByGUID
-- modify date:     02/09/2017
-- author:          Denis Osipenko osipenko.denis@geekgroupllc.com
-- mod date					3/10/2017
-- mod description  Put pendingURL to AlphaTrust_Merge
-- =======================================================
if exists (select 1 from sys.objects where object_id = object_id(N'[bur].[MergeTransIDPadingUrlByGUID]') and type in (N'P', N'PC'))
	drop procedure bur.MergeTransIDPadingUrlByGUID;
go

create procedure bur.MergeTransIDPadingUrlByGUID
(
	  @GUID varchar(max)
	, @TransID int
	, @PendingURL varchar(max) 
	,	@UserID int = -1	
	, @PdfDocListId as bur.HZList readonly 

) as 
begin
	set nocount on;

	declare @ATSpeakerContractID as table(ID int, ContractID int, PdfID int, SOI_ID int, ContractName varchar(200))

  insert	 @ATSpeakerContractID (ID, PdfID, ContractID, SOI_ID, ContractName) select t.ID, atp.ID, atc.ID, t.UserID, atc.AlphaTrustContractName from  bur.ATUserContract t 
								 join bur.AlphaTrustContract atc on t.ContractID = atc.ID
								 join bur.ContractDetail cd on cd.ContractID = atc.ID
								 join bur.AlphaTrustPdf atp on atp.ID = cd.AlphaTrustPdfID  where t.GUID = convert(uniqueidentifier, @GUID)

	begin transaction
	begin try

		merge into bur.ATUserContract as trg
		using
		(	
			select @TransID as TransID, @PendingURL as PendingURL
		)
		as src
		on trg.GUID = convert( uniqueidentifier, @GUID)
			when  matched then update set trg.TransID = src.TransID, trg.PandingURL = src.PendingURL;

		merge into bur.ATDocumentDetail as trg
		using
		(
			select pdl.DocId DocID, atcd.ID, atcd.ContractID
			from @PdfDocListId pdl 
				join @ATSpeakerContractID atcd on pdl.PdfID = atcd.PdfID
		)
		as src
		on trg.UserContractID = src.ID and trg.ContractID = src.ContractID
		when matched then update set trg.ATDocID = src.DocID;

		--merge dbo.AlphaTrust_Merge trg
		--using
		--(
		--	select (select atcc.Contract_Type from dbo.AlphaTrust_Contracts atcc where atcc.Contract_Description =  atc.ContractName) as ContractID, @PendingURL as PendingURL, atc.SOI_ID as UserID  from @ATSpeakerContractID atc
				
		--) as src
		--	on trg.Contract_Type = src.ContractID and trg.SOI_ID = src.UserID
		--		when matched then update set trg.sign_url = src.PendingURL
		--			;
 commit transaction
	end try
	begin catch
		if @@trancount > 0
		rollback transaction;

	end catch
end;
go


--select * from bur.ATContractMergeField
--select * from bur.ATUserContract

-------------------------------------------------------------------------------------GetPdfFildNameValueContractNameTypeByGUID----------------------------------------------------------------------------------------
-- =======================================================
-- Example 			exec bur.GetPdfFieldNameValueContractNameTypeByGUID '3DB28F19-A4C4-4E99-A91C-5253C95FBD45'	  	
-- Date:				9/2/2017
-- Author:      Denis Osipenko osipenko.denis@geekgroupllc.com
-- Description  
-- =======================================================

if exists (select 1 from sys.objects where object_id = object_id(N'[bur].[GetPdfFieldNameValueContractNameTypeByGUID]') and type in (N'P', N'PC'))
	begin	
	drop procedure bur.GetPdfFieldNameValueContractNameTypeByGUID;
	end
go

create procedure [bur].[GetPdfFieldNameValueContractNameTypeByGUID]
(
		@GUID varchar(max) = null
) as 
begin

	set nocount on;

	declare @Pass varchar(150)
	declare @UserID int
	declare @ContractName varchar(150)
	select top 1  @UserID = atuc.UserID, @Pass = atuc.Pass, @ContractName = atc.AlphaTrustContractName 
 from bur.ATUserContract as atuc 
   
  join bur.ATContractMergeField atcmf on atuc.ID = atcmf.ATUserID 
  join bur.UiMergeDictionary umd on atcmf.UiMergeDictionaryID = umd.ID
  join bur.ContractFieldDetail cfd on cfd.UiFieldID = umd.ID
  join bur.PdfMergeDictionary pmd on pmd.ID = cfd.PdfFieldID 
  join bur.AlphaTrustPdf atpd on pmd.PdfID = atpd.ID
  join bur.ContractDetail cd on cd.AlphaTrustPdfID = atpd.ID
  join bur.AlphaTrustContract atc on atc.ID = cd.ContractID and atc.ID = atuc.ContractID
  join bur.LookupValues lv on atc.ContractTypeID = lv.ID
  join bur.LookupValues lvv on lvv.ID = pmd.PdfFieldTypeId
 where
		1 = 1
		and atuc.GUID = coalesce(convert(uniqueidentifier, @GUID), atuc.GUID)	
		and atuc.isDeleted = 0;


	select distinct pmd.PdfFieldName,

 stuff(
					( select distinct ', ' + atcmf1.Value 
							from   bur.ATContractMergeField  atcmf1
											join bur.ATUserContract auc on 	auc.ID = atcmf1.ATUserID
											join bur.UiMergeDictionary umd1 on atcmf1.UiMergeDictionaryID = umd1.ID
											join bur.ContractFieldDetail cfd1 on cfd1.UiFieldID = umd1.ID
								where cfd1.PdfFieldID = cfd.PdfFieldID and auc.GUID = coalesce(convert(uniqueidentifier, @GUID), atuc.GUID)	
							
							for xml path('') ), 1, 2,'') as Value, atc.AlphaTrustContractName, atuc.UserID, lv.Value ContractType, atpd.PdfFileName, lvv.Value PdfFieldType, atuc.Pass as Password, atpd.ID as PdfID
 from bur.ATUserContract as atuc 
  
  join bur.ATContractMergeField atcmf on atuc.ID = atcmf.ATUserID 
  join bur.UiMergeDictionary umd on atcmf.UiMergeDictionaryID = umd.ID
  join bur.ContractFieldDetail cfd on cfd.UiFieldID = umd.ID
  join bur.PdfMergeDictionary pmd on pmd.ID = cfd.PdfFieldID
  join bur.AlphaTrustPdf atpd on pmd.PdfID = atpd.ID
  join bur.ContractDetail cd on cd.AlphaTrustPdfID = atpd.ID
  join bur.AlphaTrustContract atc on atc.ID = cd.ContractID and atc.ID = atuc.ContractID
  join bur.LookupValues lv on atc.ContractTypeID = lv.ID
  join bur.LookupValues lvv on lvv.ID = pmd.PdfFieldTypeId
 where
		1 = 1
		and atuc.GUID = coalesce(convert(uniqueidentifier, @GUID), atuc.GUID)	
		and atuc.isDeleted = 0
	union 
	select pdm.PdfFieldName, convert (varchar(150), pdm.PdfFieldName) as Value ,  at.AlphaTrustContractName,@UserID,  lv.Value ContractType , atp.PdfFileName , l.Value as PdfFieldType , @Pass 	, pdm.PdfID	
	from bur.ATUserContract atc join bur.AlphaTrustContract at on atc.ContractID = at.ID
	join bur.ContractDetail cd on cd.ContractID = at.ID
	join bur.AlphaTrustPdf atp on atp.ID =cd.AlphaTrustPdfID
	join bur.PdfMergeDictionary pdm on pdm.PdfID = atp.ID
	join bur.LookupValues lv on lv.ID = at.ContractTypeID
	join bur.LookupValues l on l.ID = pdm.PdfFieldTypeId
	where pdm.ID not in (select cfdd.PdfFieldID from bur.ContractFieldDetail cfdd)
	and at.AlphaTrustContractName = @ContractName
end;
go
-------------------------------------------------------------------------------------GetKeyDescriptionByCategory----------------------------------------------------------------------------------------

-- =======================================================
-- Example 				exec bur.GetKeyDescriptionByCategory 	
-- Date:					9/3/2017
-- Author:        Denis Osipenko osipenko.denis@geekgroupllc.com
-- Description  
-- =======================================================
if exists (select 1 from sys.objects where object_id = object_id(N'[bur].[GetKeyDescriptionByCategory]') and type in (N'P', N'PC'))
	drop procedure bur.GetKeyDescriptionByCategory;
go

create procedure bur.GetKeyDescriptionByCategory
(
		@Category varchar(200) = null
	, @Key varchar(150) = null	

) as 
begin

	set nocount on;
	
	select lv.Value, lv.Description 
	from bur.LookupValues as lv 
			join bur.Lookups l on l.ID = lv.LookupID 
	where 
		1 = 1		
		and l.Name = coalesce(@Category, l.Name)
		and lv.Value = coalesce(@Key, lv.Value)	

end;
go

-------------------------------------------------------------------------------------MergeSpeakerContractFields----------------------------------------------------------------------------------------
-- =======================================================
-- sample           exec bur.MergeSpeakerContractFields
-- date:     02/09/2017
-- author:          Denis Osipenko osipenko.denis@geekgroupllc.com
-- description  
-- =======================================================
if exists (select 1 from sys.objects where object_id = object_id(N'[bur].[MergeSpeakerContractFields]') and type in (N'P', N'PC'))
	drop procedure bur.MergeSpeakerContractFields;
go

-- exec bur.MergeSpeakerContractFields

create procedure bur.MergeSpeakerContractFields
(
		@user int
	, @GUID varchar(max)
	, @FieldList as bur.ContractValueList readonly

) as 
begin

	set nocount on;

	declare @ATUserContractID int;

	select @ATUserContractID = c.ID
		from bur.ATUserContract c
		where 1=1
			and c.GUID = convert(uniqueidentifier, @GUID)
		
	
	merge into bur.ATContractMergeField as trg
	using
	(
		select @ATUserContractID as ATUserID
				,	f.Id as UiMergeDictionaryID
				, f.Value as Value
			from @FieldList f
	) as src
	on trg.ATUserID=src.ATUserID and trg.UiMergeDictionaryID=src.UiMergeDictionaryID
		when not matched by target then insert(ATUserID, UiMergeDictionaryID, Value, CreatedBy, ModifiedBy)
			values(src.ATUserID,src.UiMergeDictionaryID,src.Value, @user, @user);

end;
go
						 
-------------------------------------------------------------------------------------GetTransIDByGUID----------------------------------------------------------------------------------------
 -- =======================================================
-- sample           exec bur.GetTransIDByGUID
-- date:     02/09/2017
-- author:          Denis Osipenko osipenko.denis@geekgroupllc.com
-- description  
-- =======================================================
if exists (select 1 from sys.objects where object_id = object_id(N'[bur].[GetTransIDByGUID]') and type in (N'P', N'PC'))
	drop procedure bur.GetTransIDByGUID;
go
create procedure bur.GetTransIDByGUID
(

	 @GUID varchar(max)	= null

 ) as 
begin

	set nocount on;

	select c.TransID, c.UserID
		from bur.ATUserContract c
		where 1=1
			and c.GUID = coalesce( convert(uniqueidentifier, @GUID), c.GUID)

end;
go

-------------------------------------------------------------------------------------MergeATContractFiled----------------------------------------------------------------------------------------
-- =======================================================
-- Example 					exec bur.MergeATContractFiled 'A9326964-70C3-4D10-B7D4-73115DDB6F78'	 	
-- Date:						9/4/2017
-- Author:          Denis Osipenko osipenko.denis@geekgroupllc.com
-- Description  
-- =======================================================
if exists (select 1 from sys.objects where object_id = object_id(N'[bur].[MergeATContractFiled]') and type in (N'P', N'PC'))
	drop procedure bur.MergeATContractFiled;
go

create procedure bur.MergeATContractFiled
(
	 @GUID varchar(max) 
	

) as 
begin

	set nocount on;

	declare @ATUserID int;
	declare @ContractID int;
	declare @UserID int;
	select @UserID = atuc.UserID, @ATUserID = atuc.ID, @ContractID = atuc.ContractID from bur.ATUserContract as atuc where atuc.GUID = convert(uniqueidentifier, @GUID)
	--if(select top 1  1 from bur.AlphaTrustPdf atp join bur.ContractDetail cd on cd.AlphaTrustPdfID = atp.ID join bur.AlphaTrustContract atc on atc.ID bur.LookupValues lv on atp.DataTypeID = lv.ID  where  lv.Value = 'UI' ) = 1	 return;
	

	declare @TempTab as table(sch varchar(50), tabl varchar(50), field varchar(50), constr varchar(max), UiFieldID int)
	insert @TempTab
	(
	    sch
	  , tabl
	  , field
	  , constr
		, UiFieldID
	)select md.ATScheme, md.ATTable, md.ATField, md.Constr, md.UiFieldID 
	 from bur.MergeDictionary md 
		join bur.ContractDetail cd on cd.ID = md.ContractDetailID 
		join bur.AlphaTrustContract atc on atc.ID = cd.ContractID
		join bur.AlphaTrustPdf atp on cd.AlphaTrustPdfID = atp.ID 
	 where atc.ID = @ContractID -- and atp.PdfFileName = @PdfFileName  
	declare @SQL nvarchar(max);
	
	declare @SqlQer nvarchar(max)=''
	declare @tablesss as table(ValueV varchar(500), UiFieldID int not null)
	select @SqlQer = @SqlQer + ' union select ' + tt.field + ' as ValueV, ' + convert(varchar(100),tt.UiFieldID) + ' as UiFieldID' + ' from '+tt.sch+'.'+ tt.tabl + ' ' +  tt.constr + ' = ' + cast(@UserID as varchar(16))  from @TempTab tt
	set @SqlQer = stuff(@SqlQer, 1, 6, '')
		insert @tablesss
			(	 ValueV, UiFieldID )
			exec(@SqlQer)


	
	merge bur.ATContractMergeField trg
	using
	(
		select @ATUserID as UserLinkID, t.ValueV as Value, t.UiFieldID from  @tablesss	 t
			
	) as src
		on trg.UiMergeDictionaryID = src.UiFieldID and trg.ATUserID = @ATUserID 
			when not matched by target then insert(UiMergeDictionaryID, Value, ATUserID)
			values(src.UiFieldID, src.Value, @ATUserID);

end;
go

-------------------------------------------------------------------------------------CheckUserContract----------------------------------------------------------------------------------------
-- =======================================================
-- Example 					exec bur.CheckUserContractByID 6	
-- Date:						9/5/2017
-- Author:          Denis Osipenko osipenko.denis@geekgroupllc.com
-- Description  
-- =======================================================
if exists (select 1 from sys.objects where object_id = object_id(N'[bur].[CheckUserContractByID]') and type in (N'P', N'PC'))
	drop procedure bur.CheckUserContractByID;
go

create procedure bur.CheckUserContractByID
(
		@ConsultID int 
	, @ContractName varchar(200) = 'CDA'		
) as 
begin
	
	set nocount on;
			select 
		case when(
	select 1 from bur.ATUserContract atuc 
		join bur.AlphaTrustContract atc on atuc.ContractID = atc.ID 
		join dbo.SOI soi on soi.SOI_ID = atuc.UserID 
		join bur.LookupValues lv on atuc.ContractStatusID = lv.ID
	where 1 = 1 
		and atc.AlphaTrustContractName = @ContractName 
		and soi.SOI_ID = @ConsultID
		and lv.Value in ('Pending', 'Completed')
		) is not null then 1
		else 0
	 end;


end;
go
-------------------------------------------------------------------------------------GetCosignerByGuid----------------------------------------------------------------------------------------
-- =======================================================
-- Example 			exec bur.GetCosignerByGuid 	
-- Date:			9/6/2017
-- Author:          Denis Osipenko osipenko.denis@geekgroupllc.com
-- Description  
-- =======================================================
if exists (select 1 from sys.objects where object_id = object_id(N'[bur].[GetCosignerByGuid]') and type in (N'P', N'PC'))
	drop procedure bur.GetCosignerByGuid;
go

create procedure bur.GetCosignerByGuid
(
	
		@GUID varchar(max)
	, @TransID int = null
			, @isDeleted bit = 0
	

) as 
begin

	set nocount on;
declare @tmp as table (ID int)
declare @TempTab as table(ID int, Username varchar(200), Password varchar(200), Email varchar(200), SignatureName varchar(200), LinkID int)

insert into @TempTab
(ID, Username, Password, Email, SignatureName, LinkID)
	select	cc.ID
         , cc.Username
         , cc.Password
         , cc.Email
         , cc.SignatureName
         , cc.LinkID
          from bur.ATUserContract atuc 
						join bur.AlphaTrustContract atc on atc.id = atuc.ContractID
						join bur.ContractCosigner as cc on cc.LinkID = atc.ID
					where 
						1 = 1
						and atuc.GUID = coalesce(convert(uniqueidentifier, @GUID ), atuc.GUID)
						and atuc.isDeleted = coalesce(@isDeleted, 0)
						and 1 = case 
										 when @TransID = atuc.TransID  then 1 
										 when @TransID is not null then 0 
										 when atuc.TransID is null then 1 
										 else 1
												end	
	if exists( select 1 from @TempTab)
	(
		select top 1 
				tt.ID
			, tt.Username
			, tt.Password
			, tt.Email
			, tt.SignatureName
			, tt.LinkID from @TempTab tt)
	else
			(
			select top 1 cc.ID 
			, cc.Username
			, cc.Password
			, cc.Email
			, cc.SignatureName
			, cc.LinkID
			from bur.ContractCosigner cc 
			where 
				1 = 1
				and cc.isDefault = 1
				and	cc.Username = 'Default'
				and coalesce(cc.isDeleted, 0) = 0  )
	
end;
go


-------------------------------------------------------------------------------------MergeConsultContract----------------------------------------------------------------------------------------
-- =======================================================
-- Example 			exec bur.MergeConsultContract 	
-- Date:			9/6/2017
-- Author:          Denis Osipenko osipenko.denis@geekgroupllc.com
-- Description  
-- =======================================================
if exists (select 1 from sys.objects where object_id = object_id(N'[bur].[MergeConsultContract]') and type in (N'P', N'PC'))
	drop procedure bur.MergeConsultContract;
go

create procedure bur.MergeConsultContract
(
	@ConsultID int 
	, @ATContactID int 
	, @Password varchar(250) = null
	,		@userID	int = -1		

) as 
begin

	set nocount on;
	declare @TD as table(ID int );
	declare @ATPdfID as table (ID int);
	declare @ATUserID int;

begin tran
	begin try
	merge bur.ATUserContract trg
	using
	(
		select @ConsultID as UserID, @ATContactID as ContractID, @Password as Pass 
			
	) as src
		on 	trg.ContractID = src.ContractID and trg.UserID = src.UserID
			when not matched by target then insert(UserID, ContractID, Pass, CreatedBy, ModifiedBy, ContractStatusID)
				values(src.UserID, src.ContractID, src.Pass, @userID, @userID, (select lv.ID from bur.LookupValues lv join bur.Lookups l on lv.LookupID = l.ID where lv.Value = 'Pending' and l.Name ='Contract Status Type' ))
			output Inserted.ID into  @TD(ID);
			
		set @ATUserID = (select top 1 ID from @TD);
	
	
	insert @ATPdfID (ID) select atp.ID from bur.AlphaTrustPdf atp 
		join bur.ContractDetail cd on atp.ID = cd.AlphaTrustPdfID 
		join bur.AlphaTrustContract atc on atc.ID = cd.ContractID
		where  atc.ID = @ATContactID
		
		merge bur.ATDocumentDetail trg
		 using
		 (
		 	select @ATUserID as UserContractID, atpd.ID as ContractID from @ATPdfID atpd  
		 		
		 ) as src
		 	on 	src.UserContractID = trg.UserContractID and src.ContractID = trg.ContractID
		 		when not matched by target then insert(ContractID, UserContractID, CreatedBy, ModifiedBy) 
		 			values(src.ContractID, src.UserContractID, @userID, @userID );
		select atuc.GUID from bur.ATUserContract atuc join @TD t on t.ID = atuc.ID 
	commit tran
end try
begin catch
		if @@TRANCOUNT > 0
					rollback transaction;

			
end catch
end
go
-------------------------------------------------------------------------------------MergeUIFieldValue----------------------------------------------------------------------------------------
-- =======================================================
-- Example 					exec bur.MergeUIFieldValue 	
-- Date:						9/6/2017
-- Author:          Denis Osipenko osipenko.denis@geekgroupllc.com
-- Description  
-- =======================================================
if exists (select 1 from sys.objects where object_id = object_id(N'[bur].[MergeUIFieldValue]') and type in (N'P', N'PC'))
	drop procedure bur.MergeUIFieldValue;
go

create procedure bur.MergeUIFieldValue
(
		@userID int
	, @ContID int
	, @UIfieldName varchar(100)
  , @value varchar(max)
) as 
begin
	set nocount on;
  declare @UCID int;
begin tran;
  if exists(select 1 from bur.ATUserContract t where t.UserID=@userID and t.ContractID=@ContID)
		begin
		select @UCID = t.ID from bur.ATUserContract t where t.UserID=@userID and t.ContractID=@ContID
    merge bur.ATContractMergeField t using(select top 1 @UCID usid,umd.ID,@value val from bur.UiMergeDictionary umd where umd.ContractID=@ContID and umd.FieldName=@UIfieldName) s
    on ATUserID=usid and UiMergeDictionaryID=s.ID
    when not matched then insert (ATUserID, UiMergeDictionaryID, Value) values (usid,ID,val);
		end
commit;
end;
go













