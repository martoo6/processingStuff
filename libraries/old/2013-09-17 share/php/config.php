<?php
/* This file is a part of the Share library.
 *
 * Share is a Processing library written by Nucky (http://www.nucky.io).
 * 
 * This software is distributed under the GNU GPL 3 license (http://www.gnu.org/licenses/gpl.html).
 * Share is provided "as is", with no warranty of any kind.
 * It should be used with Processing. Processing core library is under GNU LGPL license.
*/

// SQL keys
define("SQL_HOST", "mysql:host=localhost;dbname=share"); // Your MySQL database host
define("SQL_USER", "user"); // Your MySQL username
define("SQL_PASS", "pass"); // Your MySQL password

define("ERROR", "ERR"); // Response string when an error occurs
define("SUCCESS", "OK"); // Response string on success

// Used for the "Like" object
define("LIKE_TABLE", "likes"); // Ranking table name, used for Like
define("LIKE_FORCE_ID", 0); // Force all the ranking to a specific rank ID - 0 for any id

// Used for the "Talk" object
define("TALK_TABLE", "talks"); // Messages table name, used for Talk
define("TALK_FORCE_ID", 0); // Force all the messages to a specific talk ID - 0 for any id

?>