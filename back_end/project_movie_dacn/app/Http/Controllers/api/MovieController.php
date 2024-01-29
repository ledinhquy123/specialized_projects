<?php

namespace App\Http\Controllers\api;

use App\Http\Controllers\Controller;
use App\Models\Movie;
use Carbon\Carbon;
use Illuminate\Support\Facades\Http;

class MovieController extends Controller
{
    private $headers = [];
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
        }
        
        return $trailerPath ;
    }

    // Handle
    public function handleGetMovie($apiUrl) {
        $response = Http::withHeaders($this->headers)
        ->get($apiUrl);
        $response = $response->json();
        $dataMovie = [
            'totalResults' => $response['total_results'],
            'results' => $response['results']
        ];
        $genres = $this->getAllGenres();


        foreach($dataMovie['results'] as $item) {
            $movie = Movie::where('title', $item['title'])->get();

            if($movie->isEmpty()) {
                $movie = new Movie();
                $movie->title = $item['title'];
                foreach($item['genre_ids'] as $genre_id) {
                    $movie->genres .= $genres[$genre_id] . ','; 
                }
                $movie->genres = substr($movie->genres, 0, -1);
                $movie->over_view = $item['overview'];
                if($item['poster_path']) {
                    $movie->poster_path = 'https://image.tmdb.org/t/p/original' . $item['poster_path'];
                }
                if($item['backdrop_path']) {
                    $movie->backdrop_path = 'https://image.tmdb.org/t/p/original' . $item['backdrop_path'];
                }
                $movie->video_path = $this->getTrailer($item['id'], $item['original_language']);
                $movie->vote_count = $item['vote_count'];
                $movie->vote_average = $item['vote_average'];
                $movie->release_date = $item['release_date'];
                $movie->save();
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
        $data = [];
        // Get total pages = 3
        for($i = 1; $i <= 3; $i++) {
            $response = Http::withHeaders($this->headers)
            ->get('https://api.themoviedb.org/3/movie/upcoming?page='.$i.'&language=vi&region=US&primary_release_date.gte='.$timeNow);
            $response = $response->json();
            $dataMovie = [
                'totalResults' => $response['total_results'],
                'results' => $response['results']
            ];

            $genres = $this->getAllGenres();
    
            foreach($dataMovie['results'] as $item) {
                $movie = Movie::where('title', $item['title'])->get();
    
                if($movie->isEmpty()) {
                    if(!empty($item['overview'])) {
                        $movie = new Movie();
                        $movie->title = $item['title'];
                        foreach($item['genre_ids'] as $genre_id) {
                            $movie->genres .= $genres[$genre_id] . ','; 
                        }
                        $movie->genres = substr($movie->genres, 0, -1);
                        $movie->over_view = $item['overview'];
                        if($item['poster_path']) {
                            $movie->poster_path = 'https://image.tmdb.org/t/p/original' . $item['poster_path'];
                        }
                        if($item['backdrop_path']) {
                            $movie->backdrop_path = 'https://image.tmdb.org/t/p/original' . $item['backdrop_path'];
                        }
                        $movie->video_path = $this->getTrailer($item['id'], $item['original_language']);
                        $movie->vote_count = $item['vote_count'];
                        $movie->vote_average = $item['vote_average'];
                        $movie->release_date = $item['release_date'];
                        $movie->save();
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
}
