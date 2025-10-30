<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ProductRequest extends FormRequest
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
            'id_supplier'   => 'nullable|integer|exists:m_supplier,id',
            'brand'         => 'required|string|max:255',
            'nama'          => 'required|string|max:255',
            'ukuran'        => 'required|string|max:255',
            'satuan'        => 'required|string|max:255',
            'harga_satuan'  => 'required|numeric|min:0',
        ];
    }
}
