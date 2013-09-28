<?php
/* This file is a part of the Share library.
 *
 * Share is a Processing library written by Nucky (http://www.nucky.io).
 * 
 * This software is distributed under the GNU GPL 3 license (http://www.gnu.org/licenses/gpl.html).
 * Share is provided "as is", with no warranty of any kind.
 * It should be used with Processing. Processing core library is under GNU LGPL license.
*/

/*
 * Talk server-side script
 * Handles requests from the Talk Java class
*/

// SQL Config and so ...
include_once("config.php");
include_once("db.php");

// Header
header("Content-Type : text/plain");

// Getting mode and talk id
if (!isset($_POST["mode"]) || !isset($_POST["talkId"])) die(ERROR);
$mode = $_POST["mode"];
$talkId = intval($_POST["talkId"]);

// Getting PDO
$pdo = getPDO();
if (!$pdo) die(ERROR);

// FETCH MODE
if ($mode === "fetch") {
	
	// Checking ID
	if ($talkId != 0) {
		
		// Checking force id
		if (TALK_FORCE_ID != $talkId && TALK_FORCE_ID != 0) die(ERROR);

		
		// Fetching
		echo talk_fetch($pdo, $talkId);
		
	}

	
// POST MODE	
} else if ($mode === "post" && isset($_POST["message"])) {
	
	// Getting post parameter
	$message = $_POST["message"];
	
	// Checking IDs
	if ($talkId != 0) {
		
		// Checking force id
		if (TALK_FORCE_ID != $talkId && TALK_FORCE_ID != 0) die(ERROR);
		
		// Posting
		if (talk_post($pdo, $talkId, $message)) echo(SUCCESS); // prints 1 so the client knows we have it
		
	} else die(ERROR);
	
} else die(ERROR);


?>