/* vorkers_entries table schema  */
CREATE TABLE `vorkers_entries` (
  `id` int(8) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` int(8) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
