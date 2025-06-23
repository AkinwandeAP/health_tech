-- Insights from raw_data Using SQL

-- 1. Overall Cancer Prevalence
-- Insight: Percentage of cases with cancer = 'Yes' across the dataset.
SELECT 
    COUNT(*) AS total_cases,
    SUM(CASE WHEN cancer = 'Yes' THEN 1 ELSE 0 END) AS cancer_cases,
    ROUND(100.0 * SUM(CASE WHEN cancer = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS cancer_percentage
FROM health_tech.raw_data;

-- 2. Emergency Case Rate
-- Insight: Percentage of cases classified as emergencies (emergency = 'Yes').
SELECT 
    COUNT(*) AS total_cases,
    SUM(CASE WHEN emergency = 'Yes' THEN 1 ELSE 0 END) AS emergency_cases,
    ROUND(100.0 * SUM(CASE WHEN emergency = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS emergency_percentage
FROM health_tech.raw_data;

-- 3. Cancer Prevalence by Age Group and Sex
-- Insight: How cancer risk varies by age range and sex.
SELECT 
    CASE 
        WHEN age < 30 THEN '18-29'
        WHEN age < 50 THEN '30-49'
        WHEN age < 70 THEN '50-69'
        ELSE '70+' 
    END AS age_group,
    sex,
    COUNT(*) AS total_cases,
    SUM(CASE WHEN cancer = 'Yes' THEN 1 ELSE 0 END) AS cancer_cases,
    ROUND(100.0 * SUM(CASE WHEN cancer = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS cancer_percentage
FROM health_tech.raw_data
GROUP BY age_group, sex
ORDER BY age_group, sex;

-- 4.Emergency Distribution by Cancer Status
-- Insight: Proportion of emergency cases among cancer vs. non-cancer patients.
SELECT 
    cancer,
    emergency,
    COUNT(*) AS case_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY cancer), 2) AS percentage
FROM health_tech.raw_data
GROUP BY cancer, emergency
ORDER BY cancer, emergency;
-- 5. Top Symptoms in Cancer Cases
-- Insight: Prevalence of each symptom among patients with cancer = 'Yes'.
SELECT 
    'Fatigue' AS symptom, 
    SUM(CASE WHEN fatigue = 'Yes' AND cancer = 'Yes' THEN 1 ELSE 0 END) AS symptom_count,
    ROUND(100.0 * SUM(CASE WHEN fatigue = 'Yes' AND cancer = 'Yes' THEN 1 ELSE 0 END) / 
          SUM(CASE WHEN cancer = 'Yes' THEN 1 ELSE 0 END), 2) AS symptom_percentage
FROM health_tech.raw_data
UNION
SELECT 'Weight Loss', 
       SUM(CASE WHEN weight_loss = 'Yes' AND cancer = 'Yes' THEN 1 ELSE 0 END),
       ROUND(100.0 * SUM(CASE WHEN weight_loss = 'Yes' AND cancer = 'Yes' THEN 1 ELSE 0 END) / 
             SUM(CASE WHEN cancer = 'Yes' THEN 1 ELSE 0 END), 2)
FROM health_tech.raw_data
UNION
SELECT 'Pain', 
       SUM(CASE WHEN pain = 'Yes' AND cancer = 'Yes' THEN 1 ELSE 0 END),
       ROUND(100.0 * SUM(CASE WHEN pain = 'Yes' AND cancer = 'Yes' THEN 1 ELSE 0 END) / 
             SUM(CASE WHEN cancer = 'Yes' THEN 1 ELSE 0 END), 2)
FROM health_tech.raw_data
-- Add similar UNION clauses for fever, night_sweats, bleeding, lumps, cough, bowel_bladder_changes
ORDER BY symptom_percentage DESC;

-- 6. Average Severity Indicators by Emergency Status
-- Insight: Average pain_severity and weight_loss_amount_kg in emergency vs. non-emergency cases.
SELECT 
    emergency,
    AVG(pain_severity) AS avg_pain_severity,
    AVG(weight_loss_amount_kg) AS avg_weight_loss_kg,
    COUNT(*) AS case_count
FROM health_tech.raw_data
GROUP BY emergency
ORDER BY emergency;
-- 7. Impact of Family History
-- Insight: Cancer and emergency rates for patients with vs. without family history.
SELECT 
    family_history,
    COUNT(*) AS total_cases,
    SUM(CASE WHEN cancer = 'Yes' THEN 1 ELSE 0 END) AS cancer_cases,
    ROUND(100.0 * SUM(CASE WHEN cancer = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS cancer_percentage,
    SUM(CASE WHEN emergency = 'Yes' THEN 1 ELSE 0 END) AS emergency_cases,
    ROUND(100.0 * SUM(CASE WHEN emergency = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS emergency_percentage
FROM health_tech.raw_data
GROUP BY family_history
ORDER BY family_history;
-- 8. Bleeding Severity Distribution in Emergencies
-- Insight: How bleeding_severity correlates with emergency cases.
SELECT 
    bleeding_severity,
    COUNT(*) AS case_count,
    SUM(CASE WHEN emergency = 'Yes' THEN 1 ELSE 0 END) AS emergency_cases,
    ROUND(100.0 * SUM(CASE WHEN emergency = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS emergency_percentage
FROM health_tech.raw_data
GROUP BY bleeding_severity
ORDER BY 
    CASE bleeding_severity 
        WHEN 'None' THEN 1 
        WHEN 'Mild' THEN 2 
        WHEN 'Moderate' THEN 3 
        WHEN 'Severe' THEN 4 
    END;
    
-- 9. Age and Pain Severity Correlation
-- Insight: Average pain_severity across age groups.
SELECT 
    CASE 
        WHEN age < 30 THEN '18-29'
        WHEN age < 50 THEN '30-49'
        WHEN age < 70 THEN '50-69'
        ELSE '70+' 
    END AS age_group,
    AVG(pain_severity) AS avg_pain_severity,
    COUNT(*) AS case_count
FROM health_tech.raw_data
GROUP BY age_group
ORDER BY age_group;

-- 10. Symptom Combinations in Cancer Cases
-- Insight: Frequency of multiple symptoms (e.g., fatigue + weight loss) in cancer patients.
SELECT 
    SUM(CASE WHEN fatigue = 'Yes' AND weight_loss = 'Yes' AND cancer = 'Yes' THEN 1 ELSE 0 END) AS fatigue_weight_loss_count,
    ROUND(100.0 * SUM(CASE WHEN fatigue = 'Yes' AND weight_loss = 'Yes' AND cancer = 'Yes' THEN 1 ELSE 0 END) / 
          SUM(CASE WHEN cancer = 'Yes' THEN 1 ELSE 0 END), 2) AS percentage
FROM health_tech.raw_data;