include: "/views/02_users.view.lkml"
view: +users {
  dimension: is_male {
    view_label: "Z)Is Big Payer"
    label: "Is Big Payer"
    type: yesno
    sql: ${gender} = 'Male' ;;
  }

  dimension: is_top_10_user_by_sales {
    view_label: "Z)Is Big Payer"
    type: yesno
    sql: ${id} IN (SELECT users_id
                    FROM (SELECT
                              users.id  AS users_id,
                              COALESCE(SUM(order_items.sale_price ), 0) AS order_items_total_sale_price
                          FROM looker-private-demo.ecomm.order_items  AS order_items
                          LEFT JOIN looker-private-demo.ecomm.users  AS users ON order_items.user_id = users.id
                          GROUP BY
                              1
                          ORDER BY
                              2 DESC
                          LIMIT 10)
                          );;
  }
}
