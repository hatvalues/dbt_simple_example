{% macro add_month_fields(date_column) %}
    EXTRACT(MONTH FROM {{ date_column }}) AS month_number,
    TO_CHAR({{ date_column }}, 'Month') AS month_name
{% endmacro %}
