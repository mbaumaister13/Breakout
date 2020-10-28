uniform float time;
uniform vec2 mouse;
uniform vec2 resolution;

float circle(vec2 pos) {
	return step(0.7, distance(0.0, length(pos)));
}

void main( void ) {

	vec2 pixelPos1 = (gl_FragCoord.xy * 2.0 - resolution.xy) / min(resolution.x, resolution.y);
	vec2 pixelPos2 = (gl_FragCoord.xy * 2.0 - resolution.xy) / min(resolution.x, resolution.y);
	vec2 pixelPos3 = (gl_FragCoord.xy * 2.0 - resolution.xy) / min(resolution.x, resolution.y);
	
	pixelPos1.x += sin(pixelPos1.y * 5.0 + time * 5.0)  * 0.1;
	float color_r = circle(pixelPos1);
	
	pixelPos2.x += sin(pixelPos2.y * 4.0 + time * 1.0)  * 0.1;
	float color_g = circle(pixelPos2);
	
	pixelPos3.x += sin(pixelPos3.y * 7.0 + time * 3.0)  * 0.1;
	float color_b = circle(pixelPos3);
	
	gl_FragColor = vec4(1.0 - color_r, 1.0 - color_g, 1.0 - color_b, 1.0);
	
}