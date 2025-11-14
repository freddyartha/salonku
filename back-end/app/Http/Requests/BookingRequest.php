<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class BookingRequest extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        return [
            'id_client'     => 'required|integer|exists:m_client,id',
            'id_salon'      => 'required|integer|exists:m_salon,id',
            'id_cabang'     => 'required|integer|exists:m_salon_cabang,id',
            'id_user'       => 'required|integer|exists:m_user,id',
            'tanggal_jam'   => 'required|date',
            'catatan'       => 'nullable|string|max:500',
        ];
    }
}
