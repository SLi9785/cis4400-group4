With Dim_Agency AS 

(
    SELECT 
    {{ dbt_utils.surrogate_key(['agency_name'] ) }} AS Agency_Dim_ID,
    agency AS Agency, 
    agency_name AS Agency_Name
    FROM
    (SELECT DISTINCT agency, agency_name
    FROM {{ source('new_york_311', '311_new_york_dataset') }}
    where (complaint_type = 'Noise - Residential') OR (complaint_type = 'Noise - Commercial'))
)
SELECT * FROM Dim_Agency