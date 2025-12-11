<!DOCTYPE html>
<html>
<head>
    <style>
        body { font-family: sans-serif; font-size: 12px; }
        h2 { text-align: center; margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #000; padding: 8px; }
        th { background: #eee; }
    </style>
</head>
<body>

<h2>{{ $title }}</h2>
<p>Dari Tanggal: {{ $from_date }}, Sampai Tanggal: {{ $to_date }}</p>

<table>
    <thead>
        <tr>
            <th>No</th>
            <th>Tanggal</th>
            <th>Keterangan</th>
            <th>Tipe</th>
            <th>Nominal</th>
        </tr>
    </thead>
    <tbody>
        @foreach($items as $i)
        <tr>
            <td>{{ $i['no'] }}</td>
            <td>{{ $i['created_at'] }}</td>
            <td>{{ $i['keterangan'] }}</td>
            <td>{{ $i['type'] }}</td>
            <td>Rp {{ number_format($i['nominal'], 0, ',', '.') }}</td>
        </tr>
        @endforeach
    </tbody>
</table>

</body>
</html>