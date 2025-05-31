Query 1: Total Applications – Dual vs Non-Dual
SELECT 
  dual_language,
  SUM(applications) AS total_applications
FROM 
  public.dual_language_applications
GROUP BY 
  dual_language;


Query 2: Total Seat Offers – Dual vs Non-Dual
SELECT 
  dual_language,
  SUM(seat_offers) AS total_seat_offers
FROM 
  public.dual_language_applications
GROUP BY 
  dual_language;


Query 3: Acceptance Rate – Dual vs Non-Dual
SELECT 
  dual_language,
  SUM(seat_offers) AS total_offers,
  SUM(applications) AS total_applications,
  ROUND(
    (SUM(seat_offers)::DECIMAL / NULLIF(SUM(applications), 0)) * 100, 
    2
  ) AS acceptance_rate_percent
FROM 
  public.dual_language_applications
GROUP BY 
  dual_language;


Query 4: ZIPs with ≥10 Applications (Dual vs Non-Dual Acceptance Rates Side-by-Side)

SELECT 
  zip_code,
  MAX(CASE WHEN dual_language = 'Yes' THEN total_apps ELSE 0 END) AS dual_apps,
  MAX(CASE WHEN dual_language = 'Yes' THEN total_offers ELSE 0 END) AS dual_offers,
  ROUND(
    MAX(CASE WHEN dual_language = 'Yes' THEN total_offers ELSE 0 END)::DECIMAL 
    / NULLIF(MAX(CASE WHEN dual_language = 'Yes' THEN total_apps ELSE 0 END), 0) * 100, 2
  ) AS dual_acceptance_rate,

  MAX(CASE WHEN dual_language = 'No' THEN total_apps ELSE 0 END) AS non_dual_apps,
  MAX(CASE WHEN dual_language = 'No' THEN total_offers ELSE 0 END) AS non_dual_offers,
  ROUND(
    MAX(CASE WHEN dual_language = 'No' THEN total_offers ELSE 0 END)::DECIMAL 
    / NULLIF(MAX(CASE WHEN dual_language = 'No' THEN total_apps ELSE 0 END), 0) * 100, 2
  ) AS non_dual_acceptance_rate

FROM (
  SELECT 
    zip_code,
    dual_language,
    SUM(applications) AS total_apps,
    SUM(seat_offers) AS total_offers
  FROM 
    public.dual_language_applications
  WHERE 
    zip_code IS NOT NULL
  GROUP BY 
    zip_code, dual_language
) AS summarized
GROUP BY 
  zip_code
HAVING 
  (MAX(CASE WHEN dual_language = 'Yes' THEN total_apps ELSE 0 END) >= 10
   OR MAX(CASE WHEN dual_language = 'No' THEN total_apps ELSE 0 END) >= 10)
ORDER BY 
  dual_acceptance_rate ASC NULLS LAST;



Query 5: Acceptance Rate by School – Dual vs Non-Dual (at least 10 applications)
SELECT
    school,
    SUM(CASE WHEN dual_language = 'Yes' THEN applications ELSE 0 END) AS dual_apps,
    SUM(CASE WHEN dual_language = 'Yes' THEN seat_offers ELSE 0 END) AS dual_offers,
    ROUND(
        SUM(CASE WHEN dual_language = 'Yes' THEN seat_offers ELSE 0 END)::DECIMAL
        / NULLIF(SUM(CASE WHEN dual_language = 'Yes' THEN applications ELSE 0 END), 0) * 100, 2
    ) AS dual_acceptance_rate,
    SUM(CASE WHEN dual_language = 'No' THEN applications ELSE 0 END) AS non_dual_apps,
    SUM(CASE WHEN dual_language = 'No' THEN seat_offers ELSE 0 END) AS non_dual_offers,
    ROUND(
        SUM(CASE WHEN dual_language = 'No' THEN seat_offers ELSE 0 END)::DECIMAL
        / NULLIF(SUM(CASE WHEN dual_language = 'No' THEN applications ELSE 0 END), 0) * 100, 2
    ) AS non_dual_acceptance_rate
FROM public.dual_language_applications
GROUP BY school
HAVING 
    SUM(CASE WHEN dual_language = 'Yes' THEN applications ELSE 0 END) >= 10
    AND SUM(CASE WHEN dual_language = 'No' THEN applications ELSE 0 END) >= 10
ORDER BY ABS(
    ROUND(SUM(CASE WHEN dual_language = 'Yes' THEN seat_offers ELSE 0 END)::DECIMAL / NULLIF(SUM(CASE WHEN dual_language = 'Yes' THEN applications ELSE 0 END), 0) * 100, 2)
    -
    ROUND(SUM(CASE WHEN dual_language = 'No' THEN seat_offers ELSE 0 END)::DECIMAL / NULLIF(SUM(CASE WHEN dual_language = 'No' THEN applications ELSE 0 END), 0) * 100, 2)
) DESC;


Query 6: Top Schools by Dual Language Application Volume
-- Query 6: Top Schools by Dual Language Application Volume
SELECT 
  school,
  SUM(applications) AS dual_language_applications
FROM 
  public.dual_language_applications
WHERE 
  dual_language = 'Yes'
GROUP BY 
  school
ORDER BY 
  dual_language_applications DESC
LIMIT 15;



Query 7: Application and Offer Breakdown by School Type

SELECT 
  school_type,
  dual_language,
  SUM(applications) AS total_applications,
  SUM(seat_offers) AS total_offers,
  ROUND(
    (SUM(seat_offers)::DECIMAL / NULLIF(SUM(applications), 0)) * 100, 2
  ) AS acceptance_rate_percent
FROM public.dual_language_applications
WHERE school_type IS NOT NULL AND dual_language IS NOT NULL
GROUP BY school_type, dual_language
ORDER BY school_type, dual_language;


Query 8: Acceptance Rate by Community of Schools Purpose: Explore whether disparities are tied to specific regional communities.

-- Query 8: Acceptance Rate by Community of Schools – Dual vs Non-Dual
SELECT 
  community_of_schools,
  dual_language,
  SUM(applications) AS total_applications,
  SUM(seat_offers) AS total_offers,
  ROUND(
    (SUM(seat_offers)::DECIMAL / NULLIF(SUM(applications), 0)) * 100, 2
  ) AS acceptance_rate_percent
FROM 
  public.dual_language_applications
WHERE 
  community_of_schools IS NOT NULL AND dual_language IS NOT NULL
GROUP BY 
  community_of_schools, dual_language
ORDER BY 
  community_of_schools, dual_language;



Query 9: Schools with Zero Offers for One Group Purpose: Detect potential exclusion patterns where one group receives no offers.
SELECT
  school,
  SUM(CASE WHEN dual_language = 'Yes' THEN applications ELSE 0 END) AS dual_apps,
  SUM(CASE WHEN dual_language = 'Yes' THEN seat_offers ELSE 0 END) AS dual_offers,
  SUM(CASE WHEN dual_language = 'No' THEN applications ELSE 0 END) AS non_dual_apps,
  SUM(CASE WHEN dual_language = 'No' THEN seat_offers ELSE 0 END) AS non_dual_offers
FROM public.dual_language_applications
GROUP BY school
HAVING 
  (SUM(CASE WHEN dual_language = 'Yes' THEN applications ELSE 0 END) >= 10 AND
   SUM(CASE WHEN dual_language = 'Yes' THEN seat_offers ELSE 0 END) = 0)
  OR
  (SUM(CASE WHEN dual_language = 'No' THEN applications ELSE 0 END) >= 10 AND
   SUM(CASE WHEN dual_language = 'No' THEN seat_offers ELSE 0 END) = 0)
ORDER BY school;


Query 10: Acceptance Rate Gap (Non-Dual – Dual) by School or ZIP Purpose: Quantify the magnitude of disparity to highlight where interventions are needed most.
SELECT
  school,
  SUM(CASE WHEN dual_language = 'Yes' THEN applications ELSE 0 END) AS dual_apps,
  SUM(CASE WHEN dual_language = 'Yes' THEN seat_offers ELSE 0 END) AS dual_offers,
  ROUND(
    SUM(CASE WHEN dual_language = 'Yes' THEN seat_offers ELSE 0 END)::DECIMAL
    / NULLIF(SUM(CASE WHEN dual_language = 'Yes' THEN applications ELSE 0 END), 0) * 100, 2
  ) AS dual_acceptance_rate,

  SUM(CASE WHEN dual_language = 'No' THEN applications ELSE 0 END) AS non_dual_apps,
  SUM(CASE WHEN dual_language = 'No' THEN seat_offers ELSE 0 END) AS non_dual_offers,
  ROUND(
    SUM(CASE WHEN dual_language = 'No' THEN seat_offers ELSE 0 END)::DECIMAL
  ) AS non_dual_acceptance_rate,

  ROUND(
    ROUND(SUM(CASE WHEN dual_language = 'No' THEN seat_offers ELSE 0 END)::DECIMAL
    / NULLIF(SUM(CASE WHEN dual_language = 'No' THEN applications ELSE 0 END), 0) * 100, 2)
    -
    ROUND(SUM(CASE WHEN dual_language = 'Yes' THEN seat_offers ELSE 0 END)::DECIMAL
    / NULLIF(SUM(CASE WHEN dual_language = 'Yes' THEN applications ELSE 0 END), 0) * 100, 2)
  , 2) AS rate_gap_percent

FROM public.dual_language_applications
GROUP BY school
HAVING 
  SUM(CASE WHEN dual_language = 'Yes' THEN applications ELSE 0 END) >= 10 AND
  SUM(CASE WHEN dual_language = 'No' THEN applications ELSE 0 END) >= 10
ORDER BY rate_gap_percent DESC;
