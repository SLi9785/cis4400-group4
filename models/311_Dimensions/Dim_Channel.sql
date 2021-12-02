With Dim_Channel AS 

(
SELECT DISTINCT
{{ dbt_utils.surrogate_key(['Open_Data_Channel_Type'] ) }} AS Channel_Type_Dim_ID,
 thr.open_data_channel_type 
 
FROM `cis-4400-group-4-project.new_york_311.311_new_york_dataset` AS thr
where (complaint_type = 'Noise - Residential') OR (complaint_type = 'Noise - Commercial')
)

SELECT * FROM Dim_Channel