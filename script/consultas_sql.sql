-- Verificação de valores nulos por coluna
SELECT
  COUNTIF(Respondent_ID IS NULL) AS null_Respondent_ID,
  COUNTIF(Age IS NULL) AS null_Age,
  ...
FROM `t1engenhariadados.bit_a_bit.respondents_ai_impact_synthetic`;

-- Faixa etária dos respondentes
SELECT MIN(Age) AS idade_minima, MAX(Age) AS idade_maxima
FROM `t1engenhariadados.bit_a_bit.respondents_ai_impact_synthetic`;

-- Verificação de inconsistência: idade fora da faixa
SELECT Respondent_ID, Age
FROM `t1engenhariadados.bit_a_bit.respondents_ai_impact_synthetic`
WHERE Age <= 18 OR Age >= 48;

-- Frequência de status atual
SELECT Current_Status, COUNT(*) as count
FROM `t1engenhariadados.bit_a_bit.respondents_ai_impact_synthetic`
GROUP BY Current_Status
ORDER BY count DESC;

-- Exemplo de padronização
UPDATE `t1engenhariadados.bit_a_bit.respondents_ai_impact_synthetic`
SET Most_Used_AI_Tools_College = 'N/A'
WHERE Most_Used_AI_Tools_College = 'None';

-- Estatísticas descritivas (idade e percepções)
SELECT
  AVG(Age) as idade_media,
  MIN(Age) as idade_minima,
  MAX(Age) as idade_maxima,
  AVG(AI_Job_Opportunity_Increase) as media_oportunidades,
  CORR(Age, AI_Job_Opportunity_Increase) as correlacao_idade_oportunidades
FROM `t1engenhariadados.bit_a_bit.respondents_ai_impact_synthetic`;

-- Frequência de ferramentas usadas (excluindo N/A)
SELECT Most_Used_AI_Tools_College, COUNT(*) as count
FROM `t1engenhariadados.bit_a_bit.respondents_ai_impact_synthetic`
WHERE Most_Used_AI_Tools_College != 'N/A'
GROUP BY Most_Used_AI_Tools_College
ORDER BY count DESC;

-- Exemplo de análise cruzada com percentual
SELECT 
    Field_Of_Study_Work,
    AI_Impact_On_Field,
    COUNT(*) as quantidade,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY Field_Of_Study_Work), 2) as percentual
FROM `t1engenhariadados.bit_a_bit.respondents_ai_impact_synthetic`
GROUP BY Field_Of_Study_Work, AI_Impact_On_Field
ORDER BY Field_Of_Study_Work, quantidade DESC;

-- Tradução de colunas e campos em inglês
CREATE OR REPLACE VIEW `bit_a_bit.respondentes_ia_portugues` AS
SELECT
  Respondent_ID AS ID_RESPONDENTE,
  Age AS IDADE,
  
  -- Status atual
  CASE
    WHEN Current_Status = 'Professional / Already working' THEN 'Profissional'
    WHEN Current_Status = 'Student' THEN 'Estudante'
    WHEN Current_Status = 'Fresh Graduate' THEN 'Recem-formado'
    ELSE Current_Status
  END AS status_atual,

  -- Área de estudo
  CASE 
    WHEN Field_Of_Study_Work ='Healthcare' THEN 'Saude'
    WHEN Field_Of_Study_Work ='Law' THEN 'Direito'
    WHEN Field_Of_Study_Work ='Economics & Management' THEN 'Economia e Gestao'
    WHEN Field_Of_Study_Work ='Finance' THEN 'Financas'
    WHEN Field_Of_Study_Work = 'Industrial Engineering / Information Systems' THEN 'Engenharia Industrial / Sistemas de Informacao'
    WHEN Field_Of_Study_Work ='Information Technology / Computer Science' THEN 'Tecnologia da Informacao / Ciencia da Computacao'
    WHEN Field_Of_Study_Work ='9	Hospitality' THEN 'Hotelaria'
    WHEN Field_Of_Study_Work = 'Arts' THEN 'Artes'
    WHEN Field_Of_Study_Work ='Environmental Science' THEN 'Ciencias Ambientais'
    WHEN Field_Of_Study_Work ='Communications' THEN 'Comunicacao'
    WHEN Field_Of_Study_Work ='Media Studies' THEN 'Estudos de Midia'
    WHEN Field_Of_Study_Work ='Architecture' THEN 'Arquitetura'
    WHEN Field_Of_Study_Work = 'Graphic Design' THEN 'Design Grafico'
    WHEN Field_Of_Study_Work = 'Data Science' THEN 'Ciencia de Dados'
    ELSE Field_Of_Study_Work
  END AS area_de_estudo,

  -- Impacto da IA na área
  CASE 
    WHEN AI_Impact_On_Field = 'Not impacted' THEN 'Não impactado'
    WHEN AI_Impact_On_Field = 'Not sure' THEN 'Não tenho certeza'
    WHEN AI_Impact_On_Field = 'Yes, but only partially' THEN 'Sim, mas apenas parcialmente'
    WHEN AI_Impact_On_Field = 'Yes, significantly impacted' THEN 'Sim, impactado significativamente'
    ELSE AI_Impact_On_Field
  END AS impacto_ia_area_de_atuacao,

  -- Uso da IA na faculdade
  CASE 
    WHEN AI_Usage_During_College = 'Never' THEN 'Nunca'
    WHEN AI_Usage_During_College = 'Rarely' THEN 'Raramente'
    WHEN AI_Usage_During_College = 'Sometimes' THEN 'As vezes'
    WHEN AI_Usage_During_College = 'Often' THEN 'Frequentemente'
    WHEN AI_Usage_During_College = 'Very often' THEN 'Muito frequentemente'
    ELSE AI_Usage_During_College
  END AS uso_ia_faculdade,

  -- Propósito do uso da IA
  CASE 
    WHEN Purpose_Of_AI_College = 'Helping understand material' THEN 'Ajudar a entender o conteúdo'
    WHEN Purpose_Of_AI_College = 'Searching academic references' THEN 'Pesquisar referências acadêmicas'
    WHEN Purpose_Of_AI_College = 'Helping understand material, Searching academic references' THEN 'Ajudar a entender o conteúdo, Pesquisar referências acadêmicas'
    WHEN Purpose_Of_AI_College = 'Helping understand material, Designing or creating content' THEN 'Ajudar a entender o conteúdo, Projetar ou criar conteúdo'
    WHEN Purpose_Of_AI_College = 'Helping understand material, Doing assignments' THEN 'Ajudar a entender o conteúdo, Fazer tarefas'
    WHEN Purpose_Of_AI_College = 'Designing or creating content' THEN 'Projetar ou criar conteúdo'
    WHEN Purpose_Of_AI_College = 'Doing assignments, Helping understand material' THEN 'Fazer tarefas, Ajudar a entender o conteúdo'
    WHEN Purpose_Of_AI_College = 'Doing assignments, Designing or creating content' THEN 'Fazer tarefas, Projetar ou criar conteúdo'
    WHEN Purpose_Of_AI_College = 'Helping understand material, Coding/programming' THEN 'Ajudar a entender o conteúdo, Programação/Coding'
    WHEN Purpose_Of_AI_College = 'Coding/programming, Doing assignments' THEN 'Programação/Coding, Fazer tarefas'
    WHEN Purpose_Of_AI_College = 'Coding/programming, Helping understand material' THEN 'Programação/Coding, Ajudar a entender o conteúdo'
    WHEN Purpose_Of_AI_College = 'Doing assignments, Helping understand material, Designing or creating content' THEN 'Fazer tarefas, Ajudar a entender o conteúdo, Projetar ou criar conteúdo'
    WHEN Purpose_Of_AI_College = 'Helping understand material, Doing assignments, Coding/programming' THEN 'Ajudar a entender o conteúdo, Fazer tarefas, Programação/Coding'
    WHEN Purpose_Of_AI_College = 'Coding/programming, Doing assignments, Searching academic references' THEN 'Programação/Coding, Fazer tarefas, Pesquisar referências acadêmicas'
    WHEN Purpose_Of_AI_College = 'Coding/programming, Helping understand material, Searching academic references' THEN 'Programação/Coding, Ajudar a entender o conteúdo, Pesquisar referências acadêmicas'
    WHEN Purpose_Of_AI_College = 'Coding/programming, Doing assignments, Designing or creating content' THEN 'Programação/Coding, Fazer tarefas, Projetar ou criar conteúdo'
    ELSE Purpose_Of_AI_College
  END AS proposito_uso_ia_faculdade,

  AI_Helpfulness_Academic_Tasks AS utilidade_ia_tarefas_academicas,

  CASE
    WHEN AI_Dependence_College = 'No' THEN 'Nao'
    WHEN AI_Dependence_College = 'Yes' THEN 'Sim'
    ELSE AI_Dependence_College
  END AS dependencia_ia_faculdade,

  AI_Creativity_Productivity_Boost AS ia_criatividade_produtividade,

  CASE
    WHEN AI_Influence_Career_Choice = 'No, AI has no influence on my career choice' THEN 'Nao, a IA nao tem influencia na minha escolha de carreira.'
    WHEN AI_Influence_Career_Choice = 'Yes, but I stay on my career path without much consideration for AI' THEN 'Sim, mas continuo na minha carreira sem muita consideracao pela IA.'
    WHEN AI_Influence_Career_Choice = 'Yes, I consider careers related to AI' THEN 'Sim, considero carreiras relacionadas a IA.'
    ELSE AI_Influence_Career_Choice
  END AS influencia_ia_escolha_carreira,

  CASE
    WHEN Job_Preference_AI_Reliance = 'Does not rely on AI' THEN 'Nao depende de IA'
    WHEN Job_Preference_AI_Reliance = 'No preference, as long as it aligns with my skills' THEN 'Sem preferencia, desde que esteja alinhado com minhas habilidades'
    WHEN Job_Preference_AI_Reliance = 'Relies on AI' THEN 'Depende de IA'
    ELSE Job_Preference_AI_Reliance
  END AS preferencia_trabalho_dependente_ia,

  AI_Job_Reduction_Perception AS percepcao_reducao_empregos_ia,
  Readiness_For_AI_Industry AS preparacao_setor_com_ia,

  CASE
    WHEN Willingness_To_Learn_AI = 'No' THEN 'Nao'
    WHEN Willingness_To_Learn_AI = 'Maybe' THEN 'Talvez'
    WHEN Willingness_To_Learn_AI = 'Yes' THEN 'Sim'
    ELSE Willingness_To_Learn_AI
  END AS disposicao_aprender_ia,

  CASE
    WHEN Workplace_AI_Adoption = 'No' THEN 'Nao'
    WHEN Workplace_AI_Adoption = 'Yes, but still limited' THEN 'Sim, mas ainda limitado'
    WHEN Workplace_AI_Adoption = 'Yes, very active' THEN 'Sim, muito ativo'
    ELSE Workplace_AI_Adoption
  END AS adocao_ia_ambiente_trabalho,

  AI_Work_Efficiency_Increase AS ia_aumento_eficiencia_trabalho,

  CASE 
    WHEN AI_Replacing_Human_Work = 'No' THEN 'Nao'
    ELSE AI_Replacing_Human_Work
  END AS ia_substituindo_trabalho_humano,

  CASE
    WHEN View_On_AI_In_Workplace = 'Neutral' THEN 'Neutro'
    WHEN View_On_AI_In_Workplace = 'Worried - AI threatens jobs' THEN 'Preocupado - IA ameaça empregos'
    WHEN View_On_AI_In_Workplace = 'Optimistic - AI aids productivity' THEN 'Otimista - IA auxilia na produtividade'
    ELSE View_On_AI_In_Workplace
  END AS opiniao_ia_ambiente_trabalho,

  CASE
    WHEN Need_To_Upskill_AI = 'No' THEN 'Nao'
    WHEN Need_To_Upskill_AI = 'Yes' THEN 'Sim'
    ELSE Need_To_Upskill_AI
  END AS necessidade_requalificacao_ia,

  CASE
    WHEN Job_Survival_Next_10_Years = 'Yes' THEN 'Sim'
    WHEN Job_Survival_Next_10_Years = 'Not sure' THEN 'Nao tenho certeza'
    WHEN Job_Survival_Next_10_Years = 'No' THEN 'Nao'
    ELSE Job_Survival_Next_10_Years
  END AS sobrevivencia_profissao_10_anos

FROM `bit_a_bit.respondents_ai_impact_synthetic`;
