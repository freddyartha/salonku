<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class PengeluaranRequest extends FormRequest
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
            'id_salon'   => 'required|integer',
            'nama'       => 'required|string|max:255',
            'deskripsi'  => 'nullable|string|max:500',
            'harga'      => 'required|numeric|min:0',
            'cabangs'    => 'array',
            'cabangs.*'  => 'integer|exists:m_salon_cabang,id',
        ];
    }
}
