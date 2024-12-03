select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select modified_date
from "postgres"."public_pipedrive_analytics"."stg_pipedrive__users"
where modified_date is null



      
    ) dbt_internal_test