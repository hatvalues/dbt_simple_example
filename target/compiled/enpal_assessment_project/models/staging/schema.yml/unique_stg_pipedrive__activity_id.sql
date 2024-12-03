
    
    

select
    id as unique_field,
    count(*) as n_records

from "postgres"."public_pipedrive_analytics"."stg_pipedrive__activity"
where id is not null
group by id
having count(*) > 1


