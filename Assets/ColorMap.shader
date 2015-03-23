Shader "Custom/ColorMap" {
    Properties {
        _MainTex ("Texture", 2D) = "white" { }
        _Gradient ("Texture", 2D) = "white" { }
    }
    SubShader {
        Pass {

        CGPROGRAM
        #pragma vertex vert
        #pragma fragment frag

        #include "UnityCG.cginc"

        sampler2D _MainTex;
        sampler2D _Gradient;
        
        struct appdata {
		  float4 vertex : POSITION;
		  float2 texcoord : TEXCOORD0;
		};

        struct v2f {
            float4 pos : SV_POSITION;
            float2 uv : TEXCOORD0;
        };

        v2f vert (appdata v)
        {
            v2f o;
            o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
            o.uv = v.texcoord;
            return o;
        }

        fixed4 frag (v2f i) : SV_Target
        {
            fixed4 texcol = tex2D (_MainTex, i.uv);
            return tex2D (_Gradient, float2(texcol.r, 0));
        }
        ENDCG

        }
    }
}
