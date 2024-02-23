<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Laravel Generate QR Code Examples</title>
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>
    <div class="container mt-5">
        <div class="card text-center">
            <div class="card-header">
                <h2>Thông tin vé</h2>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-6">
                        <img width="200" height="240" src="{{$ticket->movie->poster_path}}" alt="Mô tả ảnh">
                        <p style="font-weight: bold">Phim: {{$ticket->movie->title}}</p>
                        <p> 
                            <span style="font-weight: bold">Suất chiếu</span>: {{$ticket->show_time}} giờ, ngày: {{$ticket->showdate}}
                        </p>
                        <p> 
                            <span style="font-weight: bold">Ghế</span>: {{$ticket->seats_name}}
                        </p>
                        <p> 
                            <span style="font-weight: bold">Phòng</span>: {{$ticket->screen_name}}
                        </p>
                        <p> 
                            <span style="font-weight: bold">Người đặt</span>: {{$ticket->user->name}}
                        </p>
                        <p> 
                            <span style="font-weight: bold">Email</span>: {{$ticket->user->email}}
                        </p>
                        <p> 
                            <span style="font-weight: bold">Trạng thái</span>: Đã thanh toán
                        </p>
                    </div>

                    <div class="col-6">
                        <div class="container mb-5">
                            <a href="#" class="btn btn-primary">Liên hệ hỗ trợ</a>
                        </div>
                        {!! QrCode::size(220)->generate(
                            'https://www.facebook.com/profile.php?id=100026767123334!'
                        ) !!}
                    </div>
                </div>
            </divK>
        </div>
    </div>
</body>
</html>