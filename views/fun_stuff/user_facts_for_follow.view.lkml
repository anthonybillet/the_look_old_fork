view: user_facts_for_follow {
  derived_table: {
    sql: SELECT
          users.id  AS users_id,
          COUNT(*) AS order_items_count
      FROM looker-private-demo.ecomm.order_items  AS order_items
      LEFT JOIN looker-private-demo.ecomm.users  AS users ON order_items.user_id = users.id
      GROUP BY
          1
      ORDER BY
          2 DESC
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: users_id {
    type: number
    sql: ${TABLE}.users_id ;;
  }

  dimension: order_items_count {
    type: number
    sql: ${TABLE}.order_items_count ;;
  }

  dimension: order_items_count_tiered {
    type: tier
    tiers: [0,5,10,15]
    sql: ${order_items_count} ;;
    style: integer
  }

  set: detail {
    fields: [users_id, order_items_count]
  }
}
