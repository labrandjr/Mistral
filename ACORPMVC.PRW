#include "protheus.ch"
#include "fwmvcdef.ch"

/*/{Protheus.doc} ACORPMVC
Cte Active Corp via Integração Json (Modelo 3 - ZAM x ZAM)
@author Fabrica ERP.BR
@since 28/05/2024
@version 1.0
@return Nil, Função não tem retorno
/*/

User Function ACORPMVC()

Local oBrowse

oBrowse := FwMBrowse():New()
oBrowse:SetAlias("ZAM")
oBrowse:SetDescription("Cte Active Corp")
oBrowse:Activate()

Return

Static Function MenuDef()

Private aRotina := {}

ADD OPTION aRotina TITLE "Pesquisar"  ACTION "PesqBrw"			OPERATION 1 ACCESS 0
ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.ACORPMVC" OPERATION 2 ACCESS 0
//ADD OPTION aRotina TITLE "Incluir"    ACTION "VIEWDEF.ACORPMVC"	OPERATION 3 ACCESS 0
//ADD OPTION aRotina TITLE "Alterar"    ACTION "VIEWDEF.ACORPMVC" OPERATION 4 ACCESS 0
ADD OPTION aRotina TITLE "Excluir"    ACTION "VIEWDEF.ACORPMVC"	OPERATION 5 ACCESS 0

Return(aRotina)


Static Function ModelDef(oModel)

Local oStruCab  := FwFormStruct(1,"ZAM")
Local oStruZAN  := FwFormStruct(1,"ZAN")
Local aRelation := {}

oModel := MPFormModel():New("ACORPCTE",,,,)
oModel:AddFields("ZAMMASTER",/*cOwner*/,oStruCab)
oModel:SetPrimaryKey({"ZAM_FILIAL","ZAM_IDENT"} )
oModel:AddGrid("ZANDETAIL","ZAMMASTER",oStruZAN,/*bLinePre*/, /*bLinePost*/,/*bPre - Grid Inteiro*/,/*bPos - Grid Inteiro*/,/*bLoad - Carga do modelo manualmente*/)

aRelation := {{'ZAN_FILIAL','xFilial("ZAN")'},{'ZAN_IDENT','ZAM_IDENT'}}
oModel:SetRelation("ZANDETAIL", aRelation, ZAN->(IndexKey(1)))

oModel:SetPrimaryKey({})

oModel:SetDescription("Cte Active Corp")
oModel:GetModel("ZAMMASTER"):SetDescription("Cte")
oModel:GetModel("ZANDETAIL"):SetDescription("Documentos Fiscais")

Return(oModel)

Static Function ViewDef()

Local oView    := Nil
Local oModel   := FwLoadModel("ACORPMVC")
Local oStruCab := FwFormStruct(2,"ZAM")
Local oStruZAN := FwFormStruct(2,"ZAN")

oView := FWFormView():New()
oView:SetModel(oModel)

oView:AddField("VIEW_ZAM",oStruCab,"ZAMMASTER")
oView:AddGrid('VIEW_ZAN' ,oStruZAN,"ZANDETAIL")

oView:CreateHorizontalBox("CABEC",40)
oView:CreateHorizontalBox("GRID",60)

oView:SetOwnerView("VIEW_ZAM","CABEC")
oView:SetOwnerView("VIEW_ZAN","GRID")

oView:EnableTitleView("VIEW_ZAM","Cabeçalho - Cte")
oView:EnableTitleView("VIEW_ZAN","Grid - Documentos Fiscais")

oView:SetCloseOnOk({||.T.})

oStruZAN:RemoveField("ZAN_IDENT")

Return(oView)
