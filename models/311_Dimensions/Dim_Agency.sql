With Dim_Agency AS 

(
SELECT DISTINCT
{{ dbt_utils.surrogate_key(['agency_name'] ) }} AS Agency_Dim_ID,
 thr.agency AS Agency, 
 thr.agency_name AS Agency_Name, 
FROM `cis-4400-group-4-project.new_york_311.311_new_york_dataset` AS thr
where (complaint_type = 'Noise - Residential') OR (complaint_type = 'Noise - Commercial')
)

SELECT * FROM Dim_Agency