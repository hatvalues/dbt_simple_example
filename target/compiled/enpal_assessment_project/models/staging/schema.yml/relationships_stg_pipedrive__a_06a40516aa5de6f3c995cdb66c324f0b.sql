
    
    

with child as (
    select activity_name as from_field
    from "postgres"."public_pipedrive_analytics"."stg_pipedrive__activity"
    where activity_name is not null
),

parent as (
    select activity_name as to_field
    from "postgres"."public_pipedrive_analytics"."stg_pipedrive__activity_types"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


