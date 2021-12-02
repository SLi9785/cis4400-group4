With Dim_Offense AS 

(
SELECT DISTINCT
{{ dbt_utils.surrogate_key(['KY_CD'] ) }} AS Offense_Dim_ID,
 nypd.KY_CD AS Offense_Cla_Code,
 nypd.OFNS_DESC AS Offense_Des,
 nypd.PD_DESC AS PD_Internal_Des,
 nypd.CRM_ATPT_CPTD_CD AS Attempt_Status
 
FROM `cis-4400-group-4-project.NYPD_dataset.NYPD_Complaint_Data` AS nypd
)

SELECT * FROM Dim_Offense