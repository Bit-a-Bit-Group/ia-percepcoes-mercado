# Análise de Dados no BigQuery

## 1. Visão Geral
Breve explicação do objetivo da análise e do dataset utilizado:
- 500 respondentes
- 23 variáveis sobre IA, carreira e educação
- Dataset sintético hospedado no BigQuery

## 2. Verificação de Dados Faltantes
Consulta SQL utilizada com `COUNTIF()` para verificar valores nulos em todas as colunas.  
> Resultado: Nenhuma coluna apresentou valores nulos explícitos.

## 3. Verificação de Inconsistências
### 3.1 Faixa de idade
- Identificada faixa entre 18 e 48 anos.
- Consulta usada para identificar outliers.

### 3.2 Padronização de respostas categóricas
- Corrigidas inconsistências como "None" e "N/A", "Microsoft Copilot" → "Copilot", etc.
- Justificativa: padronização melhora agrupamentos e visualizações.

## 4. Classificação das Variáveis
Tabela que classifica cada coluna como qualitativa ou quantitativa.
> Utilizada como base para definir tipo de análise a ser feita.

## 5. Análise Descritiva
### 5.1 Variáveis Quantitativas
- Estatísticas como média, mediana, desvio padrão e IQR.
- Usado `APPROX_QUANTILES` e `STDDEV`.

### 5.2 Variáveis Qualitativas
- Frequência absoluta e relativa com `GROUP BY` + `COUNT`.

## 6. Cruzamentos Relevantes
- Exemplos de análise cruzada:
    - `Field_Of_Study_Work` vs `AI_Impact_On_Field`
    - `Age` vs `AI_Job_Opportunity_Increase`

## 7. Conclusões Parciais
Resumo dos principais achados antes da visualização:
- Alta aceitação da IA na academia
- Preocupações com o mercado de trabalho
- Forte uso de ferramentas como ChatGPT