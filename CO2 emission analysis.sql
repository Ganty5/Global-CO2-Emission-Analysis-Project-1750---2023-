--Preview the data
SELECT TOP 100 *
FROM [Carbon Emission Project (ESG)].dbo.emission_data;


--Checking to see unique entity, to enable me clean based on preference
SELECT DISTINCT Entity
FROM [Carbon Emission Project (ESG)].dbo.emission_data;


--Filtering and removing the non-needed data to retain only countries and Global total (World)
DELETE
FROM [Carbon Emission Project (ESG)].dbo.emission_data
WHERE Entity IN (
    -- Regions
    'Africa', 'Europe', 'North America', 'Asia', 'Oceania', 'South America',
    'Antarctica', 'Middle East (GCP)', 'Asia (GCP)', 'Europe (GCP)', 'North America (GCP)',
    'South America (GCP)', 'Central America (GCP)', 'Asia (excl. China and India)',
    'North America (excl. USA)', 'North Korea', 'North Macedonia', 'Africa (GCP)', 'Oceania (GCP)',
	'Ryukyu Islands (GCP)', 'Kuwaiti Oil Fires (GCP)',


    -- Income Levels
    'Lower-middle-income countries', 'Upper-middle-income countries',
    'High-income countries', 'Low-income countries',

    -- Aggregated Groups
    'European Union (27)', 'European Union (28)', 'Europe (excl. EU-27)', 'Europe (excl. EU-28)',
    'Non-OECD (GCP)', 'OECD (GCP)', 'Kuwait Oil Fires (GCP)', 'International shipping',
    'International aviation', 'Bonaire Sint Eustatius and Saba', 'Saint Pierre and Miquelon',

    -- Any others spotted
    'Christmas Island', 'Aruba', 'Palestine', 'Curacao'
)
AND Entity != 'World';


--Verifying my cleaned data
SELECT DISTINCT Entity
FROM [Carbon Emission Project (ESG)].dbo.emission_data
WHERE Entity NOT IN ('World');



--Calculating global CO2 emission over the years
SELECT Year, SUM(Annual_CO_emissions) AS Total_Emissions
FROM [Carbon Emission Project (ESG)].dbo.emission_data
WHERE Entity = 'World'
GROUP BY Year
ORDER BY Year;

--Performing Country-level Analysis

--Top Emitting Countries (All time)
SELECT Entity, SUM(Annual_CO_emissions) AS Total_Emissions
FROM [Carbon Emission Project (ESG)].dbo.emission_data
WHERE Entity != 'World'
GROUP BY Entity
ORDER BY Total_Emissions DESC

--Top emitting Countries (2020)
SELECT TOP 10 Entity, Annual_CO_emissions
FROM [Carbon Emission Project (ESG)].dbo.emission_data
WHERE Year = 2020 AND Entity != 'World'
ORDER BY Annual_CO_emissions DESC;

