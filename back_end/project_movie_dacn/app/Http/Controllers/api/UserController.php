<?php

namespace App\Http\Controllers\api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Http;

class UserController extends Controller
{
    public function index() {
        $users = User::all();
        return response()->json($users);
    }

    public function create(Request $request) {
        $name = $request->name;
        $email = $request->email;
        $password = $request->password;

        $message = '';
        if($name && $email && $password) {
            $user = User::where('email', $email)->first();
            if(!$user) {
                $user = new User;
                $user->name = $name;
                $user->email = $email;
                $user->password = Hash::make($password);
                $user->group_id = 1; // Default user
                $user->save();

                return response()->json([
                    'data' => $user,
                    'message' => $message
                ]);
            }else $message = 'Email đã tồn tại trên hệ thống';
        }else $message = 'Dữ liệu không hợp lệ';
        return response()->json([
            'data' => '',
            'message' => $message
        ]);
    }

    public function login(Request $request) {
        $email = $request->email;
        $password = $request->password;
        if($email && $password) {
            $user = User::where('email', $email)->first();

            if($user) {
                $status = Hash::check($password, $user->password) ? 1 : 0;
    
                return response()->json([
                    'status' => $status,
                    'message' => ''
                ]);
            }else {
                return response()->json([
                    'status' => '',
                    'message' => 'Email không đúng hoặc chưa được đăng kí'
                ]);
            }
        }else{
            return response()->json([
                'status' => '',
                'message' => 'Email hoặc mật khẩu không hợp lệ'
            ]);
        }

    }

    public function verifyEmail($email) {
        $user = User::where('email', $email)->first();
        if($user) {
            $response = [
                'status' => 'found'
            ];
        }else {
            $response = [
                'status' => 'not found'
            ];
        }
        return response()->json($response);
    }

    public function changePass(Request $request) {
        $email = $request->email;
        $password = $request->password;

        if($email && $password) {
            $user = User::where('email', $email)->first();
            $user->password = Hash::make($password);
            $user->save();

            $response = [
                'status' => 'success'
            ];
        }else {
            $response = [
                'status' => 'failed'
            ];
        }
        return response()->json($response);
    }

}
