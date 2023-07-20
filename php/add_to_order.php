<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$order_bill = rand(100000,999999);
$userid = $_POST['userid'];
$sellerid = $_POST['sellerid'];
$orderpaid = $_POST['orderpaid'];
$itemid = $_POST['itemid'];
$orderqty = $_POST['cartqty'];

//$seller = "";
//$singleorder = 0;
//$i =0;
//$numofrows = $result->num_rows;

$sqlinsert = "INSERT INTO `tbl_orders`(`order_bill`, `user_id`, `seller_id`, `order_paid`) VALUES ('$order_bill','$userid','$sellerid','$orderpaid')";


$sqlupdateitemqty = "UPDATE `tbl_items` SET `item_qty`= (item_qty - $orderqty) WHERE `item_id` = '$itemid'";
                
$sqldeletecart = "DELETE FROM `tbl_carts` WHERE user_id = '$userid'";
$sqlorderdetails = "INSERT INTO `tbl_orderdetails`(`item_id`, `order_bill`, `orderdetails_qty`, `orderdetails_paid`, `buyer_id`, `seller_id`) VALUES ('$itemid','$order_bill','$orderqty','$orderpaid','$userid','$sellerid')";


				
if ($conn->query($sqlinsert) === TRUE) {
    $response = array('status' => 'success', 'data' => $sqlinsert);
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'data' => $sqlinsert);
    sendJsonResponse($response);
}

$conn->query($sqlorderdetails);
$conn->query($sqlupdateitemqty);
$conn->query($sqldeletecart);

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>