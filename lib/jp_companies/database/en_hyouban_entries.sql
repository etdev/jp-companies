/* en_hyouban_entries table schema  */
CREATE TABLE `en_hyouban_entries` (
  `id` int(8) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` int(8) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY (`company_id`),
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
