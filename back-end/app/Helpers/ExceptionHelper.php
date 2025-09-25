<?php

namespace App\Helpers;

use Illuminate\Http\Request;
use Symfony\Component\HttpKernel\Exception\{
    HttpException,
    NotFoundHttpException,
    MethodNotAllowedHttpException
};
use Illuminate\Auth\AuthenticationException;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Session\TokenMismatchException;
use Illuminate\Validation\ValidationException;
use Throwable;

class ExceptionHelper
{
    public static function handleNotFound(NotFoundHttpException $e, Request $request)
    {
        $message = $e->getMessage() !== '' ? $e->getMessage() : 'Resource not found';
        return ApiResponse::error(
            'Resource not found', 
            404, 
            [
                'path' => $request->path(),
                'method' => $request->method(),
                'message' => $message,
            ]
        );
    }

    public static function handleMethodNotAllowed(MethodNotAllowedHttpException $e, Request $request)
    {
        $message = $e->getMessage() !== '' ? $e->getMessage() : 'Method not allowed';
        $allowedMethods = $e->getHeaders()['Allow'] ?? '';
        
        return ApiResponse::error(
            'Method not allowed',
            405,
            [
                'current_method' => $request->method(),
                'allowed_methods' => explode(', ', $allowedMethods),
                'path' => $request->path(),
                'message' => $message,
            ]
        );
    }

    public static function handleAuthentication(AuthenticationException $e, Request $request)
    {
        $message = $e->getMessage() !== '' ? $e->getMessage() : 'Unauthenticated';
        return ApiResponse::error(
            'Unauthenticated', 
            401, 
            [
                'auth_type' => 'Bearer Token',
                'message' => $message,
            ]
        );
    }

    public static function handleValidation(ValidationException $e, Request $request)
    {
        return ApiResponse::error('Validation failed', 422, $e->errors());
    }

    public static function handleGeneric(Throwable $e, Request $request)
    {
        $statusCode = match(true) {
            $e instanceof HttpException => $e->getStatusCode(),
            $e instanceof AuthenticationException => 401,
            $e instanceof ValidationException => 422,
            $e instanceof ModelNotFoundException => 404,
            $e instanceof TokenMismatchException => 419,
            default => 500
        };

        $message = match($statusCode) {
            401 => 'Unauthorized',
            403 => 'Forbidden',
            404 => 'Not Found',
            419 => 'Page Expired',
            422 => 'Validation Error',
            500 => 'Server Error',
            default => $e->getMessage() ?: 'An error occurred'
        };

        $errors = ['message' => $e->getMessage()];

        return ApiResponse::error($message, $statusCode, $errors);
    }
}