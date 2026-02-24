//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_time;
uniform float u_chroma_intensity;
uniform float u_vignette_amount;
uniform vec3 u_filter_color;

float hash(vec2 p){
	return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453123);
}

void main()
{
    // aberracao
	float r = texture2D(gm_BaseTexture, v_vTexcoord + vec4(u_chroma_intensity, 0.0, 0.0, 0.0).xy).r;
	float g = texture2D(gm_BaseTexture, v_vTexcoord).g;
	float b = texture2D(gm_BaseTexture, v_vTexcoord - vec4(u_chroma_intensity, 0.0, 0.0, 0.0).xy).b;
	
	vec3 color = vec3(r, g, b);
	
	// filtro
	color *= u_filter_color;
	
	// ruido
	float noise = (hash(v_vTexcoord + u_time) - 0.4) * 0.15;
	color += noise;
	
	// vinheta
	float dist = distance(v_vTexcoord, vec2(0.5));
	float vignette = smoothstep(0.8, 0.8 - u_vignette_amount, dist);
	color *= vignette;
	
	gl_FragColor = v_vColour * vec4(color, 1.0);
}
