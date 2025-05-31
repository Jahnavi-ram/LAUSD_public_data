A. Demand vs. Supply & Seat Offer Rates

Query 1: Top Applicant ZIP Codes by Number of Applications

SELECT 
    applicant_zipcode,
    SUM(applications_count) AS total_applications
FROM 
    zipcode_insights
WHERE 
    applicant_zipcode IS NOT NULL
GROUP BY 
    applicant_zipcode
ORDER BY 
    total_applications DESC
LIMIT 10;

Query 2: Top Applicant ZIP Codes by Number of Seat Offers

SELECT 
    applicant_zipcode,
    SUM(seat_offers) AS total_seat_offers
FROM 
    zipcode_insights
WHERE 
    applicant_zipcode IS NOT NULL
GROUP BY 
    applicant_zipcode
ORDER BY 
    total_seat_offers DESC
LIMIT 10;


 Query 3: Acceptance Rate by Applicant ZIP Code (Min 10 Applications)

SELECT 
    applicant_zipcode,
    SUM(seat_offers) AS total_offers,
    SUM(applications_count) AS total_applications,
    ROUND(
        (SUM(seat_offers)::DECIMAL / NULLIF(SUM(applications_count), 0)) * 100, 
        2
    ) AS acceptance_rate_percent
FROM 
    zipcode_insights
WHERE 
    applicant_zipcode IS NOT NULL
GROUP BY 
    applicant_zipcode
HAVING 
    SUM(applications_count) >= 10
ORDER BY 
    acceptance_rate_percent DESC;


Query 4: ZIP Codes with Lowest Acceptance Rates (Min 10 Applications)

SELECT 
    applicant_zipcode,
    SUM(seat_offers) AS total_offers,
    SUM(applications_count) AS total_applications,
    ROUND(
        (SUM(seat_offers)::DECIMAL / NULLIF(SUM(applications_count), 0)) * 100, 
        2
    ) AS acceptance_rate_percent
FROM 
    zipcode_insights
WHERE 
    applicant_zipcode IS NOT NULL
GROUP BY 
    applicant_zipcode
HAVING 
    SUM(applications_count) >= 10
ORDER BY 
    acceptance_rate_percent ASC
LIMIT 10;


Query 5: ZIP Codes with the Widest Gap Between Applications and Seat Offers

SELECT 
    applicant_zipcode,
    SUM(applications_count) AS total_applications,
    SUM(seat_offers) AS total_offers,
    (SUM(applications_count) - SUM(seat_offers)) AS application_offer_gap
FROM 
    zipcode_insights
WHERE 
    applicant_zipcode IS NOT NULL
GROUP BY 
    applicant_zipcode
HAVING 
    SUM(applications_count) >= 10
ORDER BY 
    application_offer_gap DESC
LIMIT 10;


B. Local vs. Non-Local Preferences

Query 6: What % of Applicants Apply to Schools Within Their Own ZIP Code?

SELECT 
    COUNT(*) AS total_applications,
    COUNT(*) FILTER (
        WHERE applicant_zipcode = school_zipcode
    ) AS local_applications,
    ROUND(
        (COUNT(*) FILTER (
            WHERE applicant_zipcode = school_zipcode
        ) * 100.0) / COUNT(*), 
        2
    ) AS local_application_percent
FROM 
    zipcode_insights
WHERE 
    applicant_zipcode IS NOT NULL 
    AND school_zipcode IS NOT NULL;


Query 7: Do Students Applying Within Their Own ZIP Get Better Seat Offer Rates?

SELECT
  CASE 
    WHEN applicant_zipcode = school_zipcode THEN 'Local'
    ELSE 'Non-Local'
  END AS application_type,
  SUM(applications_count) AS total_applications,
  SUM(seat_offers) AS total_offers,
  ROUND(
    (SUM(seat_offers)::DECIMAL / NULLIF(SUM(applications_count), 0)) * 100,
    2
  ) AS acceptance_rate_percent
FROM zipcode_insights
WHERE applicant_zipcode IS NOT NULL
  AND school_zipcode IS NOT NULL
GROUP BY application_type;



C. Severity Flags / Anomalies

Query 8: Which ZIP Codes Have 0 Seat Offers Despite Receiving Applications?

SELECT 
    applicant_zipcode,
    SUM(applications_count) AS total_applications,
    SUM(seat_offers) AS total_offers
FROM 
    zipcode_insights
WHERE 
    applicant_zipcode IS NOT NULL
GROUP BY 
    applicant_zipcode
HAVING 
    SUM(applications_count) > 0
    AND SUM(seat_offers) = 0
ORDER BY 
    total_applications DESC;



D. Equity Outliers

Query 9: Which zip codes fall significantly below the average seat offer rate?

WITH offer_rates AS (
    SELECT
        applicant_zipcode,
        SUM(seat_offers) AS total_offers,
        SUM(applications_count) AS total_applications,
        ROUND(
            (SUM(seat_offers)::DECIMAL / NULLIF(SUM(applications_count), 0)) * 100, 
            2
        ) AS acceptance_rate
    FROM zipcode_insights
    WHERE applicant_zipcode IS NOT NULL
    GROUP BY applicant_zipcode
    HAVING SUM(applications_count) >= 10
),
stats AS (
    SELECT 
        AVG(acceptance_rate) AS avg_rate,
        STDDEV(acceptance_rate) AS stddev_rate
    FROM offer_rates
)
SELECT 
    o.applicant_zipcode,
    o.total_applications,
    o.total_offers,
    o.acceptance_rate,
    ROUND(s.avg_rate, 2) AS average_rate,
    ROUND(s.stddev_rate, 2) AS standard_deviation,
    ROUND((o.acceptance_rate - s.avg_rate) / NULLIF(s.stddev_rate, 0), 2) AS z_score
FROM 
    offer_rates o
CROSS JOIN stats s
WHERE 
    o.acceptance_rate < s.avg_rate - s.stddev_rate
ORDER BY 
    o.acceptance_rate ASC;


E. Geographic Pattern Summary
Query 10 : What patterns emerge if we group zip codes into regions (e.g., East vs. West LA)?(Min 30 Applications per Region)

SELECT 
    LEFT(applicant_zipcode, 3) AS zip_region,
    COUNT(*) AS total_rows,
    SUM(applications_count) AS total_applications,
    SUM(seat_offers) AS total_offers,
    ROUND(
        (SUM(seat_offers)::DECIMAL / NULLIF(SUM(applications_count), 0)) * 100,
        2
    ) AS acceptance_rate
FROM 
    zipcode_insights
WHERE 
    applicant_zipcode IS NOT NULL
GROUP BY 
    LEFT(applicant_zipcode, 3)
HAVING 
    SUM(applications_count) >= 30
ORDER BY 
    acceptance_rate ASC;



