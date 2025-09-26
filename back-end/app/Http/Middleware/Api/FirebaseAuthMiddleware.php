<?php
namespace App\Http\Middleware\Api;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Kreait\Firebase\Auth as FirebaseAuth;
use App\Helpers\ApiResponse;


class FirebaseAuthMiddleware
{
    protected $auth;

    public function __construct(FirebaseAuth $auth)
    {
        $this->auth = $auth;
    }

    public function handle(Request $request, Closure $next): Response
    {
        $header = $request->header('Authorization');

        if (!$header || !str_starts_with($header, 'Bearer ')) {
             return ApiResponse::error( 'Missing Bearer Token',  401);
        }

        $idToken = trim(preg_replace('/^Bearer\s+/i', '', $header));

        $verifiedIdToken = $this->auth->verifyIdToken($idToken);
        $uid = $verifiedIdToken->claims()->get('sub'); // Firebase UID

        // Cari user di database
        $user = \App\Models\UserSalon::where('id_user_firebase', $uid)->first();

        if (!$user) {
            return response()->json(['message' => 'User not registered in system'], 403);
        }

        // Inject user ke request
        $request->merge([
            'firebase_uid' => $uid,
            'auth_user' => $user,
        ]);

        return $next($request);
    }
}
