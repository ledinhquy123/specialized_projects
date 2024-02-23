<?php

namespace App\Http\Controllers\api;

use App\Http\Controllers\Controller;
use App\Models\Ticket;
use App\Models\Transaction;
use Illuminate\Http\Request;

class TransactionController extends Controller
{
    public function index() {
        $transactions = Transaction::all();
        return response()->json($transactions);
    }
    
    public function createTicket(Request $request) {
        $user_id = $request->user_id;
        $screen_name = $request->screen_name;
        $seats_name = $request->seats_name;
        $movie_id = $request->movie_id;
        $showdate = $request->showdate; 
        $show_time = $request->show_time;
        $total_price = $request->total_price;
        $transaction_type_id = $request->transaction_type_id;

        $ticket = new Ticket;
        $ticket->user_id = $user_id;
        $ticket->screen_name =  $screen_name;
        $ticket->movie_id =  $movie_id;
        $ticket->seats_name = $seats_name;
        $ticket->showdate = $showdate; 
        $ticket->show_time = $show_time;
        $ticket->total_price = $total_price;
        $ticket->transaction_type_id = $transaction_type_id;
        $ticket->save();
        
        $ticket->qr_path = url('api/qrcodes/create-qrcode-ticket/' . $ticket->id);
        $ticket->save();
        return response()->json([
            'ticket' => $ticket
        ]);
    }

    public function getAllTickets() {
        $tickets = Ticket::all();
        foreach($tickets as $ticket) {
            $data[] = [
                "id" => $ticket->id,
                "user_id" => $ticket->user_id,
                "user_name" => $ticket->user->name,
                "movie_id" => $ticket->movie_id,
                "movie_name" => $ticket->movie->title,
                "screen_name" => $ticket->screen_name,
                "seats_name" => $ticket->seats_name,
                "showdate" => $ticket->showdate,
                "show_time" => $ticket->show_time,
                "qr_path" => $ticket->qr_path,
            ];
        }
        return response()->json([
            'data' => $data
        ]);
    }

    public function getTicketFollowUser($userId) {
        $tickets = Ticket::where('user_id', $userId)->get();
        if($tickets->count() > 0) {
            foreach($tickets as $ticket) {
                $data[] = [
                    "id" => $ticket->id,
                    "user_name" => $ticket->user->name,
                    "movie_name" => $ticket->movie->title,
                    "movie_genres" => $ticket->movie->genres,
                    "movie_country" => $ticket->movie->country,
                    "movie_poster_path" => $ticket->movie->poster_path,
                    "screen_name" => $ticket->screen_name,
                    "seats_name" => $ticket->seats_name,
                    "showdate" => $ticket->showdate,
                    "show_time" => $ticket->show_time,
                    "qr_path" => $ticket->qr_path,
                ];
            }
            return response()->json([
                'data' => $data
            ]);
        }
        return response()->json([
            'data' => null
        ]);
    }
}
