include: "/views/01_order_items.view.lkml"

view: +order_items {

filter: date_selector_1 {
  view_label: "z) PoP"
  type: date
}

  filter: date_selector_2 {
    view_label: "z) PoP"
    type: date
  }


 dimension: created_date_matches_selector_1 {
  view_label: "z) PoP"
  type: yesno
  sql: {% condition date_selector_1 %} ${created_raw} {% endcondition %} ;;
}

 dimension: created_date_matches_selector_2 {
    view_label: "z) PoP"
    type: yesno
    sql: {% condition date_selector_2 %} ${created_raw} {% endcondition %} ;;
  }

  measure: sales_date_selector_1 {
    view_label: "z) PoP"
    type: sum
    sql: ${sale_price} ;;
    filters: [created_date_matches_selector_1: "Yes"]
  }

  measure: sales_date_selector_2 {
    view_label: "z) PoP"
    type: sum
    sql: ${sale_price} ;;
    filters: [created_date_matches_selector_2: "Yes"]
  }


}
