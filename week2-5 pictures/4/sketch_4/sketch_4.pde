ArrayList<Particle> particles;
PVector origin;

void setup() {
  size(640, 360);
  origin = new PVector(width / 2, height / 2); // 中心位置
  particles = new ArrayList<Particle>();
}

void draw() {
  background(0);
  if (frameCount % 5 == 0) { // 每5帧生成一次烟花
    addParticle();
  }
  runParticles();
}

void addParticle() {
  // 创建多个粒子
  for (int i = 0; i < 100; i++) {
    particles.add(new Particle(origin));
  }
}

void runParticles() {
  for (int i = particles.size() - 1; i >= 0; i--) {
    Particle p = particles.get(i);
    p.update();
    p.display();
    if (p.isFinished()) {
      particles.remove(i);
    }
  }
}

class Particle {
  PVector position;
  PVector velocity;
  float lifespan;
  color c;

  Particle(PVector origin) {
    this.position = origin.copy();
    float angle = random(TWO_PI); // 随机角度
    float speed = random(2, 5); // 随机速度
    this.velocity = new PVector(cos(angle) * speed, sin(angle) * speed);
    this.lifespan = 255;
    this.c = color(random(150, 255), random(100, 255), random(200, 255), lifespan);
  }

  void update() {
    position.add(velocity);
    lifespan -= 2;
    c = color(red(c), green(c), blue(c), lifespan);
  }

  void display() {
    fill(c);
    noStroke();
    ellipse(position.x, position.y, 8, 8); // 调整粒子大小
  }

  boolean isFinished() {
    return lifespan < 0;
  }
}
