{{ config(materialized='table') }}
 
 
with Location_Dim AS
(
SELECT Distinct 
    {{ dbt_utils.surrogate_key(['PD_CD']) }} AS Location_Dim_ID,
    PD_CD,
    BOROUGH
FROM(
  SELECT distinct PD_CD, BORO_NM AS BOROUGH
FROM  {{ source('nypd_dataset', 'nypd_dataset') }}
 
        where PD_DESC = 'NOISE,UNECESSARY' )
      )
SELECT * FROM Location_Dim