<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class PromoRequest extends FormRequest
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
            'id_salon'          => 'required|integer|exists:m_salon,id',
            'nama'              => 'required|string|max:255',
            'deskripsi'         => 'required|string|max:500',
            'potongan_harga'    => 'nullable|numeric|min:0',
            'potongan_persen'   => 'nullable|numeric|min:0',
        ];
    }
}
