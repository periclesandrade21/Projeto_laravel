Route::get('/health', function () {
    return response()->json(['status' => 'OK']);
});

Route::get('/metrics', [\App\Http\Controllers\MetricsController::class, 'index']);
