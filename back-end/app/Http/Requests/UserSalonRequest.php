<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UserSalonRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'id_user_firebase'  => 'required|string|max:255',
            'level'             => 'required|int|max:2',
            'nama'              => 'required|string|max:255',
            'email'             => 'required|string|max:255',
            'phone'             => 'required|string|max:20',
            'nik'               => 'required|string|max:20',
            'jenis_kelamin'     => 'required|string|max:2',
            'tanggal_lahir'     => 'required|date',
            'alamat'            => 'required|string',
            'logo_url'          => 'nullable|url|max:255',
        ];
    }
}
