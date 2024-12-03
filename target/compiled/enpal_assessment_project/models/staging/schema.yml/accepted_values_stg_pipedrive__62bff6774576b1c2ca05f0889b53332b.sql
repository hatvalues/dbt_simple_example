
    
    

with all_values as (

    select
        changed_field_key as value_field,
        count(*) as n_records

    from "postgres"."public_pipedrive_analytics"."stg_pipedrive__deal_changes"
    group by changed_field_key

)

select *
from all_values
where value_field not in (
    'user_id','stage_id','lost_reason','add_time'
)


