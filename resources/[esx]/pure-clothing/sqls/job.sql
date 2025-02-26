CREATE TABLE IF NOT EXISTS `clothing_job_outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) NOT NULL,
  `modelHash` text NOT NULL,
  `name` text NOT NULL,
  `outfit` text NOT NULL,
  `jobName` varchar(255) DEFAULT NULL,
  `minRank` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;