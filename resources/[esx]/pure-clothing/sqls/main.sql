CREATE TABLE IF NOT EXISTS `clothing_outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) NOT NULL,
  `modelHash` text NOT NULL,
  `name` text NOT NULL,
  `outfit` text NOT NULL,
  `uniqueOutfitid` text,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci ROW_FORMAT=DYNAMIC;

-- Data exporting was unselected.

-- Dumping structure for table qbcore.clothing_skins
CREATE TABLE IF NOT EXISTS `clothing_skins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) NOT NULL,
  `faceFeatures` text NOT NULL,
  `hair` text NOT NULL,
  `clothing` text NOT NULL,
  `tattoos` text NOT NULL,
  `model` text NOT NULL,
  `modelHash` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;