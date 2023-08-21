include: "/views/02_users.view.lkml"
view: +users {
  measure: sample_html_arrows {
    view_label: "Z) HTML Stuff"
    type: number
    sql: ${count_percent_of_total} - ${order_items.total_gross_margin_percentage}  ;;
  }

}
