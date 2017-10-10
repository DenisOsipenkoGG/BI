-------------------------------------------------------------------------------------BIDEV_Offshore----------------------------------------------------------------------------------------cm
use BIDEV_Offshore;
go


if not exists (select 1 from sys.schemas where name = 'bur')
	exec('create schema bur');
go


-------------------------------------------------------------------------------------Lookups----------------------------------------------------------------------------------------
if not exists(select 1 from INFORMATION_SCHEMA.TABLES t where t.TABLE_SCHEMA='bur' and t.TABLE_NAME='Lookups')
create table bur.Lookups
(
	ID int identity(1,1) not null
	, Name varchar(200) not null unique


	, DateCreated datetime2 not null constraint DF_bur_Lookups_DateCreated default getdate()
	, DateModified datetime2 not null constraint DF_bur_Lookups_DateModified default getdate()
	, CreatedBy int not null constraint DF_bur_Lookups_CreatedBy default(-1)
	, ModifiedBy int not null constraint DF_bur_Lookups_MofidiedBy default(-1)
	, isDeleted bit not null constraint DF_bur_Lookups_isDeleted default(0)
	, ExternalID nvarchar(255) null
	, SourceID nvarchar(255) null

	, constraint PK_bur_Lookups_ID primary key clustered (ID) 	
);
go

-------------------------------------------------------------------------------------LookupValues----------------------------------------------------------------------------------------
if not exists(select 1 from INFORMATION_SCHEMA.TABLES t where t.TABLE_SCHEMA='bur' and t.TABLE_NAME='LookupValues')
create table bur.LookupValues
(
	ID int identity(1,1) not null
	, LookupID int not null
	, Value varchar(250) not null
	, Description varchar(500) null

	, DateCreated datetime2 not null constraint DF_bur_LookupValues_DateCreated default getdate()
	, DateModified datetime2 not null constraint DF_bur_LookupValues_DateModified default getdate()
	, CreatedBy int not null constraint DF_bur_LookupValues_CreatedBy default(-1)
	, ModifiedBy int not null constraint DF_bur_LookupValues_MofidiedBy default(-1)
	, isDeleted bit not null constraint DF_bur_LookupValues_isDeleted default(0)
	, ExternalID nvarchar(255) null
	, SourceID nvarchar(255) null

	, constraint FK_bur_LookupValues_LookupID foreign key(LookupID) references bur.Lookups(ID)
	, constraint PK_bur_LookupValues_ID primary key clustered(ID)	
);
go


-------------------------------------------------------------------------------------AlphaTrastContract----------------------------------------------------------------------------------------
if not exists(select 1 from INFORMATION_SCHEMA.TABLES t where t.TABLE_SCHEMA='bur' and t.TABLE_NAME='AlphaTrustContract')
create table bur.AlphaTrustContract
(
	ID int identity(1,1) not null 
	, AlphaTrustContractName varchar(150) not null
	, Year int null
	, DateFrom date null 
	, DateTo date	null
	, ContractTypeID int not null
	, isRequired bit not null constraint DF_bur_AlphaTrustContract_isRequired default(1)

	, DateCreated datetime2 not null constraint DF_bur_AlphaTrustContract_DateCreated default getdate()
	, DateModified datetime2 not null constraint DF_bur_AlphaTrustContract_DateModified default getdate()
	, CreatedBy int not null constraint DF_bur_AlphaTrustContract_CreatedBy default(-1)
	, ModifiedBy int not null constraint DF_bur_AlphaTrustContract_MofidiedBy default(-1)
	, isDeleted bit not null constraint DF_bur_AlphaTrustContract_isDeleted default(0)
	, isActive bit not null constraint Df_bur_AlphaTrustContract_isActive default(1)
	, ExternalID nvarchar(255) null
	, SourceID nvarchar(255) null


	, constraint PK_bur_AlphaTrustContract_ID primary key clustered (ID)	
);
go


-------------------------------------------------------------------------------------AlphaTrustPdf----------------------------------------------------------------------------------------
if not exists(select 1 from INFORMATION_SCHEMA.TABLES t where t.TABLE_SCHEMA='bur' and t.TABLE_NAME='AlphaTrustPdf')
create table bur.AlphaTrustPdf
(
		ID int identity(1,1) not null
	, PdfFileName varchar(250)
	, PdfLinkID int null
	, DataTypeID int not null
	

	, DateCreated datetime2 not null constraint DF_bur_AlphaTrustPdf_DateCreated default getdate()
	, DateModified datetime2 not null constraint DF_bur_AlphaTrustPdf_DateModified default getdate()
	, CreatedBy int not null constraint DF_bur_AlphaTrustPdf_CreatedBy default(-1)
	, ModifiedBy int not null constraint DF_bur_AlphaTrustPdf_MofidiedBy default(-1)
	, isDeleted bit not null constraint DF_bur_AlphaTrustPdf_isDeleted default(0)
	, ExternalID nvarchar(255) null
	, SourceID nvarchar(255) null

	, constraint FK_bur_AlphaTrustPdf_DataTypeID foreign key(DataTypeID) references bur.LookupValues(ID)
	, constraint PK_bur_AlphaTrustPdf_ID primary key clustered (ID) 
);
go

-------------------------------------------------------------------------------------ContractDetail----------------------------------------------------------------------------------------
if not exists(select 1 from INFORMATION_SCHEMA.TABLES t where t.TABLE_SCHEMA='bur' and t.TABLE_NAME='ContractDetail')
create table bur.ContractDetail
(
	ID int identity(1,1) not null
	, ContractID int not null
	, AlphaTrustPdfID int not null
	
	
	, DateCreated datetime2 not null constraint DF_bur_ContractDetail_DateCreated default getdate()
	, DateModified datetime2 not null constraint DF_bur_ContractDetail_DateModified default getdate()
	, CreatedBy int not null constraint DF_bur_ContractDetail_CreatedBy default(-1)
	, ModifiedBy int not null constraint DF_bur_ContractDetail_MofidiedBy default(-1)
	, isDeleted bit not null constraint DF_bur_ContractDetail_isDeleted default(0)
	, ExternalID nvarchar(255) null
	, SourceID nvarchar(255) null

	, constraint PK_bur_ContractDetail_ID primary key clustered (ID)	
	, constraint FK_bur_ContractDetail_ContractID foreign key(ContractID) references bur.AlphaTrustContract(ID)
	, constraint FK_bur_ContractDetail_PdfDictionaryID foreign key(AlphaTrustPdfID) references  bur.AlphaTrustPdf(ID)
);
go




-------------------------------------------------------------------------------------PdfMergeDictionary----------------------------------------------------------------------------------------
if not exists(select 1 from INFORMATION_SCHEMA.TABLES t where t.TABLE_SCHEMA='bur' and t.TABLE_NAME='PdfMergeDictionary')
create table bur.PdfMergeDictionary
(
	ID int identity(1,1) not null
	, PdfFieldName varchar(150) not null
	, PdfID int not null
	, Formula varchar(50) null
	
	, DateCreated datetime2 not null constraint DF_bur_PdfMergeDictionary_DateCreated default getdate()
	, DateModified datetime2 not null constraint DF_bur_PdfMergeDictionary_DateModified default getdate()
	, CreatedBy int not null constraint DF_bur_PdfMergeDictionary_CreatedBy default(-1)
	, ModifiedBy int not null constraint DF_bur_PdfMergeDictionary_MofidiedBy default(-1)
	, isDeleted bit not null constraint DF_bur_PdfMergeDictionary_isDeleted default(0)
	, ExternalID nvarchar(255) null
	, SourceID nvarchar(255) null

	, constraint PK_bur_PdfMergeDictionary_ID primary key clustered (ID)
	, constraint FK_bur_PdfMergeDictionary_PdfFileNameID foreign key(PdfID) references bur.AlphaTrustPdf(ID)	
);
go

-------------------------------------------------------------------------------------UiMergeDictionary----------------------------------------------------------------------------------------
if not exists(select 1 from INFORMATION_SCHEMA.TABLES t where t.TABLE_SCHEMA='bur' and t.TABLE_NAME='UiMergeDictionary')
create table bur.UiMergeDictionary
(
	ID int identity(1,1) not null
	, FieldName varchar(250) not null
	, ContractID int not null
	
	, FieldType int null
	, FieldRefId int null

	, DateCreated datetime2 not null constraint DF_bur_UiMergeDictionary_DateCreated default getdate()
	, DateModified datetime2 not null constraint DF_bur_UiMergeDictionary_DateModified default getdate()
	, CreatedBy int not null constraint DF_bur_UiMergeDictionary_CreatedBy default(-1)
	, ModifiedBy int not null constraint DF_bur_UiMergeDictionary_MofidiedBy default(-1)
	, isDeleted bit not null constraint DF_bur_UiMergeDictionary_isDeleted default(0)
	, ExternalID nvarchar(255) null
	, SourceID nvarchar(255) null

	, constraint PK_bur_UiMergeDictionary_ID primary key clustered (ID) 
	, constraint FK_bur_Contract_ContractID foreign key(ContractID) references bur.AlphaTrustContract(ID)
);
go
-------------------------------------------------------------------------------------ContractFieldDetail----------------------------------------------------------------------------------------
if not exists(select 1 from INFORMATION_SCHEMA.TABLES t where t.TABLE_SCHEMA='bur' and t.TABLE_NAME='ContractFieldDetail')
create table bur.ContractFieldDetail
(
	ID int identity(1,1) not null
	,	PdfFieldID int not null
	, UiFieldID int not null
	, OrderKey int null

	, DateCreated datetime2 not null constraint DF_bur_ContractFieldDetail_DateCreated default getdate()
	, DateModified datetime2 not null constraint DF_bur_ContractFieldDetail_DateModified default getdate()
	, CreatedBy int not null constraint DF_bur_ContractFieldDetail_CreatedBy default(-1)
	, ModifiedBy int not null constraint DF_bur_ContractFieldDetail_MofidiedBy default(-1)
	, isDeleted bit not null constraint DF_bur_ContractFieldDetail_isDeleted default(0)
	, ExternalID nvarchar(255) null
	, SourceID nvarchar(255) null

	, constraint PK_bur_ContractFieldDetail_ID primary key clustered (ID) 
	, constraint FK_bur_ContractFieldDetail_PdfFieldID foreign key(PdfFieldID) references bur.PdfMergeDictionary(ID) 	
	, constraint FK_bur_ContractFieldDetail_UiFieldID foreign key(UiFieldID) references bur.UiMergeDictionary(ID)
);
go

-------------------------------------------------------------------------------------ATUserContract----------------------------------------------------------------------------------------
if not exists(select 1 from INFORMATION_SCHEMA.TABLES t where t.TABLE_SCHEMA='bur' and t.TABLE_NAME='ATUserContract')

create table bur.ATUserContract
(
	ID int identity(1,1) not null
	, ContractID int not null
	, UserID int not null
	, GUID uniqueidentifier constraint DF_bur_ATUserContract_GUID default newid()
	, ContractStatusID int not null

	, PandingURL varchar(max) null constraint DF_bur_ATUserContract_PandingURL default('')
	, CompletedURL varchar(max) null constraint DF_bur_ATUserContract_CompletedURL default('')
	, TransID int null

	, DateCreated datetime2 not null constraint DF_bur_ATUserContract_DateCreated default getdate()
	, DateModified datetime2 not null constraint DF_bur_ATUserContract_DateModified default getdate()
	, CreatedBy int not null constraint DF_bur_ATUserContract_CreatedBy default(-1)
	, ModifiedBy int not null constraint DF_bur_ATUserContract_MofidiedBy default(-1)
	, isDeleted bit not null constraint DF_bur_ATUserContract_isDeleted default(0)
	, ExternalID nvarchar(255) null
	, SourceID nvarchar(255) null


	, constraint FK_bur_ATUserContract_ContractStatusID foreign key(ContractStatusID) references bur.LookupValues(ID)	
	, constraint FK_dbo_ATUserContract_UserID foreign key(UserID) references dbo.SOI(SOI_ID) 
	, constraint FK_bur_ATUserContract_ContractID foreign key(ContractID) references bur.AlphaTrustContract(ID)
	, constraint PK_bur_ATUserContract_ID primary key clustered (ID) 
);
go

-------------------------------------------------------------------------------------ATDocumentDetail----------------------------------------------------------------------------------------
if not exists(select 1 from INFORMATION_SCHEMA.TABLES t where t.TABLE_SCHEMA='bur' and t.TABLE_NAME='ATDocumentDetail')
create table bur.ATDocumentDetail
(
	ID int identity(1,1) not null
	, ContractID int not null
	, UserContractID int not null
	, ATDocID int null
	, DocStatusID int null

	, DateCreated datetime2 not null constraint DF_bur_ATDocumentDetail_DateCreated default getdate()
	, DateModified datetime2 not null constraint DF_bur_ATDocumentDetail_DateModified default getdate()
	, CreatedBy int not null constraint DF_bur_ATDocumentDetail_CreatedBy default(-1)
	, ModifiedBy int not null constraint DF_bur_ATDocumentDetail_MofidiedBy default(-1)
	, isDeleted bit not null constraint DF_bur_ATDocumentDetail_isDeleted default(0)
	, ExternalID nvarchar(255) null
	, SourceID nvarchar(255) null


	, constraint FK_bur_ATDoumentDetail_UserContractID foreign key(UserContractID) references bur.ATUserContract(ID)
	, constraint FK_bur_ATDocumentDetail_ContractID foreign key(ContractID) references bur.AlphaTrustPdf(ID)
	, constraint PK_bur_ATDocumentDetail_ID primary key clustered (ID) 	
);
go



-------------------------------------------------------------------------------------ATMergeDictionary----------------------------------------------------------------------------------------
if not exists(select 1 from INFORMATION_SCHEMA.TABLES t where t.TABLE_SCHEMA='bur' and t.TABLE_NAME='MergeDictionary')
create table bur.MergeDictionary
(
	ID int identity(1,1) not null
	, ContractDetailID int not null
	, UiFieldID int not null
	, ATScheme varchar(10)
	, ATTable varchar(50)
	, ATField varchar(50)

	, DateCreated datetime2 not null constraint DF_bur_MergeDictionary_DateCreated default getdate()
	, DateModified datetime2 not null constraint DF_bur_MergeDictionary_DateModified default getdate()
	, CreatedBy int not null constraint DF_bur_MergeDictionary_CreatedBy default(-1)
	, ModifiedBy int not null constraint DF_bur_MergeDictionary_MofidiedBy default(-1)
	, isDeleted bit not null constraint DF_bur_MergeDictionary_isDeleted default(0)
	, ExternalID nvarchar(255) null
	, SourceID nvarchar(255) null

	, constraint FK_bur_MergeDictionary_UiFieldID foreign key(UiFieldID) references bur.UiMergeDictionary(ID)
	, constraint FK_bur_MergeDictionary_ContractDetailID foreign key(ContractDetailID) references bur.ContractDetail(ID)
	, constraint PK_bur_MergeDictionary_ID primary key clustered (ID) 	
);
go
-------------------------------------------------------------------------------------ATContractMergeField----------------------------------------------------------------------------------------
if not exists(select 1 from INFORMATION_SCHEMA.TABLES t where t.TABLE_SCHEMA='bur' and t.TABLE_NAME='ATContractMergeField')
create table bur.ATContractMergeField
(
	ID int identity(1,1) not null
	,	ATUserID int not null
	, UiMergeDictionaryID int not null
	, Value varchar(500) null
	 
	, DateCreated datetime2 not null constraint DF_bur_ATContractMergeField_DateCreated default getdate()
	, DateModified datetime2 not null constraint DF_bur_ATContractMergeField_DateModified default getdate()
	, CreatedBy int not null constraint DF_bur_ATContractMergeField_CreatedBy default(-1)
	, ModifiedBy int not null constraint DF_bur_ATContractMergeField_MofidiedBy default(-1)
	, isDeleted bit not null constraint DF_bur_ATContractMergeField_isDeleted default(0)
	, ExternalID nvarchar(255) null
	, SourceID nvarchar(255) null

	, constraint FK_bur_ATContractMergeField_UiMergeDictionaryID foreign key(UiMergeDictionaryID) references bur.UiMergeDictionary (ID)

	, constraint PK_bur_ATContractMergeField_ID primary key clustered (ID)
);
go
-------------------------------------------------------------------------------------UDT_HZ----------------------------------------------------------------------------------------
if exists (select 1 from sys.objects where object_id = object_id(N'[bur].[MergeTransIDPadingUrlByGUID]') and type in (N'P', N'PC'))
	drop procedure bur.MergeTransIDPadingUrlByGUID;
go
if exists (select 1 from sys.types t join sys.schemas s on s.schema_id = t.schema_id where s.name='bur' and t.name='HZList') 
	drop type bur.HZList;
go

if not exists (select 1 from sys.table_types tt where tt.name = 'HZList' and schema_name(tt.schema_id) = 'bur')
	create type bur.HZList as table
	(
			PdfID int
		, DocId	int
	);
go

-------------------------------------------------------------------------------------UDTSpeakeContract----------------------------------------------------------------------------------------
if exists (select 1 from sys.objects where object_id = object_id(N'[bur].[MergeSpeakerContractFields]') and type in (N'P', N'PC'))
	drop procedure bur.MergeSpeakerContractFields;
go
if exists (select 1 from sys.types t join sys.schemas s on s.schema_id = t.schema_id where s.name='bur' and t.name='ContractValueList') 
	drop type bur.ContractValueList;
go

if not exists (select 1 from sys.table_types tt where tt.name = 'ContractValueList' and schema_name(tt.schema_id) = 'bur')
	create type bur.ContractValueList as table
	(
			Id int
		, Value	varchar(200)
	);
go

-------------------------------------------------------------------------------------AlterPdfMergeDictionaryAddNewField----------------------------------------------------------------------------------------
 if not exists (select 1 from sys.columns c where object_id = object_id(N'[bur].[PdfMergeDictionary]') and c.name =N'PdfFieldTypeId' )
begin
	alter table bur.PdfMergeDictionary add 
			PdfFieldTypeId int constraint FK_bur_PdfMergeDictionary_PdfFieldTypeId foreign key references bur.LookupValues(ID); 		 
end;
go
-------------------------------------------------------------------------------------AlterATUserContract_Master----------------------------------------------------------------------------------------
 if not exists (select 1 from sys.columns c where object_id = object_id(N'[bur].[ATUserContract]') and c.name =N'Pass' )
begin
	alter table bur.ATUserContract add Pass varchar(200) null;	 
end;
go

-------------------------------------------------------------------------------------AtlterUiMergeDicitionary_UID----------------------------------------------------------------------------------------

 if not exists (select 1 from sys.columns c where object_id = object_id(N'[bur].[MergeDictionary]') and c.name =N'Constr' )
begin
	alter table bur.MergeDictionary add Constr varchar(max) not null;	 
end;
go

-------------------------------------------------------------------------------------Cosigner----------------------------------------------------------------------------------------
if not exists(select 1 from INFORMATION_SCHEMA.TABLES t where t.TABLE_SCHEMA='bur' and t.TABLE_NAME='ContractCosigner')
create table bur.ContractCosigner(
	ID int identity(1,1) not null,
	Username varchar(100) null,
	Password nvarchar(max) null,
	Email nvarchar(100) null,
	SignatureName varchar(255) null,
	LinkID int null constraint FK_bur_ContractCosigner_LinkID foreign key(LinkID) references bur.AlphaTrustContract(ID),
	DateCreated datetime2(7) not null constraint DF_bur_ContractCosigner_DateCreated  default (getdate()),
	DateModified datetime2(7) not null constraint DF_bur_ContractCosigner_DateModified  default (getdate()) ,
	CreatedBy int not null constraint DF_bur_ContractCosigner_CreatedBy  default ((-1)) ,
	ModifiedBy int not null constraint DF_bur_ContractCosigner_MofidiedBy  default ((-1)),
	isDeleted bit not null constraint DF_bur_ContractCosigner_isDeleted  default ((0)) ,
	ExternalID nvarchar(255) null,
	SourceID nvarchar(255) null,
	isDefault bit not null constraint DF_bur_ContractCosigner_isDefault  default ((0)),
 constraint PK_bur_ContractCosigner_ID primary key clustered 
(ID asc)
); 

go


-------------------------------------------------------------------------------------AddReqId----------------------------------------------------------------------------------------
 if not exists (select 1 from sys.columns c where object_id = object_id(N'[bur].[AlphaTrustContract]') and c.name =N'ReqID' )
begin
	alter table bur.AlphaTrustContract add ReqID int null constraint FK_bur_AlphaTrustContrac_ReqID foreign key(ReqID) references bur.AlphaTrustContract (ID);
	
end;
go
-------------------------------------------------------------------------------------DelConstraint----------------------------------------------------------------------------------------

if exists (select 1 from sys.foreign_keys f where f.name = 'FK_bur_ATContractMergeField_ATUserID')

alter table bur.ATContractMergeField drop constraint FK_bur_ATContractMergeField_ATUserID;
go


---TODO add corect types
-----------------------------------------------------------------------------------AddNewColumnToAplhaTrust_merge----------------------------------------------------------------------------------------
 if not exists (select 1 from sys.columns c where object_id = object_id(N'[dbo].[AlphaTrust_Merge]') and c.name =N'activity' )
begin
	alter table dbo.AlphaTrust_Merge add activity varchar(200) null;
	
end;

go
 if not exists (select 1 from sys.columns c where object_id = object_id(N'[dbo].[AlphaTrust_Merge]') and c.name =N'disease' )
begin
	alter table dbo.AlphaTrust_Merge add disease varchar(200) null;
	
end;
go

 if not exists (select 1 from sys.columns c where object_id = object_id(N'[dbo].[AlphaTrust_Merge]') and c.name =N'activityname' )
begin
	alter table dbo.AlphaTrust_Merge add activityname varchar(200) null;
	
end;

go
 if not exists (select 1 from sys.columns c where object_id = object_id(N'[dbo].[AlphaTrust_Merge]') and c.name =N'scope' )
begin
	alter table dbo.AlphaTrust_Merge add scope varchar(200) null;
	
end;
go

-------------------------------------------------------------------------------------BNA----------------------------------------------------------------------------------------

 if not exists (select 1 from sys.columns c where object_id = object_id(N'[dbo].[AlphaTrust_Merge]') and c.name =N'BIPOName' )
begin
	alter table dbo.AlphaTrust_Merge add BIPOName varchar(200) null;
	
end;
go
 if not exists (select 1 from sys.columns c where object_id = object_id(N'[dbo].[AlphaTrust_Merge]') and c.name =N'compensation' )
begin
	alter table dbo.AlphaTrust_Merge add compensation varchar(200) null;
	
end;
go
 if not exists (select 1 from sys.columns c where object_id = object_id(N'[dbo].[AlphaTrust_Merge]') and c.name =N'BIPOTitle' )
begin
	alter table dbo.AlphaTrust_Merge add BIPOTitle varchar(250) null;
	
end;
go

 if not exists (select 1 from sys.columns c where object_id = object_id(N'[dbo].[AlphaTrust_Merge]') and c.name =N'BIPOAddress' )
begin
	alter table dbo.AlphaTrust_Merge add BIPOAddress varchar(250) null;
	
end;
go
 if not exists (select 1 from sys.columns c where object_id = object_id(N'[dbo].[AlphaTrust_Merge]') and c.name =N'BIPOEmail' )
begin
	alter table dbo.AlphaTrust_Merge add BIPOEmail varchar(150) null;
	
end;
go
 if not exists (select 1 from sys.columns c where object_id = object_id(N'[dbo].[AlphaTrust_Merge]') and c.name =N'hours' )
begin
	alter table dbo.AlphaTrust_Merge add [hours] varchar(200) null; --?
	
end;
go

 if not exists (select 1 from sys.columns c where object_id = object_id(N'[dbo].[AlphaTrust_Merge]') and c.name =N'travelcompensation' )
begin
	alter table dbo.AlphaTrust_Merge add travelcompensation varchar(200) null; --?
	
end;
go


 if not exists (select 1 from sys.columns c where object_id = object_id(N'[dbo].[AlphaTrust_Merge]') and c.name =N'feetotal' )
begin
	alter table dbo.AlphaTrust_Merge add feetotal varchar(200) null; --?
	
end;
go

 if not exists (select 1 from sys.columns c where object_id = object_id(N'[dbo].[AlphaTrust_Merge]') and c.name =N'incidentals' )
begin
	alter table dbo.AlphaTrust_Merge add incidentals varchar(200) null; --?
	
end;
go

 if not exists (select 1 from sys.columns c where object_id = object_id(N'[dbo].[AlphaTrust_Merge]') and c.name =N'mediamessage' )
begin
	alter table dbo.AlphaTrust_Merge add mediamessage varchar(200) null; --?
	
end;
go

 if not exists (select 1 from sys.columns c where object_id = object_id(N'[dbo].[AlphaTrust_Merge]') and c.name =N'term' )
begin
	alter table dbo.AlphaTrust_Merge add term varchar(200) null; --?
	
end;
go

 if not exists (select 1 from sys.columns c where object_id = object_id(N'[dbo].[AlphaTrust_Merge]') and c.name =N'BIPOPhone' )
begin
	alter table dbo.AlphaTrust_Merge add BIPOPhone varchar(150) null;
	
end;

 if not exists (select 1 from sys.columns c where object_id = object_id(N'[dbo].[AlphaTrust_Merge]') and c.name =N'BIPOEmail' )
begin
	alter table dbo.AlphaTrust_Merge add BIPOEmail varchar(150) null;
	
end;
 if not exists (select 1 from sys.columns c where object_id = object_id(N'[dbo].[AlphaTrust_Merge]') and c.name =N'department' )
begin
	alter table dbo.AlphaTrust_Merge add department varchar(150) null;
	
end;

 if not exists (select 1 from sys.columns c where object_id = object_id(N'[dbo].[AlphaTrust_Merge]') and c.name =N'Signer2Name' )
begin
	alter table dbo.AlphaTrust_Merge add Signer2Name varchar(150) null;
	
end;

 if not exists (select 1 from sys.columns c where object_id = object_id(N'[dbo].[AlphaTrust_Merge]') and c.name =N'Signer2Title' )
begin
	alter table dbo.AlphaTrust_Merge add Signer2Title varchar(150) null;
	
end;





