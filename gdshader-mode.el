;;; gdshader-mode.el --- Major mode for Godot gdshader

;; Author: Simon Carter <bbbscarter@gmail.com>
;; URL: https://github.com/bbbscarter/gdshader-mode
;; Keywords: languages OpenGL GPU Godot
;; Package-Requires: ((glsl-mode "2.4"))
;; Version: 0.1

;; Copyright (C) 2023 bbbscarter

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;; Extension to glsl-mode that adds support for Godot's gdshader additions.

;; Reference
;; <https://docs.godotengine.org/en/stable/tutorials/shaders/shader_reference/index.html>
;; <https://github.com/jimhourihan/glsl-mode>

;;; Code:

(require 'glsl-mode)

(eval-and-compile
  (defvar gdshader-builtin-list
    '("NODE_POSITION_WORLD" "TIME" "PI" "TAU" "VIEWPORT_SIZE"
      "VIEWPORT_SIZE" "FRAGCOORD" "FRONT_FACING" "VIEW" "UV"
      "UV2" "COLOR" "POINT_COORD" "OUTPUT_IS_SRGB" "MODEL_MATRIX"
      "MODEL_NORMAL_MATRIX" "VIEW_MATRIX" "INV_VIEW_MATRIX" "PROJECTION_MATRIX"
      "INV_PROJECTION_MATRIX" "NODE_POSITION_WORLD" "NODE_POSITION_VIEW" "CAMERA_POSITION_WORLD"
      "CAMERA_DIRECTION_WORLD" "VERTEX" "VIEW_INDEX" "VIEW_MONO_LEFT" "VIEW_RIGHT"
      "EYE_OFFSET" "SCREEN_UV" "DEPTH" "NORMAL" "TANGENT" "BINORMAL" "NORMAL_MAP"
      "NORMAL_MAP_DEPTH" "ALBEDO" "ALPHA" "ALPHA_SCISSOR_THRESHOLD" "ALPHA_HASH_SCALE"
      "ALPHA_ANTIALIASING_EDGE" "ALPHA_TEXTURE_COORDINATE" "METALLIC" "SPECULAR" "ROUGHNESS"
      "RIM" "RIM_TINT" "CLEARCOAT" "CLEARCOAT_GLOSS" "ANISOTROPY" "ANISOTROPY_FLOW"
      "SSS_STRENGTH" "SSS_TRANSMITTANCE_COLOR" "SSS_TRANSMITTANCE_DEPTH" "SSS_TRANSMITTANCE_BOOST"
      "BACKLIGHT" "AO" "AO_LIGHT_AFFECT" "EMISSION" "FOG" "RADIANCE"
      "IRRADIANCE" "DIFFUSE_LIGHT" "SPECULE_LIGHT" "LIGHT" "LIGHT_COLOR"
      "SPECULAR_AMOUNT" "LIGHT_IS_DIRECTIONAL" "ATTENUATION"

      "source_color" "hint_range" "sampler2D" "source_color" "hint_normal"
      "hint_default_white" "hint_default_black" "hint_default_transparent" "hint_anisotropy"
      "hint_roughness_r" "hint_roughness_g" "hint_roughness_b" "hint_roughness_a"
      "hint_roughness_normal" "hint_roughness_gray" "filter_nearest" "filter_nearest_mipmap"
      "filter_nearest_mipmap_anisotropic" "filter_nearest_anisotropic" "filter_linear"
      "filter_linear_mipmap" "filter_linear_mipmap_anisotropic" "filter_linear_anisotropic"
      "repeat_enable" "repeat_disable" "hint_screen_texture"
      "hint_depth_texture" "hint_normal_roughness_texture"))

  (defvar gdshader-keyword-list
    '("shader_type" "render_mode" "group_uniforms"))

  (defvar gdshader-qualifier-list
    '("global"))

  (defvar gdshader-type-list
    '("blend_mix" "blend_add" "blend_sub" "blend_mul" "depth_draw_opaque" "spatial" "canvas"
      "depth_draw_always" "depth_draw_never" "depth_prepass_alpha" "depth_test_disabled"
      "sss_mode_skin" "cull_back" "cull_front" "cull_disabled" "unshaded"
      "wireframe" "diffuse_lambert" "diffuse_lambert_wrap" "diffuse_burley"
      "diffuse_toon" "specular_schlick_ggx" "specular_blinn" "specular_phong"
      "specular_toon" "specular_disabled" "skip_vertex_transform" "world_vertex_coords"
      "ensure_correct_normals" "shadows_disabled" "ambient_light_disabled" "shadow_to_opacity"
      "vertex_lighting" "particle_trails" "alpha_to_coverage" "alpha_to_coverage_and_one"))
  ) ; eval-and-compile


(defvar gdshader-all-keywords
  (append glsl-builtins-list
          glsl-keyword-list
          glsl-type-list
          glsl-qualifier-list
          glsl-additional-keywords
          glsl-additional-types
          glsl-additional-qualifiers
          glsl-additional-built-ins
          gdshader-builtin-list
          gdshader-keyword-list
          gdshader-type-list
          gdshader-qualifier-list)  
  "List of all the font-locked words. Useful for completion systems like 'company-keywords'")

(defvar gdshader--type-rx (regexp-opt gdshader-type-list 'symbols))
(defvar gdshader--keywords-rx (regexp-opt gdshader-keyword-list 'symbols))
(defvar gdshader--builtins-rx (regexp-opt gdshader-builtin-list 'symbols))
(defvar gdshader--qualifier-rx (regexp-opt gdshader-qualifier-list 'symbols))

;;;###autoload
(define-derived-mode gdshader-mode
  glsl-mode "GDShader"
  "Major mode for Godot Shaders."
  :syntax-table nil

  (setq-local glsl-additional-built-ins '("NODE_POSITION_WORLD"))
  (setq-local glsl-additional-keywords '("shader_type"))

  (font-lock-add-keywords
   nil
   `(
     (,gdshader--builtins-rx         . glsl-builtins-face)
     (,gdshader--type-rx             . glsl-builtins-face)
     (,gdshader--keywords-rx         . glsl-keyword-face)
     (,gdshader--qualifier-rx        . glsl-qualifier-face))))

  ;; (set (make-local-variable 'font-lock-defaults) '(gdshader-font-lock-keywords)))


;;;###autoload
(add-to-list 'auto-mode-alist '("\\.gdshader\\'" . gdshader-mode))

(provide 'gdshader-mode)
;;; gdshader-mode.el ends here
