select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select is_done
from "postgres"."public_pipedrive_analytics"."stg_pipedrive__activity"
where is_done is null



      
    ) dbt_internal_test