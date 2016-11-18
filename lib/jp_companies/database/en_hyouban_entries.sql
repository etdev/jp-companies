/* en_hyouban_entries table schema  */
CREATE TABLE `en_hyouban_entries` (
  `id` int(8) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` int(8) unsigned,
  `en_hyouban_id` int(8) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `average_salary`int(8) unsigned NOT NULL DEFAULT 0,
  `location` varchar(255) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  `rating` decimal(3, 2) NOT NULL DEFAULT 0,
  `ratings_count` int(8) unsigned NOT NULL DEFAULT 0,
  `daily_hours_worked` varchar(255) NOT NULL DEFAULT '',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY idx_company_id (`company_id`),
  UNIQUE KEY idx_en_hyouban_id (`en_hyouban_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
