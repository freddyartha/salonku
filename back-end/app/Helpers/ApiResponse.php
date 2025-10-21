<?php

namespace App\Helpers;

class ApiResponse
{
    public static function success($message = 'Success', $statusCode = 200, $data = [])
    {
        return response()->json([
            'status' => true,
            'message' => $message,
            'data' => $data,
        ], $statusCode);
    }

    public static function error($message = 'Error', $statusCode = 400)
    {
        return response()->json([
            'status' => false,
            'message' => $message,
        ], $statusCode);
    }
}
