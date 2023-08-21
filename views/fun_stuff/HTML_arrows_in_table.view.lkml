include: "/views/02_users.view.lkml"
include: "/views/01_order_items.view.lkml"
view: +order_items {

  measure: total_sold_to_top_states {
    view_label: "Z) HTML Stuff"
    type: sum
    sql: ${sale_price} ;;
    value_format_name: usd_0
    filters: [users.state: "California,Texas,New York,Illinois,Florida,Ohio,Arizona,North Carolina,Pennsylvania,Michigan,New Jersey"]
  }

  measure: percent_sold_to_top_states {
    view_label: "Z) HTML Stuff"
    type: number
    value_format_name: percent_2
    sql: 1.0*${total_sold_to_top_states} / NULLIF(${total_sale_price},0) ;;
  }

  measure: sample_HTML_delta_arrows {
    view_label: "Z) HTML Stuff"
    type: number
    value_format_name: percent_2
    sql: ${total_gross_margin_percentage} - ${percent_sold_to_top_states} ;;
    html:
        {% if value > 0 %}
        {% assign indicator = "green,▲" | split: ',' %}
        {% elsif value < 0 %}
        {% assign indicator = "red,▼" | split: ',' %}
        {% else %}
        {% assign indicator = "black,▬" | split: ',' %}
        {% endif %}

        <span style = "color:{{indicator[0]}}">
        {{indicator[1]}}
        </span>{{rendered_value}} ;;
  }

  measure: another_fake_percent_measure {
    view_label: "Z) HTML Stuff"
    type: number
    value_format_name: percent_2
    sql: 1.5*${total_sold_to_top_states} / NULLIF(${total_sale_price},0) ;;
  }
}
