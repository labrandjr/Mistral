# Mistral & ERP.BR
1. Executar UPDDISTR
2. Compilar os fontes ACORPINT.PRW e ACORPMVC.PRW
3. Inserir rotina no Menu (Função de Usuário ACORPMVC)
4. EndPoint Token: api/oauth2/v1/token (Exemplo: http://localhost:8110/rest/api/oauth2/v1/token?grant_type=password&password=123456&username=Admin). Consulte EndpointToken.Png
5. EndPoint POST: active_corp/V1 (Exemplo: http://localhost:8110/rest/active_corp/V1). Consulte EndPointPost.Png
6. Consulte Exemplo Json.txt (não podem haver tags com o conteúdo = null)
   
