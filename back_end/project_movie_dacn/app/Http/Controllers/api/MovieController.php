<?php

namespace App\Http\Controllers\api;

use App\Http\Controllers\Controller;
use App\Models\Actor;
use App\Models\Movie;
use App\Models\Showtime;
use App\Models\Weekday;
use Carbon\Carbon;
use DateTime;
use Illuminate\Support\Facades\Http;

class MovieController extends Controller
{
    private $headers = [];
    private $defaultOverview = 'Nhân vật King Kong được nhà làm phim người Mỹ Merian C. Cooper hình thành và tạo ra . Trong phim gốc, tên của nhân vật là Kong, cái tên được đặt cho anh ta bởi cư dân của " Đảo đầu lâu " hư cấu ở Ấn Độ Dương , nơi Kong sống cùng với các loài động vật ngoại cỡ khác, chẳng hạn như thằn lằn đầu rắn , thằn lằn bay và nhiều loài khủng long khác nhau . Một đoàn làm phim người Mỹ, do Carl Denham dẫn đầu , bắt giữ Kong và đưa anh ta đến Thành phố New York để trưng bày với tư cách là " Kỳ quan thứ tám của thế giới ".';
    private $defaultTrailer = 'https://www.youtube.com/watch?v=_inKs4eeHiI';


    public function __construct() {
        $this->headers = [
            'accept' => 'application/json',
            'Authorization' => 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwMzhiNmYyMzE5MzcyZWJhOTc5NmFmNTFhNzU2M2ZlNSIsInN1YiI6IjY1OGUyMmVkNjRmNzE2MzFkMDNmNThlNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.a9khr0I2sPqAHXB9QvtaQFNZoy5QVBgmaobqCS8qWnk'
        ];
    }

    // Get genres
    public function getAllGenres() {
        $response = Http::withHeaders($this->headers)
        ->get('https://api.themoviedb.org/3/genre/movie/list?language=vi');
        $response = $response->json();
        foreach($response['genres'] as $genre) {
            $data[$genre['id']] = $genre['name'];
         }
        return $data;
    }

    // Get trailer
    public function getTrailer($idMovie, $originalLanguage) {
        // Find with original_language
        $response = Http::withHeaders($this->headers)
        ->get('https://api.themoviedb.org/3/movie/'.$idMovie.'/videos?language='.$originalLanguage);
        $response = $response->json();

        // If not found then find with original_language = 'en-US'
        if(!$response['results']) {
            $originalLanguage = 'en-US';
            $response = Http::withHeaders($this->headers)
            ->get('https://api.themoviedb.org/3/movie/'.$idMovie.'/videos?language='.$originalLanguage);
            $response = $response->json();
        }

        $trailerPath = '';
        // If found $trailerPath
        if($response['results']) {
            $trailerPath = 'https://www.youtube.com/watch?v='.$response['results'][0]['key'];
        }else {
            $trailerPath = $this->defaultTrailer;
        }
        
        return $trailerPath ;
    }

    public function getDetailMovie($idMovie) {
        $response = Http::withHeaders($this->headers)
        ->get('https://api.themoviedb.org/3/movie/'.$idMovie.'?language=US');
        $response = $response->json();
        $response = [
            'name' => !empty($response['production_countries']) ? $response['production_countries'][0]['name'] : 'Vietnam',
            'runtime' => $response['runtime']
        ];
        return $response;
    }

    public function getActor($idMovie) {
        $response = Http::withHeaders($this->headers)
        ->get('https://api.themoviedb.org/3/movie/'.$idMovie.'/credits?language=vi');
        $response = $response->json();
        $actors = $response['cast'];

        $dataActor = [];
        foreach($actors as $item) {
            $data['name'] = $item['name'];
            $data['gender'] = $item['gender'];
            $data['popularity'] = $item['popularity'];
            if($item['profile_path']) {
                $data['profile_path'] = 'https://image.tmdb.org/t/p/original' . $item['profile_path'];
            } else {
                $data['profile_path'] = 'https://i.pinimg.com/736x/c6/e5/65/c6e56503cfdd87da299f72dc416023d4.jpg';
            }
            if ($item['character']) $data['character'] = $item['character'];
            else $data['character'] = $item['name'];
            $dataActor[] = $data;
        }
        return response()->json($dataActor);
    }

    // Handle
    public function handleGetMovie($apiUrl) {
        $response = Http::withHeaders($this->headers)
        ->get($apiUrl);
        $response = $response->json();
        $response = $response['results'];
        $genres = $this->getAllGenres();


        foreach($response as $item) {
            $movie = Movie::where('id_movie', $item['id'])->first();

            if(!$movie) {
                $movie = new Movie();

                $movie->id_movie = $item['id'];
                $movie->title = $item['title'];
                foreach($item['genre_ids'] as $genre_id) {
                    $movie->genres .= $genres[$genre_id] . ', '; 
                }
                $movie->genres = substr($movie->genres, 0, -2);
                if($item['overview']){
                    $movie->over_view = $item['overview'];
                }else {
                    $movie->over_view = $this->defaultOverview;
                }
                if($item['poster_path']) {
                    $movie->poster_path = 'https://image.tmdb.org/t/p/original' . $item['poster_path'];
                } else if ($item['backdrop_path']) {
                    $movie->poster_path = 'https://image.tmdb.org/t/p/original' . $item['backdrop_path'];
                }
                if($item['backdrop_path']) {
                    $movie->backdrop_path = 'https://image.tmdb.org/t/p/original' . $item['backdrop_path'];
                }else if ($item['poster_path']) {
                    $movie->backdrop_path = 'https://image.tmdb.org/t/p/original' . $item['poster_path'];
                }
                $movie->video_path = $this->getTrailer($item['id'], $item['original_language']);
                $movie->vote_count = $item['vote_count'];
                $movie->vote_average = $item['vote_average'];
                
                $movie->release_date = $item['release_date'];
                $detailMovie = $this->getDetailMovie($item['id']);

                $movie->country = $detailMovie['name'];
                if($movie->runtime) $movie->runtime = $detailMovie['runtime'];
                else $movie->runtime = '120';
                
                if($apiUrl == 'https://api.themoviedb.org/3/movie/now_playing?language=vi&page=1&region=VN') {
                    $movie->status = 1;
                }

                if($movie->genres && $movie->over_view && $movie->poster_path && $movie->backdrop_path && $movie->video_path && $movie->release_date) {
                    $movie->save();
                }else continue;
            }
            $data[] = $movie;
        }

        return $data;
    }

    // Get now playing
    public function getNowPlaying() {
        return $this->handleGetMovie('https://api.themoviedb.org/3/movie/now_playing?language=vi&page=1&region=VN');
    }

    // Get popular
    public function getPopular() {
        return $this->handleGetMovie('https://api.themoviedb.org/3/movie/popular?language=vi&page=1&region=VN');
    }

    // Get up coming
    public function getUpcoming() {
        $timeNow = Carbon::now()->toDateString();
        // Get total pages = 3
        for($i = 1; $i <= 2; $i++) {
            $response = Http::withHeaders($this->headers)
            ->get('https://api.themoviedb.org/3/movie/upcoming?page='.$i.'&language=vi&region=US&primary_release_date.gte='.$timeNow);
            $response = $response->json();
            $dataMovie = [
                'totalResults' => $response['total_results'],
                'results' => $response['results']
            ];

            $genres = $this->getAllGenres();
    
            foreach($dataMovie['results'] as $item) {
                $movie = Movie::where('id_movie', $item['id'])->first();

                if(!$movie) {
                    if(Carbon::parse($timeNow)->lt(Carbon::parse($item['release_date']))) {
                        $movie = new Movie();

                        $movie->id_movie = $item['id'];
                        $movie->title = $item['title'];
                        foreach($item['genre_ids'] as $genre_id) {
                            $movie->genres .= $genres[$genre_id] . ', '; 
                        }
                        $movie->genres = substr($movie->genres, 0, -2);
                        if($item['overview']){
                            $movie->over_view = $item['overview'];
                        }else {
                            $movie->over_view = $this->defaultOverview;
                        }
                        if($item['poster_path']) {
                            $movie->poster_path = 'https://image.tmdb.org/t/p/original' . $item['poster_path'];
                        }else if ($item['backdrop_path']) {
                            $movie->poster_path = 'https://image.tmdb.org/t/p/original' . $item['backdrop_path'];
                        }
                        if($item['backdrop_path']) {
                            $movie->backdrop_path = 'https://image.tmdb.org/t/p/original' . $item['backdrop_path'];
                        }else if ($item['poster_path']) {
                            $movie->backdrop_path = 'https://image.tmdb.org/t/p/original' . $item['poster_path'];
                        }
                        $movie->video_path = $this->getTrailer($item['id'], $item['original_language']);
                        $movie->vote_count = $item['vote_count'];
                        $movie->vote_average = $item['vote_average'];
                        $movie->release_date = $item['release_date'];

                        $detailMovie = $this->getDetailMovie($item['id']);

                        $movie->country = $detailMovie['name'];
                        $movie->runtime = $detailMovie['runtime'];

                        if($movie->genres && $movie->over_view && $movie->poster_path && $movie->backdrop_path && $movie->video_path && $movie->release_date) {
                            $movie->save();
                        }else continue;
                    }else continue;
                }
                $data[] = $movie;
            }
        }

        return $data;
    }

    public function getTrendingDay() {
        return $this->handleGetMovie('https://api.themoviedb.org/3/trending/movie/day?language=vi');
    }

    public function getTrendingWeek() {
        return $this->handleGetMovie('https://api.themoviedb.org/3/trending/movie/week?language=vi');
    }

    public function getSearchMovie() {
        $movieNames = Movie::all();
        foreach($movieNames as $movieName) {
            $data[] = $movieName['title'];
        }
        return response()->json($data);
    }

    public function getWeekday() {
        $days = Weekday::all();

        $today = Carbon::now();
        $startOfWeek = $today->startOfWeek();

        foreach($days as $day) {
            $data[] = [
                'id' => $day->id,
                'name' => $day->name,
                'date' => $startOfWeek->toDateString()
            ];
            $startOfWeek->addDay();
        }
        return response()->json($data);
    }

    public function getShowtime($id) {
        if(!$id) {
            $showtime = Showtime::all();
        }else {
            $showtime = Showtime::where('weekday_id', $id)->get();
        }
        if($showtime->count() > 0) {
        foreach($showtime as $item) {
            $time = $item->timeframes->first()->start_time;
            $hour = Carbon::parse($time)->hour < 10 ? '0'.Carbon::parse($time)->hour : Carbon::parse($time)->hour;
            $minute = Carbon::parse($time)->minute < 10 ? '0'.Carbon::parse($time)->minute : Carbon::parse($time)->minute;
            $start_time = $hour . ':' . $minute;
            $data[$item->id_movie][] = [
                'id' => $item->id,
                'screen_name' => $item->screens->first()->name,
                'movie_name' => $item->movies->first()->title,
                'movie_poster' => $item->movies->first()->poster_path,
                'movie_genres' => $item->movies->first()->genres,
                'movie_country' => $item->movies->first()->country,
                'weekday_name' => $item->weekdays->first()->name,
                'start_time' => $start_time,
                'timeframe_id' => $item->timeframe_id,
                'duration' => $item->movies->first()->runtime
            ];
        }
      }else {
        $data['null'] = [];
      }
      return response()->json($data);
    }
}
