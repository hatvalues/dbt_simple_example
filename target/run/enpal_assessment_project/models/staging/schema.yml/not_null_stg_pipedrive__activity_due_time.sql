select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select due_time
from "postgres"."public_pipedrive_analytics"."stg_pipedrive__activity"
where due_time is null



      
    ) dbt_internal_test