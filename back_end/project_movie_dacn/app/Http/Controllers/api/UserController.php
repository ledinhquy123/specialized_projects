<?php

namespace App\Http\Controllers\api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Validator;

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
                $user->avatar = 'https://i.pinimg.com/736x/c6/e5/65/c6e56503cfdd87da299f72dc416023d4.jpg';
                $user->save();

                return response()->json([
                    'data' => $user,
                    'message' => $message
                ]);
            }elseif(!$user->provider_id) $message = 'Email đã tồn tại trên hệ thống';
            elseif($user->provider_id) {
                $user = new User;
                $user->name = $name;
                $user->email = $email;
                $user->password = Hash::make($password);
                $user->group_id = 1; // Default user
                $user->avatar = 'https://i.pinimg.com/736x/c6/e5/65/c6e56503cfdd87da299f72dc416023d4.jpg';
                $user->save();

                return response()->json([
                    'data' => $user,
                    'message' => $message
                ]);
            }
        }else $message = 'Dữ liệu không hợp lệ';
        return response()->json([
            'data' => '',
            'message' => $message
        ]);
    }

    public function update(Request $request) {
        $id = $request->id;
        $name = $request->name;
        $email = $request->email;
        if($id && $name && $email) {
            $user = User::find($id);
            $user->name = $name;
            $user->email = $email;
            $user->save();
            return response()->json([
                'user' => $user
            ]); 
        }
        return response()->json([
            'user' => null
        ]);
    }

    public function checkEmailUpdate(Request $request) {
        $email = $request->email;
        $id = $request->id;
        $users = User::all();
        foreach($users as $user) {
            if($user->password && $user->id != $id) {
                if($user->email == $email) {
                    return response()->json([
                        'status' => '0'
                    ]);
                }
            }
        }
        return response()->json([
            'status' => '1'
        ]);
    }

    public function login(Request $request) {
        $email = $request->email;
        $password = $request->password;
        if($email && $password) {
            $user = User::where('email', $email)->get();
            if($user->count() > 0) {
                $result = null;
                foreach($user as $item) {
                    if($item->password) {
                        $result = $item;
                        break;
                    }
                }
                if($result) {
                    $status = Hash::check($password, $result->password) ? 1 : 0;
        
                    return response()->json([
                        'status' => $status,
                        'user' => $result,
                        'message' => ''
                    ]);
                }
            }
            return response()->json([
                'status' => '',
                'message' => 'Email không đúng hoặc chưa được đăng kí'
            ]);
        }else{
            return response()->json([
                'status' => '',
                'message' => 'Email hoặc mật khẩu không hợp lệ'
            ]);
        }

    }

    public function verifyEmail($email) {
        $user = User::where('email', $email)->get();

        $result = null;
        foreach($user as $item) {
            if($item->password) {
                $result = $item;
                break;
            }
        }
        if($result) {
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
            $users = User::where('email', $email)->get();

            if($users->count() > 0) {
                foreach($users as $item) {
                    if($item->password) {
                        $user = $item;
                        $user->password = Hash::make($password);
                        $user->save();
                        $response = [
                            'status' => 'success'
                        ];
                        break;
                    }
                }    
            }else {
                $response = [
                    'status' => 'failed'
                ];    
            }
        }else {
            $response = [
                'status' => 'failed'
            ];
        }
        return response()->json($response);
    }

}
