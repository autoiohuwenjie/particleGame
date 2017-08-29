import QtQuick 2.0


ShaderEffect {
    width: 600
    height: 600
    property real mwidth: width
    property real mheight: height
    property real shift: 1.6
    property real speedX: 0.7
    property real speedY: 0.4
    property real alpha: 1.0
    property real time: 0.0

//    SequentialAnimation on time {
//        id: anim;
//        NumberAnimation { to: 10; duration: 6000;}
//        loops: Animation.Infinite
//    }

    Timer {
        interval: 90
        repeat: true
        running: true
        onTriggered: { ++time }
    }

    fragmentShader:"
          uniform mediump float mwidth;
          uniform mediump float mheight;
          uniform mediump float time;
          uniform mediump float alpha;
          uniform mediump float speedX;
          uniform mediump float speedY;
          uniform mediump float shift;
          varying mediump vec2 qt_TexCoord0;

          float rand(vec2 n) {
            return fract(cos(dot(n, vec2(12.9898, 4.1414))) * 43758.5453);
          }

          float noise(vec2 n) {
            const vec2 d = vec2(0.0, 1.0);
            vec2 b = floor(n), f = smoothstep(vec2(0.0), vec2(1.0), fract(n));
            return mix(mix(rand(b), rand(b + d.yx), f.x), mix(rand(b + d.xy), rand(b + d.yy), f.x), f.y);
          }

          float fbm(vec2 n) {
            float total = 0.0, amplitude = 1.0;
            for (int i = 0; i < 4; i++) {
              total += noise(n) * amplitude;
              n += n;
              amplitude *= 0.5;
            }
            return total;
          }

          void main() {

            const vec3 c1 = vec3(126.0/255.0, 0.0/255.0, 97.0/255.0);
            const vec3 c2 = vec3(173.0/255.0, 0.0/255.0, 161.4/255.0);
            const vec3 c3 = vec3(0.2, 0.0, 0.0);
            const vec3 c4 = vec3(164.0/255.0, 1.0/255.0, 214.4/255.0);
            const vec3 c5 = vec3(0.1);
            const vec3 c6 = vec3(0.9);

            vec2 p = qt_TexCoord0.xy * 8.0 * 600.0 / vec2(mwidth, mheight);
            float q = fbm(p - time * 0.1);
            vec2 r = vec2(fbm(p + q + time * speedX - p.x - p.y), fbm(p + q - time * speedY));
            vec3 c = mix(c1, c2, fbm(p + r)) + mix(c3, c4, r.x) - mix(c5, c6, r.y);
            float grad = qt_TexCoord0.y * 600.0/ mwidth;
            gl_FragColor = vec4(c * cos(shift * qt_TexCoord0.y / mheight * 600.0), 1.0);
            gl_FragColor.xyz *= 1.0-grad;
          }"
}
