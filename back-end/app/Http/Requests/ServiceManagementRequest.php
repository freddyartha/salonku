<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ServiceManagementRequest extends FormRequest
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
            'id_client' => 'nullable|exists:m_client,id',
            'id_payment_method' => 'required|exists:m_payment_method,id',
            'id_salon' => 'required|exists:m_salon,id',
            'id_cabang' => 'required|exists:m_salon_cabang,id',
            'catatan' => 'nullable|string',
            'services' => 'array',
            'services.*' => 'required|exists:m_service,id',
            'service_items' => 'array',
            'service_items.*.nama_service' => 'required|string',
            'service_items.*.deskripsi' => 'nullable|string',
            'service_items.*.harga' => 'required|numeric',
        ];
    }
}
