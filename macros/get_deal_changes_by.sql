-- Used in various tests to check integrity of different types of deal changes at a low level
{% macro get_deal_changes_by(changed_field_key) %}
SELECT
    changed_field_key,
    new_value
FROM
    {{ ref('stg_pipedrive__deal_changes') }}
WHERE
    changed_field_key = '{{ changed_field_key }}'
{% endmacro %}
