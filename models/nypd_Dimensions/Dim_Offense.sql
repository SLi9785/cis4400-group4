{{
  config(
    materialized='table'
  )
}}


With Dim_Offense AS 
 
(
SELECT DISTINCT
{{ dbt_utils.surrogate_key(['KY_CD'] ) }} AS Offense_Dim_ID,
 KY_CD AS Offense_Cla_Code,
 OFNS_DESC AS Offense_Des,
 PD_DESC AS PD_Internal_Des,
 CRM_ATPT_CPTD_CD AS Attempt_Status,

 
FROM  {{ source('nypd_dataset', 'nypd_dataset') }}
)
 
SELECT * FROM Dim_Offense