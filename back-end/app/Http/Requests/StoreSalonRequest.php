<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreSalonRequest extends FormRequest
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
            'nama_salon' => 'required|string|max:255',
            'alamat'     => 'nullable|string|max:500',
            'phone'      => 'nullable|string|max:20',
            'logo_url'   => 'nullable|url|max:255',
        ];
    }
}
