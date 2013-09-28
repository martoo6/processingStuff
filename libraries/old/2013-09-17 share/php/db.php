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
 * SQL database handling.
* Methods for reading / writing data from / to the database.
*/

include_once("config.php");

/** Common function to connect to the database
 *
 */
function getPDO() {

	$pdo = new PDO(SQL_HOST, SQL_USER, SQL_PASS);
	if (!$pdo) die(ERROR);
	
	return $pdo;

}

/** Like function to vote - returns the rounded average
 *
 */
function like_vote(PDO $pdo, $pollId, $mark) {
	// Checking if it is the first vote from this IP for this id
	$request = $pdo->prepare("SELECT * FROM ".LIKE_TABLE." WHERE id=:pollid AND ip=:ip");
	if (!$request) die(ERROR);

	$request->bindParam(":pollid", $pollId, PDO::PARAM_INT);
	$request->bindParam(":ip", $_SERVER["REMOTE_ADDR"], PDO::PARAM_STR);

	if (!$request->execute()) die(ERROR);

	if (count($request->fetchAll()) === 0) {
		$insert = $pdo->prepare("INSERT INTO ".LIKE_TABLE." SET ip=:ip, id=:pollid, mark=:mark");
		if (!$insert) die(ERROR);
			
		$insert->bindParam(":ip", $_SERVER["REMOTE_ADDR"], PDO::PARAM_STR);
		$insert->bindParam(":pollid", $pollId, PDO::PARAM_INT);
		$insert->bindParam(":mark", $mark, PDO::PARAM_INT);
		if (!$insert->execute()) die(ERROR);
	} else die(ERROR);

}

/** Like function to get the average
 *
 */
function like_average(PDO $pdo, $pollId) {

	$request = $pdo->prepare("SELECT avg(mark) AS mean FROM ".LIKE_TABLE." WHERE id=:pollid");
	$request->bindParam(":pollid",$pollId, PDO::PARAM_INT);
	if (!$request->execute()) die (ERROR);
	else {
		$mean = $request->fetch();
		return $mean["mean"];
	}

}

/**
 * Talk function to fetch messages
 */
function talk_fetch(PDO $pdo, $talkId) {

	$request = $pdo->prepare("SELECT id, message FROM ".TALK_TABLE." WHERE talk_id=:talkid ORDER BY id");
	if (!$request) die(ERROR);

	$request->bindParam(":talkid", $talkId, PDO::PARAM_INT);
	if (!$request->execute()) die(ERROR);

	$messages = $request->fetchAll();
	$out = "";
	foreach ($messages as $message) {
		$out .= $message["message"]."\n";
	}

	return $out;

}

/**
 * Talk function to post a message
 */
function talk_post(PDO $pdo, $talkId, $message) {

	$request = $pdo->prepare("INSERT INTO ".TALK_TABLE." SET talk_id=:talkid, message=:message");
	if (!$request) die(ERROR);

	$request->bindParam(":talkid", $talkId, PDO::PARAM_INT);
	$request->bindParam(":message", $message, PDO::PARAM_STR);

	if (!$request->execute()) die(ERROR);

	return true;
}


?>