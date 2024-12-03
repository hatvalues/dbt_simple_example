
    
    

with child as (
    select assigned_to_user as from_field
    from "postgres"."public_pipedrive_analytics"."stg_pipedrive__activity"
    where assigned_to_user is not null
),

parent as (
    select id as to_field
    from "postgres"."public_pipedrive_analytics"."stg_pipedrive__users"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


