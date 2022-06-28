include: "/views/01_order_items.view.lkml"
view: +order_items {
#dimensional values for my fake readings - hidden in visual (ignore the sql here its just me messing with ecomm numbers to make testing styl numbers)
  dimension: fake_reading1 {
    view_label: "Z) Fake Readings"
    type: number
    sql: ${sale_price} * 20 ;;
    value_format_name: decimal_2
  }

  dimension: fake_reading2 {
    view_label: "Z) Fake Readings"
    type: number
    sql: ${sale_price} ;;
    value_format_name: decimal_2
  }

  dimension: fake_reading3 {
    view_label: "Z) Fake Readings"
    type: number
    sql: ${gross_margin} ;;
    value_format_name: decimal_2
  }

# measure duplicates of the dimensional values - treated as averages - hidden in visual
  measure: m_fake_reading1 {
    view_label: "Z) Fake Readings"
    group_label: "Reading 1"
    label: "M Fake Reading 1"
    type: average
    sql: ${fake_reading1} ;;
    value_format_name: decimal_2
  }

  measure: m_fake_reading2 {
    view_label: "Z) Fake Readings"
    group_label: "Reading 2"
    label: "M Fake Reading 2"
    type: average
    sql: ${fake_reading2} ;;
    value_format_name: decimal_2
  }

  measure: m_fake_reading3 {
    view_label: "Z) Fake Readings"
    group_label: "Reading 3"
    label: "M Fake Reading 3"
    type: average
    sql: ${fake_reading3} ;;
    value_format_name: decimal_2
  }

# defining my high normal and low thresholds for each reading (note that these use the dimensional values - thats important)
  dimension: reading1_thresholds {
    view_label: "Z) Fake Readings"
    type: string
    sql: CASE WHEN ${fake_reading1} >= 2000 THEN 'High'
              WHEN ${fake_reading1} < 200 THEN 'Low'
              ELSE 'Normal' END;;
  }
  dimension: reading2_thresholds {
    view_label: "Z) Fake Readings"
    type: string
    sql: CASE WHEN ${fake_reading2} >= 100 THEN 'High'
              WHEN ${fake_reading2} < 10 THEN 'Low'
              ELSE 'Normal' END;;
  }
  dimension: reading3_thresholds {
    view_label: "Z) Fake Readings"
    type: string
    sql: CASE WHEN ${fake_reading3} >= 100 THEN 'High'
              WHEN ${fake_reading3} < 10 THEN 'Low'
              ELSE 'Normal' END;;
  }


# Filtered measures for high, normal, and low readings - these are the scatter plot dots that get color coordinated
  measure: m_fake_reading1_high {
    group_label: "Reading 1"
    view_label: "Z) Fake Readings"
    label: "Reading 1 High"
    type: average
    sql: ${fake_reading1} ;;
    value_format_name: decimal_2
    filters: [reading1_thresholds: "High"]
  }

  measure: m_fake_reading1_Normal {
    group_label: "Reading 1"
    view_label: "Z) Fake Readings"
    label: "Reading 1 Normal"
    type: average
    sql: ${fake_reading1} ;;
    value_format_name: decimal_2
    filters: [reading1_thresholds: "Normal"]
  }

  measure: m_fake_reading1_Low {
    group_label: "Reading 1"
    view_label: "Z) Fake Readings"
    label: "Reading 1 Low"
    type: average
    sql: ${fake_reading1} ;;
    value_format_name: decimal_2
    filters: [reading1_thresholds: "Low"]
  }

  measure: m_fake_reading2_high {
    group_label: "Reading 2"
    view_label: "Z) Fake Readings"
    label: "Reading 2 High"
    type: average
    sql: ${fake_reading2} ;;
    value_format_name: decimal_2
    filters: [reading2_thresholds: "High"]
  }

  measure: m_fake_reading2_Normal {
    group_label: "Reading 2"
    view_label: "Z) Fake Readings"
    label: "Reading 2 Normal"
    type: average
    sql: ${fake_reading2} ;;
    value_format_name: decimal_2
    filters: [reading2_thresholds: "Normal"]
  }

  measure: m_fake_reading2_Low {
    group_label: "Reading 2"
    view_label: "Z) Fake Readings"
    label: "Reading 2 Low"
    type: average
    sql: ${fake_reading2} ;;
    value_format_name: decimal_2
    filters: [reading2_thresholds: "Low"]
  }

  measure: m_fake_reading3_high {
    group_label: "Reading 3"
    view_label: "Z) Fake Readings"
    label: "Reading 3 High"
    type: average
    sql: ${fake_reading3} ;;
    value_format_name: decimal_2
    filters: [reading3_thresholds: "High"]
  }

  measure: m_fake_reading3_Normal {
    group_label: "Reading 3"
    view_label: "Z) Fake Readings"
    label: "Reading 3 Normal"
    type: average
    sql: ${fake_reading3} ;;
    value_format_name: decimal_2
    filters: [reading3_thresholds: "Normal"]
  }

  measure: m_fake_reading3_Low {
    group_label: "Reading 3"
    view_label: "Z) Fake Readings"
    label: "Reading 3 Low"
    type: average
    sql: ${fake_reading3} ;;
    value_format_name: decimal_2
    filters: [reading3_thresholds: "Low"]
  }

  #table calculation to get the mean we want (apply in table calcs at the explore level)
  # if(row()= 1 OR row() =  max(row()),  mean(${order_items.m_fake_reading1}),null)

  #advanced statistics -  used in stats summary visualizations

  measure: mean_fake_reading1 {
    view_label: "Z) Fake Readings"
    group_label: "Advanced Statistics"
    label: "Reading 1 (Mean)"
    type: average
    sql: ${fake_reading1} ;;
    value_format_name: decimal_2
  }

  measure: min_fake_reading1 {
    view_label: "Z) Fake Readings"
    group_label: "Advanced Statistics"
    label: "Reading 1 (Min)"
    type: min
    sql: ${fake_reading1} ;;
    value_format_name: decimal_2
  }

  measure: 25th_fake_reading1 {
    view_label: "Z) Fake Readings"
    group_label: "Advanced Statistics"
    label: "Reading 1 (25th Percentile)"
    type: percentile
    percentile: 25
    sql: ${fake_reading1} ;;
    value_format_name: decimal_2
  }

  measure: Median_fake_reading1 {
    view_label: "Z) Fake Readings"
    group_label: "Advanced Statistics"
    label: "Reading 1 (Median)"
    type: median
    sql: ${fake_reading1} ;;
    value_format_name: decimal_2
  }

  measure: 75th_fake_reading1 {
    view_label: "Z) Fake Readings"
    group_label: "Advanced Statistics"
    label: "Reading 1 (75th Percentile)"
    type: percentile
    percentile: 75
    sql: ${fake_reading1} ;;
    value_format_name: decimal_2
  }

  measure: max_fake_reading1 {
    view_label: "Z) Fake Readings"
    group_label: "Advanced Statistics"
    label: "Reading 1 (Max)"
    type: max
    sql: ${fake_reading1} ;;
    value_format_name: decimal_2
  }

  measure: mean_fake_reading2 {
    view_label: "Z) Fake Readings"
    group_label: "Advanced Statistics"
    label: "Reading 2 (Mean)"
    type: average
    sql: ${fake_reading2} ;;
    value_format_name: decimal_2
  }

  measure: min_fake_reading2 {
    view_label: "Z) Fake Readings"
    group_label: "Advanced Statistics"
    label: "Reading 2 (Min)"
    type: min
    sql: ${fake_reading2} ;;
    value_format_name: decimal_2
  }

  measure: 25th_fake_reading2 {
    view_label: "Z) Fake Readings"
    group_label: "Advanced Statistics"
    label: "Reading 2 (25th Percentile)"
    type: percentile
    percentile: 25
    sql: ${fake_reading2} ;;
    value_format_name: decimal_2
  }

  measure: Median_fake_reading2 {
    view_label: "Z) Fake Readings"
    group_label: "Advanced Statistics"
    label: "Reading 2 (Median)"
    type: median
    sql: ${fake_reading2} ;;
    value_format_name: decimal_2
  }

  measure: 75th_fake_reading2 {
    view_label: "Z) Fake Readings"
    group_label: "Advanced Statistics"
    label: "Reading 2 (75th Percentile)"
    type: percentile
    percentile: 75
    sql: ${fake_reading2} ;;
    value_format_name: decimal_2
  }

  measure: max_fake_reading2 {
    view_label: "Z) Fake Readings"
    group_label: "Advanced Statistics"
    label: "Reading 2 (Max)"
    type: max
    sql: ${fake_reading2} ;;
    value_format_name: decimal_2
  }

  measure: mean_fake_reading3 {
    view_label: "Z) Fake Readings"
    group_label: "Advanced Statistics"
    label: "Reading 3 (Mean)"
    type: average
    sql: ${fake_reading3} ;;
    value_format_name: decimal_2
  }

  measure: min_fake_reading3 {
    view_label: "Z) Fake Readings"
    group_label: "Advanced Statistics"
    label: "Reading 3 (Min)"
    type: min
    sql: ${fake_reading3} ;;
    value_format_name: decimal_2
  }

  measure: 25th_fake_reading3 {
    view_label: "Z) Fake Readings"
    group_label: "Advanced Statistics"
    label: "Reading 3 (25th Percentile)"
    type: percentile
    percentile: 25
    sql: ${fake_reading3} ;;
    value_format_name: decimal_2
  }

  measure: Median_fake_reading3 {
    view_label: "Z) Fake Readings"
    group_label: "Advanced Statistics"
    label: "Reading 3 (Median)"
    type: median
    sql: ${fake_reading3} ;;
    value_format_name: decimal_2
  }

  measure: 75th_fake_reading3 {
    view_label: "Z) Fake Readings"
    group_label: "Advanced Statistics"
    label: "Reading 3 (75th Percentile)"
    type: percentile
    percentile: 75
    sql: ${fake_reading3} ;;
    value_format_name: decimal_2
  }

  measure: max_fake_reading3 {
    view_label: "Z) Fake Readings"
    group_label: "Advanced Statistics"
    label: "Reading 3 (Max)"
    type: max
    sql: ${fake_reading3} ;;
    value_format_name: decimal_2
  }

}
