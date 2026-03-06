/**
 * PROJECT Z-AURA - Scouter HUD
 * Menampilkan statistik real-time ala Dragon Ball Scouter
 */

class ScouterHUD {
    constructor() {
        this.container = document.getElementById('scouter-hud');
        if (!this.container) return;
        
        this.updateInterval = 2000; // Update setiap 2 detik
        this.init();
    }
    
    init() {
        this.fetchStats();
        setInterval(() => this.fetchStats(), this.updateInterval);
    }
    
    fetchStats() {
        // Fetch data dari API Pterodactyl
        fetch('/api/client')
            .then(response => response.json())
            .then(data => {
                this.updateUI(data);
            })
            .catch(error => {
                console.error('Scouter HUD Error:', error);
            });
    }
    
    updateUI(data) {
        // Update CPU usage
        const cpuBar = this.container.querySelector('.scouter-cpu-bar');
        const cpuText = this.container.querySelector('.scouter-cpu-text');
        
        if (cpuBar && data.cpu) {
            const cpuPercent = data.cpu.used_percent || 0;
            cpuBar.style.width = `${cpuPercent}%`;
            cpuBar.style.background = this.getPowerLevelColor(cpuPercent);
            
            if (cpuText) {
                cpuText.textContent = `${Math.round(cpuPercent)}%`;
            }
        }
        
        // Update RAM usage
        const ramBar = this.container.querySelector('.scouter-ram-bar');
        const ramText = this.container.querySelector('.scouter-ram-text');
        
        if (ramBar && data.memory) {
            const ramPercent = (data.memory.used_bytes / data.memory.limit_bytes) * 100 || 0;
            ramBar.style.width = `${ramPercent}%`;
            ramBar.style.background = this.getPowerLevelColor(ramPercent);
            
            if (ramText) {
                const usedGB = (data.memory.used_bytes / 1073741824).toFixed(1);
                const totalGB = (data.memory.limit_bytes / 1073741824).toFixed(1);
                ramText.textContent = `${usedGB}/${totalGB} GB`;
            }
        }
        
        // Update disk usage
        const diskBar = this.container.querySelector('.scouter-disk-bar');
        const diskText = this.container.querySelector('.scouter-disk-text');
        
        if (diskBar && data.disk) {
            const diskPercent = (data.disk.used_bytes / data.disk.limit_bytes) * 100 || 0;
            diskBar.style.width = `${diskPercent}%`;
            diskBar.style.background = this.getPowerLevelColor(diskPercent);
            
            if (diskText) {
                const usedGB = (data.disk.used_bytes / 1073741824).toFixed(1);
                const totalGB = (data.disk.limit_bytes / 1073741824).toFixed(1);
                diskText.textContent = `${usedGB}/${totalGB} GB`;
            }
        }
        
        // Update total servers
        const serverCount = this.container.querySelector('.scouter-servers');
        if (serverCount && data.servers) {
            serverCount.textContent = data.servers.length;
        }
        
        // Random power level untuk efek
        this.updatePowerLevel();
    }
    
    getPowerLevelColor(percent) {
        if (percent < 30) return 'linear-gradient(90deg, #00ffff, #4169e1)'; // Blue - Low
        if (percent < 60) return 'linear-gradient(90deg, #4169e1, #8a2be2)'; // Purple - Medium
        if (percent < 85) return 'linear-gradient(90deg, #8a2be2, #ff69b4)'; // Pink - High
        return 'linear-gradient(90deg, #ff69b4, #ff0000)'; // Red - Critical
    }
    
    updatePowerLevel() {
        const powerElement = this.container.querySelector('.scouter-power-level');
        if (!powerElement) return;
        
        // Random power level antara 5,000 - 9,000
        const basePower = Math.floor(Math.random() * 4000) + 5000;
        const powerText = basePower.toLocaleString();
        
        powerElement.textContent = powerText;
        
        // Efek special kalau > 9000
        if (basePower > 9000) {
            powerElement.style.color = '#ff69b4';
            powerElement.style.textShadow = '0 0 20px #ff69b4';
            powerElement.style.animation = 'vibration 0.3s infinite';
            
            // Play sound effect (kalau browser support)
            this.playPowerLevelSound();
        } else {
            powerElement.style.color = '#00ffff';
            powerElement.style.textShadow = '0 0 10px #00ffff';
            powerElement.style.animation = 'none';
        }
    }
    
    playPowerLevelSound() {
        // Optional: play beep sound >9000
        if (window.AudioContext) {
            const audioCtx = new (window.AudioContext || window.webkitAudioContext)();
            const oscillator = audioCtx.createOscillator();
            const gainNode = audioCtx.createGain();
            
            oscillator.connect(gainNode);
            gainNode.connect(audioCtx.destination);
            
            oscillator.frequency.value = 880;
            gainNode.gain.value = 0.1;
            
            oscillator.start();
            oscillator.stop(audioCtx.currentTime + 0.1);
        }
    }
}

// Initialize
document.addEventListener('DOMContentLoaded', () => {
    new ScouterHUD();
});
