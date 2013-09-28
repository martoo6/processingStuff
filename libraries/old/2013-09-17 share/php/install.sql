-- This file is a part of the Share library.
-- Share is a Processing library written by Nucky (http://www.nucky.io).
-- This software is distributed under the GNU GPL 3 license (http://www.gnu.org/licenses/gpl.html).
-- Share is provided "as is", with no warranty of any kind.
-- It should be used with Processing. Processing core library is under GNU LGPL license.

-- `likes` table structure
CREATE TABLE  `likes` (
`ip` VARCHAR( 255 ) NOT NULL ,
`id` INT NOT NULL ,
`mark` INT NOT NULL ,
UNIQUE (
`ip`
)
) ENGINE = MYISAM  DEFAULT CHARSET=latin1 ;


-- `talks` table structure
CREATE TABLE `talks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `talk_id` int(11) NOT NULL,
  `message` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;