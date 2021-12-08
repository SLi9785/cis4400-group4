With Dim_Channel AS 

(
SELECT DISTINCT
{{ dbt_utils.surrogate_key(['Open_Data_Channel_Type'] ) }} AS Channel_Type_Dim_ID,
 Open_Data_Channel_Type , 
FROM {{ source('new_york_311', '311_new_york_dataset') }}
where (complaint_type = 'Noise - Residential') OR (complaint_type = 'Noise - Commercial')
)

SELECT * FROM Dim_Channel