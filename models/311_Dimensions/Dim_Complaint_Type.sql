With Dim_Complaint_Type AS 

(
    SELECT
    {{ dbt_utils.surrogate_key(['complaint_type']) }} AS Complaint_Dim_ID,
    Complaint_Type, 
    Descriptor
    FROM
    (SELECT DISTINCT Complaint_Type,  Descriptor
    FROM {{ source('new_york_311', '311_new_york_dataset') }}
    where (complaint_type = 'Noise - Residential') OR (complaint_type = 'Noise - Commercial'))
)

SELECT * FROM Dim_Complaint_Type