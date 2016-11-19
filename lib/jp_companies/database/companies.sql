/* companies table schema  */
CREATE TABLE `companies` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Company name English',
  `name_jp` varchar(255) NOT NULL DEFAULT '' COMMENT 'Company name Japanese',
  `name_kana` varchar(255) NOT NULL DEFAULT '' COMMENT 'Company name Katakana',
  `employees_count` int NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY idx_name (`name`),
  UNIQUE KEY idx_name_kana (`name_kana`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
