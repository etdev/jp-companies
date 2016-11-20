/* vorkers_entries table schema  */
CREATE TABLE `vorkers_entries` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `company_id` int unsigned,
  `vorkers_id` varchar(128) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  `rating` decimal(3, 2) unsigned NOT NULL DEFAULT 0,
  `ratings_count` int unsigned NOT NULL DEFAULT 0,
  `monthly_overtime` decimal(5, 2) unsigned NOT NULL DEFAULT 0 COMMENT 'average overtime hours per month',
  `percent_vacation_used` decimal(5, 2) unsigned NOT NULL DEFAULT 0 COMMENT 'average percentage of vacation time used',
  `category` varchar(255) NOT NULL DEFAULT '',
  `thumbnail_url` varchar(255) NOT NULL DEFAULT '',
  `stock_info` varchar(255) NOT NULL DEFAULT '' COMMENT 'info about stock for public companies',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY idx_company_id (`company_id`),
  UNIQUE KEY idx_vorkers_id (`vorkers_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
