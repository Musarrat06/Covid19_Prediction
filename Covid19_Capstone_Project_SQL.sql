SELECT * FROM covid19.covid19_data;

/* 1. Find the number of corona patients who faced shortness of breath. */
SELECT COUNT(*) AS num_patients_with_shortness_of_breath
FROM Covid19_data
WHERE Corona = 'positive' AND Shortness_of_breath = 'TRUE';

/* 2. Find the number of negative corona patients who have fever and sore_throat. */
SELECT COUNT(*) AS num_negative_patients_with_fever_and_sore_throat
FROM Covid19_data
WHERE Corona = 'negative' AND Fever = 'TRUE' AND Sore_throat = 'TRUE';

/* 3. Group the data by month and rank the number of positive cases. */
SELECT MONTH(Test_date) AS month,
COUNT(*) AS num_positive_cases,
DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS ranks
FROM Covid19_data
WHERE Corona = 'positive'
GROUP BY MONTH(Test_date)
ORDER BY month;

/* 4. Find the female negative corona patients who faced cough and headache.*/
SELECT COUNT(*) AS num_female_negative_cases
FROM Covid19_data
WHERE Corona = 'negative'
AND Sex = 'female'
AND Cough_symptoms = 'TRUE'
AND Headache = 'TRUE';

/* 5. How many elderly corona patients have faced breathing problems?*/
SELECT COUNT(*) AS num_elderly_breathing_problems
FROM Covid19_data
WHERE Corona = 'positive'
AND Age_60_above = '1'
AND Shortness_of_breath = 'TRUE';

/* 6. Which three symptoms were more common among COVID positive patients?*/
SELECT 
SUM(Cough_symptoms = 'TRUE') AS num_cough,
SUM(Fever = 'TRUE') AS num_fever,
SUM(Sore_throat = 'TRUE') AS num_sore_throat,
SUM(Shortness_of_breath = 'TRUE') AS num_shortness_of_breath,
SUM(Headache = 'TRUE') AS num_headache
FROM Covid19_data
WHERE Corona = 'positive'
ORDER BY num_cough, num_fever, num_sore_throat, num_shortness_of_breath, num_headache DESC
LIMIT 3;

/* 7. Which symptom was less common among COVID negative people?*/
SELECT 
SUM(Cough_symptoms = 'TRUE') AS num_cough,
SUM(Fever = 'TRUE') AS num_fever,
SUM(Sore_throat = 'TRUE') AS num_sore_throat,
SUM(Shortness_of_breath = 'TRUE') AS num_shortness_of_breath,
SUM(Headache = 'TRUE') AS num_headache
FROM Covid19_data
WHERE Corona = 'negative'
ORDER BY num_cough, num_fever, num_sore_throat, num_shortness_of_breath, num_headache ASC
LIMIT 1;

/* 8. What are the most common symptoms among COVID positive males whose known contact was abroad? */
SELECT 
SUM(Cough_symptoms = 'TRUE') AS num_cough,
SUM(Fever = 'TRUE') AS num_fever,
SUM(Sore_throat = 'TRUE') AS num_sore_throat,
SUM(Shortness_of_breath = 'TRUE') AS num_shortness_of_breath,
SUM(Headache = 'TRUE') AS num_headache
FROM Covid19_data
WHERE Corona = 'positive'
AND Sex = 'male'
AND Known_contact = 'Abroad'
GROUP BY Corona, Sex, Known_contact
ORDER BY num_cough, num_fever, num_sore_throat, num_shortness_of_breath, num_headache DESC
LIMIT 1;