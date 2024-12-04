
    
    

select
    deal_id as unique_field,
    count(*) as n_records

from "postgres"."public_pipedrive_analytics"."int_deal_changes_dedupe_stage"
where deal_id is not null
group by deal_id
having count(*) > 1


