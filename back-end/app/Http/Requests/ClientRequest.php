<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ClientRequest extends FormRequest
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
            'id_salon'      => 'required|integer|exists:m_salon,id',
            'nama'          => 'required|string|max:255',
            'jenis_kelamin' => 'nullable|string|max:2',
            'alamat'        => 'nullable|string|max:255',
            'email'         => 'nullable|string|max:255',
            'phone'         => 'nullable|string|max:20',
        ];
    }
}
