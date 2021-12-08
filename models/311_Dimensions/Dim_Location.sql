{{ config(materialized='table') }} 
with Dim_Location AS
(
SELECT DISTINCT
    {{ dbt_utils.surrogate_key(['Incident_Zip']) }} AS  Location_Dim_ID,
 Incident_Zip,
 Incident_Address,
 City,
Borough
FROM 
( SELECT distinct  Incident_Zip,
 Incident_Address,
 City,
Borough
FROM {{ source('new_york_311', '311_new_york_dataset') }}
        where complaint_type = 'Noise - Residential' OR complaint_type = 'Noise - commercial')
WHERE Incident_Address is NOT NULL AND Borough is NOT NULL AND City is NOT NULL AND Incident_Zip is NOT NULL 
)
SELECT * FROM Dim_Location
