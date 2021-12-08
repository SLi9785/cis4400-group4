
with Agency as  (
    select * from {{ ref('Dim_Agency') }}
),

Channel as (
    select * from {{ ref('Dim_Channel') }}
),
Complaint as (
    select * from {{ ref('Dim_Complaint_Type') }}
),
DimDate as (
    select * from {{ ref('Dim_Date') }}
),
Location as (
    select * from {{ ref('Dim_Location') }}
),

final as (

    select
        Agency.Agency_Dim_ID,
        Channel.Channel_Type_Dim_ID,
        Complaint.Complaint_Dim_ID,        
        d1.date_dim_id AS Opened_date_dim_id, 
        d2.date_dim_id AS Closed_date_dim_id,     
        Location.Location_Dim_ID,
        count(Complaint_Dim_ID) AS number_of_Complaints

    FROM {{ source('new_york_311', '311_new_york_dataset') }} as t        
        inner join DimDate d1 ON d1.full_date = EXTRACT(DATE FROM created_Date)
        inner join DimDate d2 ON d2.full_date = EXTRACT(DATE FROM closed_Date)
        inner join Complaint using(Complaint_Type)
        inner join Location using(Incident_Address)
        inner join Channel using(Open_Data_Channel_Type)
        inner join Agency using(Agency_Name)
 

    Group by Agency.Agency_Dim_ID,
        Channel.Channel_Type_Dim_ID,
        Complaint.Complaint_Dim_ID,
        Opened_date_dim_id,
        Closed_date_dim_id,   
        Location.Location_Dim_ID

)

select * from final