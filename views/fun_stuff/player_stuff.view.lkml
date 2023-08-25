include: "/views/02_users.view.lkml"
view: +users {
  dimension: dummy_row {
    view_label: "Z) Testing player stuff"
    type: number
    sql: 1 ;;
  }

  parameter: player_name_selector {
    view_label: "Z) Testing player stuff"
    type: string
    # default_value: "Aaron Aguilar"
  }

  dimension: highlighted_players_and_others {
    view_label: "Z) Testing player stuff"
    type: string
    sql:  CASE
              WHEN ${name} = {% parameter player_name_selector %}
              THEN '1) Selected Player' ELSE ${name}
          END ;;
  }

}
