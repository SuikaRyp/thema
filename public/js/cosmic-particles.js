/**
 * PROJECT Z-AURA - Cosmic Particles Effect
 * Menciptakan efek debu kosmik di background
 */

class CosmicParticles {
    constructor(canvasId) {
        this.canvas = document.getElementById(canvasId);
        if (!this.canvas) return;
        
        this.ctx = this.canvas.getContext('2d');
        this.particles = [];
        this.mouseX = 0;
        this.mouseY = 0;
        this.init();
    }
    
    init() {
        this.resize();
        this.createParticles(150);
        this.animate();
        this.bindEvents();
    }
    
    resize() {
        this.canvas.width = window.innerWidth;
        this.canvas.height = window.innerHeight;
    }
    
    createParticles(count) {
        for (let i = 0; i < count; i++) {
            this.particles.push({
                x: Math.random() * this.canvas.width,
                y: Math.random() * this.canvas.height,
                size: Math.random() * 3 + 1,
                speedX: (Math.random() - 0.5) * 0.3,
                speedY: (Math.random() - 0.5) * 0.3,
                opacity: Math.random() * 0.5 + 0.2,
                color: this.getRandomCosmicColor(),
                twinkleSpeed: Math.random() * 0.02 + 0.01,
                twinklePhase: Math.random() * Math.PI * 2
            });
        }
    }
    
    getRandomCosmicColor() {
        const colors = [
            'rgba(0, 255, 255', // cyan
            'rgba(138, 43, 226', // violet
            'rgba(65, 105, 225', // blue
            'rgba(255, 255, 255', // white
            'rgba(200, 200, 255' // silver
        ];
        return colors[Math.floor(Math.random() * colors.length)];
    }
    
    bindEvents() {
        window.addEventListener('resize', () => this.resize());
        window.addEventListener('mousemove', (e) => {
            this.mouseX = e.clientX;
            this.mouseY = e.clientY;
        });
    }
    
    animate() {
        this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);
        
        this.particles.forEach(p => {
            // Update position
            p.x += p.speedX;
            p.y += p.speedY;
            
            // Boundary check
            if (p.x < 0) p.x = this.canvas.width;
            if (p.x > this.canvas.width) p.x = 0;
            if (p.y < 0) p.y = this.canvas.height;
            if (p.y > this.canvas.height) p.y = 0;
            
            // Mouse interaction
            const dx = this.mouseX - p.x;
            const dy = this.mouseY - p.y;
            const distance = Math.sqrt(dx * dx + dy * dy);
            
            if (distance < 100) {
                const angle = Math.atan2(dy, dx);
                const force = (100 - distance) / 100 * 0.5;
                p.x -= Math.cos(angle) * force;
                p.y -= Math.sin(angle) * force;
            }
            
            // Twinkle effect
            p.twinklePhase += p.twinkleSpeed;
            const twinkle = Math.sin(p.twinklePhase) * 0.3 + 0.7;
            
            // Draw particle
            this.ctx.beginPath();
            this.ctx.arc(p.x, p.y, p.size, 0, Math.PI * 2);
            this.ctx.fillStyle = `${p.color}, ${p.opacity * twinkle})`;
            this.ctx.fill();
            
            // Glow effect
            this.ctx.shadowColor = `${p.color}, 0.5)`;
            this.ctx.shadowBlur = 10;
            this.ctx.fill();
            this.ctx.shadowBlur = 0;
        });
        
        requestAnimationFrame(() => this.animate());
    }
}

// Initialize saat halaman dimuat
document.addEventListener('DOMContentLoaded', () => {
    if (document.getElementById('cosmic-canvas')) {
        new CosmicParticles('cosmic-canvas');
    }
});
