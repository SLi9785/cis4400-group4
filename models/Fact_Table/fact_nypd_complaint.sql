
with Offense as  (
    select * from {{ ref('Dim_Offense') }}
),

Nypd_Location as (
    select * from {{ ref('Dim_Nypde_Location') }}
),
Nypd_Date as (
    select * from {{ ref('Dim_Nypd_Date') }}
),
AmountOffenses as (
    select
        Offense_Dim_ID,
        count(Offense_Dim_ID) AS Amount_Offenses,

    from Offense
    group by Offense_Dim_ID
),
final as 
(
    select
        Offense.Offense_Dim_ID,
        Nypd_Location.Location_Dim_ID,
        Nypd_Date.full_date as Created_Date_Dim_ID,       
        count(Offense_Dim_ID) AS Total_Cases
    from {{ source('nypd_dataset', 'nypd_dataset') }} as n
        inner join Nypd_Date on Nypd_Date.full_date = n.CMPLNT_FR_DT
        inner join Offense ON offense.Offense_Cla_Code=n.KY_CD
        inner join Nypd_Location ON Nypd_Location.BOROUGH =n.BORO_NM
    Group by Offense.Offense_Dim_ID,
        Nypd_Location.Location_Dim_ID,
        Created_Date_Dim_ID   
)
select * from final

