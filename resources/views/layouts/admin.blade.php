<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    
    <title>{{ config('app.name', 'Pterodactyl') }} - Z-Aura Theme</title>
    
    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Orbitron:wght@400;600;700;900&family=Exo+2:wght@400;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
    
    <!-- Z-Aura Theme CSS -->
    <link rel="stylesheet" href="{{ asset('css/theme.css') }}">
    <link rel="stylesheet" href="{{ asset('css/components/glass-card.css') }}">
    <link rel="stylesheet" href="{{ asset('css/components/buttons.css') }}">
    <link rel="stylesheet" href="{{ asset('css/components/dragon-ball.css') }}">
    <link rel="stylesheet" href="{{ asset('css/components/terminal.css') }}">
    
    @stack('styles')
</head>
<body class="bg-space-black">
    <!-- Cosmic Background Canvas -->
    <canvas id="cosmic-canvas" style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: -1; pointer-events: none;"></canvas>
    
    <div id="app" class="min-h-screen">
        <!-- Navigation Sidebar -->
        <nav class="fixed left-0 top-0 h-full w-64 glass-card-dark z-50">
            @include('partials.cosmic-sidebar')
        </nav>
        
        <!-- Main Content -->
        <main class="ml-64 p-6">
            @yield('content')
        </main>
        
        <!-- Scouter HUD -->
        @include('partials.scouter-hud')
    </div>
    
    <!-- Scripts -->
    <script src="{{ asset('js/cosmic-particles.js') }}"></script>
    <script src="{{ asset('js/scouter-hud.js') }}"></script>
    <script src="{{ asset('js/theme-init.js') }}"></script>
    @stack('scripts')
    
    <!-- Initialize Cosmic Particles -->
    <script>
    document.addEventListener('DOMContentLoaded', function() {
        if (typeof CosmicParticles !== 'undefined') {
            new CosmicParticles('cosmic-canvas');
        }
    });
    </script>
</body>
</html>
