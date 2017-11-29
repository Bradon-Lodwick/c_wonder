-- View 1
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`%` 
    SQL SECURITY DEFINER
VIEW `items_in_kits_vs_individual` AS
    SELECT 
        `i`.`name` AS `item`,
        (SUM(`ki`.`quantity`) * `k`.`quantity`) AS `items_in_kits`,
        (`i`.`quantity` - (SUM(`ki`.`quantity`) * `k`.`quantity`)) AS `available_as_individual`
    FROM
        ((`Items` `i`
        JOIN `Kit_Contents` `ki` ON ((`ki`.`item` = `i`.`name`)))
        JOIN `Kits` `k` ON ((`k`.`kit_name` = `ki`.`kit_name`)))
    GROUP BY `i`.`name`;
    
-- View 2
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`%` 
    SQL SECURITY DEFINER
VIEW `workshops_kit_info` AS
    SELECT 
        `Workshop_Contents`.`workshop_id` AS `workshop_id`,
        `Workshop_Contents`.`kit_name` AS `kit_name`,
        `Workshop_Contents`.`quantity` AS `quantity`
    FROM
        `Workshop_Contents`
    WHERE
        `Workshop_Contents`.`kit_name` IN (SELECT 
                `Kits`.`kit_name`
            FROM
                `Kits`);
                
-- View 3
-- NOTE a workaround had to be made in that the correlated sub-querry is on a second view, called workshop_items_ungrouped
-- This is because of MySQL's restriction on using subqueries in view definitions
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`%` 
    SQL SECURITY DEFINER
VIEW `workshop_items_grouped` AS
    SELECT 
        `workshop_items_ungrouped`.`workshop_id` AS `workshop_id`,
        `workshop_items_ungrouped`.`item_Name` AS `item_name`,
        SUM(`workshop_items_ungrouped`.`quantity`) AS `quantity`
    FROM
        `workshop_items_ungrouped`
    GROUP BY `workshop_items_ungrouped`.`workshop_id` , `workshop_items_ungrouped`.`item_Name`;


-- View 4
-- NOTE a workaround had to be made to do a full join, as MySQL does not have full joins
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`%` 
    SQL SECURITY DEFINER
VIEW `data_dump` AS
    SELECT 
        `wc`.`workshop_id` AS `workshop_id`,
        `i`.`name` AS `name`,
        `i`.`quantity` AS `total_available_of_item`,
        `k`.`kit_name` AS `kit_name`,
        `k`.`quantity` AS `total_available_of_kit`,
        `wc`.`quantity` AS `used_in_workshop`
    FROM
        ((`Workshop_Contents` `wc`
        LEFT JOIN `Items` `i` ON ((`i`.`name` = `wc`.`item_name`)))
        LEFT JOIN `Kits` `k` ON ((`k`.`kit_name` = `wc`.`kit_name`))) 
    UNION SELECT 
        `wc`.`workshop_id` AS `workshop_id`,
        `i`.`name` AS `name`,
        `i`.`quantity` AS `total_available_of_item`,
        `k`.`kit_name` AS `kit_name`,
        `k`.`quantity` AS `total_available_of_kit`,
        `wc`.`quantity` AS `used_in_workshop`
    FROM
        (`Kits` `k`
        LEFT JOIN (`Items` `i`
        LEFT JOIN `Workshop_Contents` `wc` ON ((`i`.`name` = `wc`.`item_name`))) ON ((`k`.`kit_name` = `wc`.`kit_name`)));
        
-- View 5
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`%` 
    SQL SECURITY DEFINER
VIEW `workshop_items_ungrouped` AS
    SELECT 
        `Workshop_Contents`.`workshop_id` AS `workshop_id`,
        `Workshop_Contents`.`item_name` AS `item_Name`,
        `Workshop_Contents`.`quantity` AS `quantity`
    FROM
        `Workshop_Contents`
    WHERE
        (`Workshop_Contents`.`item_name` IS NOT NULL) 
    UNION SELECT 
        `w`.`workshop_id` AS `Workshop_id`,
        `k`.`item` AS `item`,
        (`w`.`quantity` * `k`.`quantity`) AS `w.quantity * k.Quantity`
    FROM
        (`Workshop_Contents` `w`
        JOIN `Kit_Contents` `k` ON ((`k`.`kit_name` = `w`.`kit_name`)))
    WHERE
        (`w`.`kit_name` IS NOT NULL);
        
-- View 6
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`%` 
    SQL SECURITY DEFINER
VIEW `workshops_overusing_inventory` AS
    SELECT 
        `w`.`workshop_id` AS `workshop_id`,
        `w`.`item_name` AS `item_Name`,
        `w`.`quantity` AS `workshop_Quantity`,
        `i`.`quantity` AS `available`,
        (`w`.`quantity` - `i`.`quantity`) AS `items_Short`
    FROM
        (`workshop_items_grouped` `w`
        JOIN `Items` `i` ON ((`i`.`name` = `w`.`item_name`)))
    WHERE
        ((`i`.`quantity` - `w`.`quantity`) < 0);
        
-- View 7
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`%` 
    SQL SECURITY DEFINER
VIEW `workshops_underusing_inventory` AS
    SELECT 
        `w`.`workshop_id` AS `workshop_id`,
        `w`.`item_name` AS `item_Name`,
        `w`.`quantity` AS `workshop_Quantity`,
        `i`.`quantity` AS `available`,
        (`i`.`quantity` - `w`.`quantity`) AS `items_left`
    FROM
        (`workshop_items_grouped` `w`
        JOIN `Items` `i` ON ((`i`.`name` = `w`.`item_name`)))
    WHERE
        ((`i`.`quantity` - `w`.`quantity`) > 0);
        
-- View 8
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`%` 
    SQL SECURITY DEFINER
VIEW `all_items_and_workshops` AS
    SELECT 
        `w`.`workshop_id` AS `Workshop_id`,
        `w`.`item_name` AS `Item_Name`,
        `w`.`quantity` AS `required_for_workshop`,
        `i`.`name` AS `name`
    FROM
        (`workshop_items_grouped` `w`
        LEFT JOIN `Items` `i` ON ((`i`.`name` = `w`.`item_name`))) 
    UNION SELECT 
        `w`.`workshop_id` AS `Workshop_id`,
        `w`.`item_name` AS `Item_Name`,
        `w`.`quantity` AS `Quantity`,
        `i`.`name` AS `name`
    FROM
        (`Items` `i`
        LEFT JOIN `workshop_items_grouped` `w` ON ((`i`.`name` = `w`.`item_name`)));
        
-- View 9
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`%` 
    SQL SECURITY DEFINER
VIEW `needed_items_for_kits` AS
    SELECT 
        `Items`.`name` AS `name`
    FROM
        `Items`
    WHERE
        `Items`.`name` IN (SELECT 
                `items_in_kits_vs_individual`.`item`
            FROM
                `items_in_kits_vs_individual`
            WHERE
                (`items_in_kits_vs_individual`.`available_as_individual` < 0));
                
-- View 10
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`%` 
    SQL SECURITY DEFINER
VIEW `total_items` AS
    SELECT 
        `workshop_items_grouped`.`workshop_id` AS `workshop_id`,
        SUM(`workshop_items_grouped`.`quantity`) AS `total_items`
    FROM
        `workshop_items_grouped`
    GROUP BY `workshop_items_grouped`.`workshop_id`;