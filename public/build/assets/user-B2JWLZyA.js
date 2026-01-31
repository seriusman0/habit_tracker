import{h as n}from"./runtime-dom.esm-bundler-s_AMX6vw.js";/**
 * @license lucide-vue-next v0.562.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */const d=e=>e.replace(/([a-z0-9])([A-Z])/g,"$1-$2").toLowerCase(),m=e=>e.replace(/^([A-Z])|[\s-_]+(\w)/g,(t,o,r)=>r?r.toUpperCase():o.toLowerCase()),g=e=>{const t=m(e);return t.charAt(0).toUpperCase()+t.slice(1)},v=(...e)=>e.filter((t,o,r)=>!!t&&t.trim()!==""&&r.indexOf(t)===o).join(" ").trim(),w=e=>e==="";/**
 * @license lucide-vue-next v0.562.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */var s={xmlns:"http://www.w3.org/2000/svg",width:24,height:24,viewBox:"0 0 24 24",fill:"none",stroke:"currentColor","stroke-width":2,"stroke-linecap":"round","stroke-linejoin":"round"};/**
 * @license lucide-vue-next v0.562.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */const C=({name:e,iconNode:t,absoluteStrokeWidth:o,"absolute-stroke-width":r,strokeWidth:c,"stroke-width":i,size:a=s.width,color:k=s.stroke,...l},{slots:u})=>n("svg",{...s,...l,width:a,height:a,stroke:k,"stroke-width":w(o)||w(r)||o===!0||r===!0?Number(c||i||s["stroke-width"])*24/Number(a):c||i||s["stroke-width"],class:v("lucide",l.class,...e?[`lucide-${d(g(e))}-icon`,`lucide-${d(e)}`]:["lucide-icon"])},[...t.map(p=>n(...p)),...u.default?[u.default()]:[]]);/**
 * @license lucide-vue-next v0.562.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */const h=(e,t)=>(o,{slots:r,attrs:c})=>n(C,{...c,...o,iconNode:t,name:e},r);/**
 * @license lucide-vue-next v0.562.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */const y=h("house",[["path",{d:"M15 21v-8a1 1 0 0 0-1-1h-4a1 1 0 0 0-1 1v8",key:"5wwlr5"}],["path",{d:"M3 10a2 2 0 0 1 .709-1.528l7-6a2 2 0 0 1 2.582 0l7 6A2 2 0 0 1 21 10v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z",key:"r6nss1"}]]);/**
 * @license lucide-vue-next v0.562.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */const x=h("user",[["path",{d:"M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2",key:"975kel"}],["circle",{cx:"12",cy:"7",r:"4",key:"17ys0d"}]]);export{y as H,x as U,h as c};
