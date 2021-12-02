With Dim_Complaint_Type AS 

(
SELECT
{{ dbt_utils.surrogate_key(['complaint_type']) }} AS Complaint_Dim_ID,
 thr.complaint_type, 
 thr.descriptor, 
FROM `cis-4400-group-4-project.new_york_311.311_new_york_dataset` AS thr
where (complaint_type = 'Noise - Residential') OR (complaint_type = 'Noise - Commercial')
)

SELECT * FROM Dim_Complaint_Type