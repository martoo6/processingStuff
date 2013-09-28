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
 * Like server-side script
 * Handles requests from the Like Java class
*/

// SQL and other constants, db functions
include_once("config.php");
include_once("db.php");

// Header
header("Content-Type : text/plain");

// Fetching POSTs parameters - note that intval() prevents from having any SQL injection, as $mark and $pollId will be integers
if (!isset($_POST["mode"]) || !isset($_POST["id"])) die(ERROR);
$pollId = intval($_POST["id"]);
$mode = $_POST["mode"];

// Getting PDO
$pdo = getPDO();
if (!$pdo) die(ERROR);

// VOTE MODE
if ($mode==="vote") {

	// Fetching vote parameter
	$mark = intval($_POST["mark"]);

	// Request parameters checking - 0 means we had a problem parsing integers so it's an error - 
	if ($mark != 0 && $mark >=1 && $mark <= 9 && $pollId != 0) {

		// Checking force Id
		if (LIKE_FORCE_ID != 0 && $pollId != LIKE_FORCE_ID) die(ERROR);
	
		// Vote
		like_vote($pdo, $pollId, $mark);
		
		// Prints out the average with echo
		echo like_average($pdo, $pollId);

	} else {
		die(ERROR);
	}
	
// READ AVERAGE MODE	
} else if ($mode === "average") {
	
	// Request parameters checking - 0 means we had a problem parsing integers so it's an error - 
	if ($pollId != 0) {

		// Checking force Id
		if (LIKE_FORCE_ID != 0 && $pollId != LIKE_FORCE_ID) die(ERROR);
		
		// Prints out the average
		echo like_average($pdo, $pollId);
		
	} else die(ERROR);
	
} else die(ERROR);



?>