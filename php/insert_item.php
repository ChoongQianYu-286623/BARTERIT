<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$userid = $_POST['userid'];
$item_name = $_POST['itemname'];
$item_desc = $_POST['itemdesc'];
$item_type = $_POST['itemtype'];
$item_price = $_POST['itemprice'];
$item_qty = $_POST['itemqty'];
$latitude = $_POST['latitude'];
$longitude = $_POST['longitude'];
$state = $_POST['state'];
$locality = $_POST['locality'];

$images = json_decode($_POST['images']);

$sqlinsert = "INSERT INTO `tbl_items`(`user_id`,`item_name`, `item_desc`,`item_price`, `item_qty`, `item_type`,`user_lat`, `user_long`, `user_state`, `user_locality`) VALUES ('$userid','$item_name','$item_desc','$item_price','$item_qty','$item_type','$latitude','$longitude','$state','$locality')";

if ($conn->query($sqlinsert) === TRUE) {

    foreach ($images as $index => $base64Image) {
	    $imageData = base64_decode($base64Image);
	    $filename = mysqli_insert_id($conn);
	    $path = '../assets/item_list/'.$filename.'.png';
	    file_put_contents($path, $imageData);
	}
	$response = array('status' => 'success', 'data' => null);
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