/* companies table schema  */
CREATE TABLE `companies` (
  `id` int(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT='Company name English',
  `name_jp` varchar(255) NOT NULL DEFAULT '' COMMENT='Company name Japanese',
  `name_kana` varchar(255) NOT NULL DEFAULT '' COMMENT='Company name Katakana'
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `name_en` (`name_en`),
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
