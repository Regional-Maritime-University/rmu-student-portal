<?php
session_start();

require_once('../bootstrap.php');
require_once('../src/Gateway/PaymentGateway.php');
require_once('../src/Controller/VoucherPurchase.php');

use Src\Controller\PaymentGateway;
use Src\Controller\VoucherPurchase;

/*if (isset($_GET['status']) && !empty($_GET['status']) && $_GET['status'] == 'cancelled') {
    echo 'Payment processing was cancelled';
    //header('Location: purchase_step1.php?status=cancelled');
} elseif (isset($_GET['status']) && !empty($_GET['status']) && $_GET['status'] == 'successful') {
    $transRef = $_GET['tx_ref'];
    $transID = $_GET['transaction_id'];

    $secretKey = getenv('SECRET_KEY');
    $payUrl = "https://api.flutterwave.com/v3/transactions/{$transID}/verify";
    $request = 'GET';

    try {
        $pay = new PaymentGateway($secretKey, $payUrl, $request, array());
        $response = json_decode($pay->initiatePayment());
        if ($response->status == 'success') {
            if ($response->data->meta->price >= $response->data->charged_amount && $response->data->processor_response == 'successful') {
                echo 'Payment was successful!<br><hr><br>';

                $voucher = new VoucherPurchase();
                if ($voucher->createApplicant($_SESSION)) {
                    echo '<span style="color:red;"><b>Please do not close this page yet.</b></span><br><br>';
                    echo 'An email with your <b>Application Number</b> and <b>PIN Code</b> and has been sent to you!<br>';
                    echo 'Please confirm and proceed to the <a href="../apply"><b>online applicatioin portal</b></a> to complete your application process.<br>';
                    //echo 'Or <a href="resend.php?link=' . sha1(md5($url)) . '">Resend</a> <b>Application Number</b> and <b>PIN Code</b> if not received.';
                    //header('Location: purchase_step1.php?status=success');
                }
            }
        } else {
            //code
        }

        //print_r(json_encode($response));
    } catch (\Exception $e) {
        throw $e;
    }
}*/

//PaymentGateway::destroyAllSessions(); //Kill all sessions