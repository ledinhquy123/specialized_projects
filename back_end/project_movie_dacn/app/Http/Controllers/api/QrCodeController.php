<?php

namespace App\Http\Controllers\api;

use App\Http\Controllers\Controller;
use App\Models\Ticket;
use Illuminate\Support\Facades\View;
use Illuminate\Http\Request;
use SimpleSoftwareIO\QrCode\Facades\QrCode;

class QrCodeController extends Controller
{
  public function createQrCodeTicket($id) {
    $ticket = Ticket::find($id);
    return view('qrcode', compact([
      'ticket',
    ]));
  }
}
