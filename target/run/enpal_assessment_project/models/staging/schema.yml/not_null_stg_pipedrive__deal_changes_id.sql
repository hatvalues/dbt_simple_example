select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select id
from "postgres"."public_pipedrive_analytics"."stg_pipedrive__deal_changes"
where id is null



      
    ) dbt_internal_test