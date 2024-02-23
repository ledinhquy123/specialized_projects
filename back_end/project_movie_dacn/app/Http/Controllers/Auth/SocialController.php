<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use Laravel\Socialite\Facades\Socialite;
use Illuminate\Http\Request;

class SocialController extends Controller
{
    public function googleLogin() {
        return Socialite::driver('google')->redirect();
    }

    public function googleCallback() {
        $user = Socialite::driver('google')->user();
        return $user->getName();
    }

    // App 
    public function appGoogleSignIn(Request $request) {
        $access_token = $request->input('access_token');
        $provider_id = $request->input('provider_id');
        $name = $request->input('name');
        $email = $request->input('email');
        $avatar = $request->input('avatar');

        if($provider_id) {
            $user = User::where('provider_id', $provider_id)->first();

            if(!$user) {
                $user = new User;
                $user->name = $name;
                $user->email = $email;
                $user->provider_id = $provider_id;
                $user->provider = 'google';
                $user->avatar = $avatar;
                $user->access_token = $access_token;
                $user->group_id = 1;
                $user->save();
            }

            return response()->json([
                'user' => $user
            ]);
        }
        return response()->json([
            'user' => null
        ]);
    }
}
