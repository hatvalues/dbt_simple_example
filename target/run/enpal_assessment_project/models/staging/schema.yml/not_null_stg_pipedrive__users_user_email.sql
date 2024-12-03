select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select user_email
from "postgres"."public_pipedrive_analytics"."stg_pipedrive__users"
where user_email is null



      
    ) dbt_internal_test