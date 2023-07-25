include: "/views/01_order_items.view.lkml"

view: +order_items {
  parameter: user_input_param {
    view_label: "Z) Params stuff"
    type: string
    allowed_value: {
      value: "Anthony"
    }
    allowed_value: {
      value: "Catkin"
    }
    default_value: "Catkin"
  }

  filter: user_input_filter {
    view_label: "Z) Params stuff"
    type: date
  }

  measure: count_dynamic {
    view_label: "Z) Params stuff"
    type: number
    # sql: COUNT(CASE WHEN ${created_date} BETWEEN  (DATE('2023-07-03')) AND CURRENT_DATE() THEN 1 ELSE NULL END) / COUNT(*);;
    # sql: COUNT(CASE WHEN ${created_date} BETWEEN  (DATE({% parameter user_input_param %})) AND CURRENT_DATE() THEN 1 ELSE NULL END) / COUNT(*);;
    sql: COUNT(CASE WHEN {% condition user_input_filter %} TIMESTAMP(${created_date}) {% endcondition %} THEN 1 ELSE NULL END) / COUNT(*);;
  }


}
