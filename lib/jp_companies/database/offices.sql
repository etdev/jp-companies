/* offices table schema  */
CREATE TABLE `offices` (
  `id` int(8) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` int(8) unsigned NOT NULL,
  `country` varchar(255) NOT NULL DEFAULT '',
  `city` varchar(255) NOT NULL DEFAULT '',
  `detail` varchar(255) NOT NULL DEFAULT '' COMMENT 'e.g. building name',
  `floor` int(8) unsigned NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY idx_company_id (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
