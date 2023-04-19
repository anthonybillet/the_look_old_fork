include: "/views/01_order_items.view.lkml"
view: +order_items {

  dimension: fiscal_week_num {
    view_label: "z) fiscal stuff"
    type: number
    # me making up data, a 2 week fiscal offset
    sql: ${created_week_of_year} + 2 ;;
  }

  dimension: fiscal_week_string {
    order_by_field: fiscal_week_num
    view_label: "z) fiscal stuff"
    type: string
    sql: CONCAT('FW:', cast(${fiscal_week_num} AS string)) ;;
  }

  dimension: current_fiscal_week {
    view_label: "z) fiscal stuff"
    type: number
    sql: ${current_week_of_year} + 2;;
  }

  dimension: is_previous_fiscal_week {
    view_label: "z) fiscal stuff"
    type: yesno
    sql: ${fiscal_week_num} = ${current_fiscal_week}-1 ;;
  }

  dimension: fiscal_week_with_previous_week_option {
    view_label: "z) fiscal stuff"
    order_by_field: fiscal_week_with_previous_week_option_order
    type: string
    sql: CASE WHEN ${fiscal_week_num} =  ${current_fiscal_week}-1
                THEN CONCAT (${fiscal_week_string}, ' (Previous Fiscal Week)')
              ELSE ${fiscal_week_string}
              END ;;
  }

  dimension: fiscal_week_with_previous_week_option_order {
    view_label: "z) fiscal stuff"
    type: number
    sql: -1*(CASE WHEN ${fiscal_week_num} =  ${current_fiscal_week}-1  THEN 100000
              ELSE ${fiscal_week_num}
              END) ;;
  }



}
