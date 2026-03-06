<!-- Scouter HUD - Dragon Ball Style Resource Monitor -->
<div id="scouter-hud" class="scouter-hud glass-card">
    <div class="scouter-header">
        <span class="scouter-title">POWER LEVEL</span>
        <span class="scouter-battery">⚡ 100%</span>
    </div>
    
    <div class="scouter-display">
        <!-- Target Indicator -->
        <div class="scouter-target">
            <span class="target-label">SERVERS</span>
            <span class="target-value scouter-servers">0</span>
        </div>
        
        <!-- Power Level -->
        <div class="scouter-power-container">
            <span class="power-label">BATTLE POWER</span>
            <span class="scouter-power-level">5000</span>
        </div>
        
        <!-- CPU Meter -->
        <div class="scouter-meter">
            <div class="meter-label">
                <span>CPU</span>
                <span class="scouter-cpu-text">0%</span>
            </div>
            <div class="meter-bar-bg">
                <div class="meter-bar-fill scouter-cpu-bar" style="width: 0%"></div>
            </div>
        </div>
        
        <!-- RAM Meter -->
        <div class="scouter-meter">
            <div class="meter-label">
                <span>RAM</span>
                <span class="scouter-ram-text">0/0 GB</span>
            </div>
            <div class="meter-bar-bg">
                <div class="meter-bar-fill scouter-ram-bar" style="width: 0%"></div>
            </div>
        </div>
        
        <!-- Disk Meter -->
        <div class="scouter-meter">
            <div class="meter-label">
                <span>DISK</span>
                <span class="scouter-disk-text">0/0 GB</span>
            </div>
            <div class="meter-bar-bg">
                <div class="meter-bar-fill scouter-disk-bar" style="width: 0%"></div>
            </div>
        </div>
        
        <!-- Status -->
        <div class="scouter-status">
            <span class="status-led"></span>
            <span class="status-text">SCANNING...</span>
        </div>
    </div>
    
    <!-- Scanlines -->
    <div class="scouter-scanline"></div>
</div>

<style>
.scouter-hud {
    position: fixed;
    bottom: 20px;
    left: 20px;
    width: 280px;
    padding: 15px;
    background: rgba(5, 6, 10, 0.9);
    backdrop-filter: blur(10px);
    border: 1px solid #00ffff;
    border-radius: 12px;
    box-shadow: 0 0 30px rgba(0, 255, 255, 0.3);
    font-family: 'JetBrains Mono', monospace;
    z-index: 9999;
    overflow: hidden;
}

.scouter-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 15px;
    padding-bottom: 8px;
    border-bottom: 1px solid rgba(0, 255, 255, 0.3);
}

.scouter-title {
    color: #00ffff;
    font-size: 14px;
    font-weight: bold;
    letter-spacing: 2px;
    text-shadow: 0 0 10px #00ffff;
}

.scouter-battery {
    color: #32cd32;
    font-size: 12px;
}

.scouter-display {
    position: relative;
}

.scouter-target {
    display: flex;
    justify-content: space-between;
    margin-bottom: 10px;
    padding: 5px;
    background: rgba(0, 0, 0, 0.5);
    border-radius: 4px;
}

.target-label {
    color: #8a2be2;
    font-size: 12px;
}

.target-value {
    color: #00ffff;
    font-size: 16px;
    font-weight: bold;
}

.scouter-power-container {
    text-align: center;
    margin: 15px 0;
    padding: 10px;
    background: linear-gradient(135deg, rgba(0,255,255,0.1), rgba(138,43,226,0.1));
    border-radius: 8px;
}

.power-label {
    display: block;
    color: #c0c0c0;
    font-size: 10px;
    margin-bottom: 5px;
}

.scouter-power-level {
    font-size: 28px;
    font-weight: bold;
    color: #00ffff;
    text-shadow: 0 0 20px #00ffff;
    font-family: 'Orbitron', monospace;
}

.scouter-meter {
    margin: 12px 0;
}

.meter-label {
    display: flex;
    justify-content: space-between;
    color: #c0c0c0;
    font-size: 11px;
    margin-bottom: 4px;
}

.meter-bar-bg {
    height: 8px;
    background: rgba(0, 0, 0, 0.5);
    border-radius: 4px;
    overflow: hidden;
    border: 1px solid rgba(0, 255, 255, 0.3);
}

.meter-bar-fill {
    height: 100%;
    width: 0%;
    background: linear-gradient(90deg, #00ffff, #8a2be2);
    transition: width 0.3s ease;
    position: relative;
    overflow: hidden;
}

.meter-bar-fill::after {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
    animation: shimmer 2s infinite;
}

@keyframes shimmer {
    100% { left: 100%; }
}

.scouter-status {
    display: flex;
    align-items: center;
    gap: 8px;
    margin-top: 15px;
    padding-top: 10px;
    border-top: 1px solid rgba(0, 255, 255, 0.3);
}

.status-led {
    width: 8px;
    height: 8px;
    background: #00ff00;
    border-radius: 50%;
    animation: blink 1s infinite;
    box-shadow: 0 0 10px #00ff00;
}

@keyframes blink {
    0%, 100% { opacity: 1; }
    50% { opacity: 0.3; }
}

.status-text {
    color: #00ffff;
    font-size: 11px;
    letter-spacing: 1px;
}

.scouter-scanline {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 100%;
    background: linear-gradient(180deg, 
        transparent 0%, 
        rgba(0, 255, 255, 0.05) 50%, 
        transparent 100%);
    animation: scan 4s linear infinite;
    pointer-events: none;
}

@keyframes scan {
    0% { transform: translateY(-100%); }
    100% { transform: translateY(200%); }
}

/* Mobile responsive */
@media (max-width: 768px) {
    .scouter-hud {
        display: none;
    }
}
</style>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Inisialisasi Scouter HUD
    if (typeof ScouterHUD !== 'undefined') {
        new ScouterHUD();
    }
});
</script>
