select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select change_time
from "postgres"."public_pipedrive_analytics"."stg_pipedrive__deal_changes"
where change_time is null



      
    ) dbt_internal_test