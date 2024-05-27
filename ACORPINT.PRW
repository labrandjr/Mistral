#include "protheus.ch"
#include "restful.ch"

WSRESTFUL ACTIVE_CORP DESCRIPTION "Webservice Cte Active Corp" FORMAT APPLICATION_JSON
 
	WSMETHOD POST V1 DESCRIPTION "Inclusão Cte Active Corp" PATH "/V1" WSSYNTAX "/V1" TTALK "V1"

END WSRESTFUL

WSMETHOD POST V1 WSSERVICE ACTIVE_CORP

Local lRet     := .T.
Local cJson    := Lower(Self:GetContent())
Local oJson    := JsonObject():New()
Local oJsonRet := JsonObject():New()
Local lErrJson := .F.
Local cte,nfs

self:SetContentType( "application/json" )
oJson:FromJson(cJson)

For cte := 1 to Len(oJson["cte"])

	If Len(oJson["cte"][cte]["notafiscal"]) == 0
		lErrJson := .T.
		Exit
	Endif

	cIdentCte := Upper(PadR(oJson["cte"][cte]["identificador"],30))
	DbSelectArea("ZAM")
	DbSetOrder(1)
	If !DbSeek( xFilial("ZAM") + cIdentCte )
		RecLock("ZAM",.T.)
		ZAM->ZAM_FILIAL := xFilial("ZAM")
		ZAM->ZAM_IDENT  := cIdentCte
	Else
		RecLock("ZAM",.F.)
	Endif
	ZAM->ZAM_TCGC   := Upper(oJson["cte"][cte]["transportador"]["cnpjcpf"])
	ZAM->ZAM_TRAZAO := Upper(oJson["cte"][cte]["transportador"]["razaosocial"])
	ZAM->ZAM_TNREDU := Upper(oJson["cte"][cte]["transportador"]["fantasia"])
	ZAM->ZAM_TIE    := Upper(oJson["cte"][cte]["transportador"]["ie"])
	ZAM->ZAM_TCONTA := Upper(oJson["cte"][cte]["transportador"]["contato"])
	ZAM->ZAM_TFONE  := Upper(oJson["cte"][cte]["transportador"]["fone"])
	ZAM->ZAM_TCEP   := Upper(oJson["cte"][cte]["transportador"]["cep"])
	ZAM->ZAM_TEND   := Upper(oJson["cte"][cte]["transportador"]["endereco"])
	ZAM->ZAM_TNEND  := Upper(oJson["cte"][cte]["transportador"]["numero"])
	ZAM->ZAM_TCOMPL := Upper(oJson["cte"][cte]["transportador"]["complemento"])
	ZAM->ZAM_TBAIRR := Upper(oJson["cte"][cte]["transportador"]["bairro"])
	ZAM->ZAM_TIBGE  := Upper(oJson["cte"][cte]["transportador"]["ibge"])
	ZAM->ZAM_TREGIA := Upper(oJson["cte"][cte]["transportador"]["regiao"])
	ZAM->ZAM_TEST   := Upper(oJson["cte"][cte]["transportador"]["uf"])
	ZAM->ZAM_TMUN   := Upper(oJson["cte"][cte]["transportador"]["cidade"])
	ZAM->ZAM_RCGC   := Upper(oJson["cte"][cte]["remetente"]["cnpjcpf"])
	ZAM->ZAM_RRAZAO := Upper(oJson["cte"][cte]["remetente"]["razaosocial"])
	ZAM->ZAM_RNREDU := Upper(oJson["cte"][cte]["remetente"]["fantasia"])
	ZAM->ZAM_RIE    := Upper(oJson["cte"][cte]["remetente"]["ie"])
	ZAM->ZAM_RCONTA := Upper(oJson["cte"][cte]["remetente"]["contato"])
	ZAM->ZAM_RFONE  := Upper(oJson["cte"][cte]["remetente"]["fone"])
	ZAM->ZAM_RCEP   := Upper(oJson["cte"][cte]["remetente"]["cep"])
	ZAM->ZAM_REND   := Upper(oJson["cte"][cte]["remetente"]["endereco"])
	ZAM->ZAM_RNEND  := Upper(oJson["cte"][cte]["remetente"]["numero"])
	ZAM->ZAM_RCOMPL := Upper(oJson["cte"][cte]["remetente"]["complemento"])
	ZAM->ZAM_RBAIRR := Upper(oJson["cte"][cte]["remetente"]["bairro"])
	ZAM->ZAM_RIBGE  := Upper(oJson["cte"][cte]["remetente"]["ibge"])
	ZAM->ZAM_RREGIA := Upper(oJson["cte"][cte]["remetente"]["regiao"])
	ZAM->ZAM_REST   := Upper(oJson["cte"][cte]["remetente"]["uf"])
	ZAM->ZAM_RMUN   := Upper(oJson["cte"][cte]["remetente"]["cidade"])
	ZAM->ZAM_DCGC   := Upper(oJson["cte"][cte]["destinatario"]["cnpjcpf"])
	ZAM->ZAM_DRAZAO := Upper(oJson["cte"][cte]["destinatario"]["razaosocial"])
	ZAM->ZAM_DNREDU := Upper(oJson["cte"][cte]["destinatario"]["fantasia"])
	ZAM->ZAM_DIE    := Upper(oJson["cte"][cte]["destinatario"]["ie"])
	ZAM->ZAM_DCONTA := Upper(oJson["cte"][cte]["destinatario"]["contato"])
	ZAM->ZAM_DFONE  := Upper(oJson["cte"][cte]["destinatario"]["fone"])
	ZAM->ZAM_DCEP   := Upper(oJson["cte"][cte]["destinatario"]["cep"])
	ZAM->ZAM_DEND   := Upper(oJson["cte"][cte]["destinatario"]["endereco"])
	ZAM->ZAM_DNEND  := Upper(oJson["cte"][cte]["destinatario"]["numero"])
	ZAM->ZAM_DCOMPL := Upper(oJson["cte"][cte]["destinatario"]["complemento"])
	ZAM->ZAM_DBAIRR := Upper(oJson["cte"][cte]["destinatario"]["bairro"])
	ZAM->ZAM_DIBGE  := Upper(oJson["cte"][cte]["destinatario"]["ibge"])
	ZAM->ZAM_DREGIA := Upper(oJson["cte"][cte]["destinatario"]["regiao"])
	ZAM->ZAM_DEST   := Upper(oJson["cte"][cte]["destinatario"]["uf"])
	ZAM->ZAM_DMUN   := Upper(oJson["cte"][cte]["destinatario"]["cidade"])
	ZAM->ZAM_PCGC   := Upper(oJson["cte"][cte]["pagador"]["cnpjcpf"])
	ZAM->ZAM_PRAZAO := Upper(oJson["cte"][cte]["pagador"]["razaosocial"])
	ZAM->ZAM_PNREDU := Upper(oJson["cte"][cte]["pagador"]["fantasia"])
	ZAM->ZAM_PIE    := Upper(oJson["cte"][cte]["pagador"]["ie"])
	ZAM->ZAM_PCONTA := Upper(oJson["cte"][cte]["pagador"]["contato"])
	ZAM->ZAM_PFONE  := Upper(oJson["cte"][cte]["pagador"]["fone"])
	ZAM->ZAM_PCEP   := Upper(oJson["cte"][cte]["pagador"]["cep"])
	ZAM->ZAM_PEND   := Upper(oJson["cte"][cte]["pagador"]["endereco"])
	ZAM->ZAM_PNEND  := Upper(oJson["cte"][cte]["pagador"]["numero"])
	ZAM->ZAM_PCOMPL := Upper(oJson["cte"][cte]["pagador"]["complemento"])
	ZAM->ZAM_PBAIRR := Upper(oJson["cte"][cte]["pagador"]["bairro"])
	ZAM->ZAM_PIBGE  := Upper(oJson["cte"][cte]["pagador"]["ibge"])
	ZAM->ZAM_PREGIA := Upper(oJson["cte"][cte]["pagador"]["regiao"])
	ZAM->ZAM_PEST   := Upper(oJson["cte"][cte]["pagador"]["uf"])
	ZAM->ZAM_PMUN   := Upper(oJson["cte"][cte]["pagador"]["cidade"])
	ZAM->ZAM_NUMDOC := Upper(oJson["cte"][cte]["documento"]["numero"])
	ZAM->ZAM_SERIE  := Upper(oJson["cte"][cte]["documento"]["serie"])
	ZAM->ZAM_MODELO := Upper(oJson["cte"][cte]["documento"]["modelo"])
	ZAM->ZAM_TIPO  	:= Upper(oJson["cte"][cte]["documento"]["tipo"])
	ZAM->ZAM_EMISSA := Upper(oJson["cte"][cte]["documento"]["emissao"])
	ZAM->ZAM_CHAVE  := Upper(oJson["cte"][cte]["documento"]["chave"])
	ZAM->ZAM_AUTORI := Upper(oJson["cte"][cte]["documento"]["autorizado"])
	ZAM->ZAM_PROTOC := Upper(oJson["cte"][cte]["documento"]["protocolo"])
	ZAM->ZAM_CANCEL := Upper(oJson["cte"][cte]["documento"]["cancelamento"])
	ZAM->ZAM_CIENCI := Upper(oJson["cte"][cte]["documento"]["ciencia_cancelamento"])
	ZAM->ZAM_APROVA := Upper(oJson["cte"][cte]["documento"]["aprovacao"])
	ZAM->ZAM_OBS    := Upper(oJson["cte"][cte]["documento"]["observacao"])
	ZAM->ZAM_ORIBGE := Upper(oJson["cte"][cte]["origem"]["ibge"])
	ZAM->ZAM_ORREG  := Upper(oJson["cte"][cte]["origem"]["regiao"])
	ZAM->ZAM_OREST  := Upper(oJson["cte"][cte]["origem"]["uf"])
	ZAM->ZAM_ORMUN  := Upper(oJson["cte"][cte]["origem"]["cidade"])
	ZAM->ZAM_DSIBGE := Upper(oJson["cte"][cte]["destino"]["ibge"])
	ZAM->ZAM_DSREG  := Upper(oJson["cte"][cte]["destino"]["regiao"])
	ZAM->ZAM_DSEST  := Upper(oJson["cte"][cte]["destino"]["uf"])
	ZAM->ZAM_DSMUN  := Upper(oJson["cte"][cte]["destino"]["cidade"])
	ZAM->ZAM_QTDNF  := oJson["cte"][cte]["carga"]["quantidade_notas"]
	ZAM->ZAM_PESO   := oJson["cte"][cte]["carga"]["peso"]
	ZAM->ZAM_PESOCA := oJson["cte"][cte]["carga"]["pesocalculado"]
	ZAM->ZAM_M3     := oJson["cte"][cte]["carga"]["m3"]
	ZAM->ZAM_VOLUME := oJson["cte"][cte]["carga"]["volumes"]
	ZAM->ZAM_KM     := oJson["cte"][cte]["carga"]["km"]
	ZAM->ZAM_VALOR  := oJson["cte"][cte]["carga"]["valor"]
	ZAM->ZAM_MODNF  := Upper(oJson["cte"][cte]["prestacao"]["modelo_fiscal"])
	ZAM->ZAM_CFOP   := Upper(oJson["cte"][cte]["prestacao"]["cfop"])
	ZAM->ZAM_VPREST := oJson["cte"][cte]["prestacao"]["valor_prestacao"]
	ZAM->ZAM_FRETE  := oJson["cte"][cte]["prestacao"]["total_frete"]
	ZAM->ZAM_CONC   := oJson["cte"][cte]["prestacao"]["conciliacao_valor"]
	ZAM->ZAM_TIPIMP := Upper(oJson["cte"][cte]["prestacao"]["imposto"]["tipo"])
	ZAM->ZAM_BASIMP := oJson["cte"][cte]["prestacao"]["imposto"]["base"]
	ZAM->ZAM_ALQIMP := oJson["cte"][cte]["prestacao"]["imposto"]["aliquota"]
	ZAM->ZAM_VLRIMP := oJson["cte"][cte]["prestacao"]["imposto"]["valor"]
	ZAM->ZAM_DESIMP := oJson["cte"][cte]["prestacao"]["imposto"]["desconto"]
	MsUnLock()

	For nfs := 1 to Len(oJson["cte"][cte]["notafiscal"])
		cNfCgc := PadR(Upper(oJson["cte"][cte]["notafiscal"][nfs]["emissor"]),TamSx3("ZAN_NFCGC")[1])
		cNfNum := PadR(Upper(oJson["cte"][cte]["notafiscal"][nfs]["numero"]),TamSx3("ZAN_NFNUM")[1])
		cNfSer := PadR(Upper(oJson["cte"][cte]["notafiscal"][nfs]["serie"]),TamSx3("ZAN_NFSERI")[1])
		cNfChv := PadR(Upper(oJson["cte"][cte]["notafiscal"][nfs]["chave"]),TamSx3("ZAN_NFCHV")[1])
		DbSelectArea("ZAN")
		DbSetOrder(1)
		If !DbSeek( xFilial("ZAN") + cIdentCte + cNfCgc + cNfNum + cNfSer + cNfChv )
			RecLock("ZAN",.T.)
			ZAN->ZAN_FILIAL := xFilial("ZAN")
			ZAN->ZAN_IDENT  := cIdentCte
			ZAN->ZAN_NFCGC  := cNfCgc
			ZAN->ZAN_NFNUM  := cNfNum
			ZAN->ZAN_NFSERI := cNfSer
			ZAN->ZAN_NFCHV  := cNfChv
		Else
			RecLock("ZAN",.F.)
		Endif	
		ZAN->ZAN_NFEMI  := Upper(oJson["cte"][cte]["notafiscal"][nfs]["emissao"])
		ZAN->ZAN_NFPESO := oJson["cte"][cte]["notafiscal"][nfs]["peso"]
		ZAN->ZAN_NFPESC := oJson["cte"][cte]["notafiscal"][nfs]["pesocalculado"]
		ZAN->ZAN_NFM3   := oJson["cte"][cte]["notafiscal"][nfs]["m3"]
		ZAN->ZAN_NFVOLU := oJson["cte"][cte]["notafiscal"][nfs]["volumes"]
		ZAN->ZAN_NFVLR  := oJson["cte"][cte]["notafiscal"][nfs]["valor"]
		ZAN->ZAN_NFPROD := Upper(oJson["cte"][cte]["notafiscal"][nfs]["produto_dominante"])
		MsUnLock()
	Next nfs

Next cte

If lErrJson
	SetRestFault(2,;
				 "Falha na inclusao do cte.",;
				 .T.,;
				 400,;
				 "Houve uma falha na leitura dos dados no Json, efetue a correçao.")
	Return(.F.)
Else
	oJsonRet["success"] := .T.
	self:SetResponse( oJsonRet:toJson() )
Endif

Return(lRet)
