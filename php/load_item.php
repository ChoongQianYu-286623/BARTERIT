<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

if (isset($_POST['userid'])){
	$userid = $_POST['userid'];	
	$sqlloaditem = "SELECT * FROM `tbl_items` WHERE  user_id = '$userid'";
}
else{
	$sqlloaditem = "SELECT * FROM `tbl_items`";
}

$result = $conn->query($sqlloaditem);
if ($result->num_rows > 0) {
    $item["item"] = array();
	while ($row = $result->fetch_assoc()) {
        $itemlist = array();
        $itemlist['item_id'] = $row['item_id'];
        $itemlist['user_id'] = $row['user_id'];
        $itemlist['item_name'] = $row['item_name'];
        $itemlist['item_type'] = $row['item_type'];
        $itemlist['item_desc'] = $row['item_desc'];
        $itemlist['item_price'] = $row['item_price'];
        $itemlist['item_qty'] = $row['item_qty'];
        $itemlist['user_lat'] = $row['user_lat'];
        $itemlist['user_long'] = $row['user_long'];
        $itemlist['user_state'] = $row['user_state'];
        $itemlist['user_locality'] = $row['user_locality'];
		$itemlist['insert_date'] = $row['insert_date'];
        array_push($item["item"],$itemlist);
    }
    $response = array('status' => 'success', 'data' => $item);
    sendJsonResponse($response);
}else{
     $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}
function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>