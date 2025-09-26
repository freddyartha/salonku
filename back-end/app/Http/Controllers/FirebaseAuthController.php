<?php

namespace App\Http\Controllers;

use App\Helpers\ApiResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Kreait\Firebase\Auth as FirebaseAuth;

class FirebaseAuthController extends Controller
{
    protected $firebaseAuth;

    public function __construct(FirebaseAuth $firebaseAuth)
    {
        $this->firebaseAuth = $firebaseAuth;
    }

    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required|string'
        ]);

        $apiKey = env('FIREBASE_API_KEY');

        // 🔹 Call Firebase REST API to login
        $response = Http::post("https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key={$apiKey}", [
            'email' => $request->email,
            'password' => $request->password,
            'returnSecureToken' => true,
        ]);

        if ($response->failed()) {
            return ApiResponse::error( 'Invalid credentials',  401,$response->json()['error'] ?? null);
        }

        $data = $response->json();

        // 🔹 Verify the token with Firebase Admin SDK
        try {
            $verified = $this->firebaseAuth->verifyIdToken($data['idToken']);
            $claims = $verified->claims();

            return response()->json([
                'message' => 'Login success',
                'firebase_token' => $data['idToken'],
                'refresh_token' => $data['refreshToken'],
                'expires_in' => $data['expiresIn'],
                'user' => [
                    'uid' => $claims->get('sub'),
                    'email' => $claims->get('email'),
                ]
            ]);
        } catch (\Throwable $e) {
            ApiResponse::error( 'Failed to verify token',  401, $e->getMessage());
        }
    }
}
