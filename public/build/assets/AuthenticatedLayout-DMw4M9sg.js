import{L as x,m as M,g as y,b as s,i as j,r as f,a as o,w as c,d as l,n as u,l as i,o as v}from"./app-DH8Vg3NP.js";/**
 * @license lucide-vue-next v0.562.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */const m=t=>t.replace(/([a-z0-9])([A-Z])/g,"$1-$2").toLowerCase(),$=t=>t.replace(/^([A-Z])|[\s-_]+(\w)/g,(e,r,a)=>a?a.toUpperCase():r.toLowerCase()),A=t=>{const e=$(t);return e.charAt(0).toUpperCase()+e.slice(1)},B=(...t)=>t.filter((e,r,a)=>!!e&&e.trim()!==""&&a.indexOf(e)===r).join(" ").trim(),w=t=>t==="";/**
 * @license lucide-vue-next v0.562.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */var d={xmlns:"http://www.w3.org/2000/svg",width:24,height:24,viewBox:"0 0 24 24",fill:"none",stroke:"currentColor","stroke-width":2,"stroke-linecap":"round","stroke-linejoin":"round"};/**
 * @license lucide-vue-next v0.562.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */const H=({name:t,iconNode:e,absoluteStrokeWidth:r,"absolute-stroke-width":a,strokeWidth:n,"stroke-width":b,size:g=d.width,color:C=d.stroke,...p},{slots:k})=>x("svg",{...d,...p,width:g,height:g,stroke:C,"stroke-width":w(r)||w(a)||r===!0||a===!0?Number(n||b||d["stroke-width"])*24/Number(g):n||b||d["stroke-width"],class:B("lucide",p.class,...t?[`lucide-${m(A(t))}-icon`,`lucide-${m(t)}`]:["lucide-icon"])},[...e.map(_=>x(..._)),...k.default?[k.default()]:[]]);/**
 * @license lucide-vue-next v0.562.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */const h=(t,e)=>(r,{slots:a,attrs:n})=>x(H,{...n,...r,iconNode:e,name:t},a);/**
 * @license lucide-vue-next v0.562.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */const L=h("globe",[["circle",{cx:"12",cy:"12",r:"10",key:"1mglay"}],["path",{d:"M12 2a14.5 14.5 0 0 0 0 20 14.5 14.5 0 0 0 0-20",key:"13o1zl"}],["path",{d:"M2 12h20",key:"9i4pu4"}]]);/**
 * @license lucide-vue-next v0.562.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */const U=h("house",[["path",{d:"M15 21v-8a1 1 0 0 0-1-1h-4a1 1 0 0 0-1 1v8",key:"5wwlr5"}],["path",{d:"M3 10a2 2 0 0 1 .709-1.528l7-6a2 2 0 0 1 2.582 0l7 6A2 2 0 0 1 21 10v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z",key:"r6nss1"}]]);/**
 * @license lucide-vue-next v0.562.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */const z=h("user",[["path",{d:"M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2",key:"975kel"}],["circle",{cx:"12",cy:"7",r:"4",key:"17ys0d"}]]);/**
 * @license lucide-vue-next v0.562.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */const N=h("users",[["path",{d:"M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2",key:"1yyitq"}],["path",{d:"M16 3.128a4 4 0 0 1 0 7.744",key:"16gr8j"}],["path",{d:"M22 21v-2a4 4 0 0 0-3-3.87",key:"kshegd"}],["circle",{cx:"9",cy:"7",r:"4",key:"nufk8"}]]),V={class:"min-h-screen bg-gray-100 dark:bg-gray-900"},E={key:0,class:"bg-white shadow dark:bg-gray-800"},F={class:"mx-auto max-w-7xl px-4 py-6 sm:px-6 lg:px-8"},I={class:"mb-20"},P={class:"fixed bottom-0 left-1/2 -translate-x-1/2 z-50 w-full max-w-md border-t border-gray-200 bg-white dark:border-gray-600 dark:bg-gray-800"},Z={class:"mx-auto grid h-16 w-full grid-cols-4 font-medium"},G={__name:"AuthenticatedLayout",setup(t){return M(!1),(e,r)=>(v(),y("div",null,[s("div",V,[e.$slots.header?(v(),y("header",E,[s("div",F,[f(e.$slots,"header")])])):j("",!0),s("main",I,[f(e.$slots,"default")]),s("nav",P,[s("div",Z,[o(l(i),{href:e.route("habits.index"),class:"group inline-flex flex-col items-center justify-center px-5 hover:bg-gray-50 dark:hover:bg-gray-700"},{default:c(()=>[o(l(U),{class:u(["mb-1 h-6 w-6 text-gray-500 group-hover:text-blue-600 dark:text-gray-400 dark:group-hover:text-blue-500",{"text-blue-600 dark:text-blue-500":e.route().current("habits.*")}])},null,8,["class"]),s("span",{class:u(["text-xs text-gray-500 group-hover:text-blue-600 dark:text-gray-400 dark:group-hover:text-blue-500",{"text-blue-600 dark:text-blue-500":e.route().current("habits.*")}])},"Habits",2)]),_:1},8,["href"]),o(l(i),{href:e.route("friendships.index"),class:"group inline-flex flex-col items-center justify-center px-5 hover:bg-gray-50 dark:hover:bg-gray-700"},{default:c(()=>[o(l(N),{class:u(["mb-1 h-6 w-6 text-gray-500 group-hover:text-blue-600 dark:text-gray-400 dark:group-hover:text-blue-500",{"text-blue-600 dark:text-blue-500":e.route().current("friendships.*")}])},null,8,["class"]),s("span",{class:u(["text-xs text-gray-500 group-hover:text-blue-600 dark:text-gray-400 dark:group-hover:text-blue-500",{"text-blue-600 dark:text-blue-500":e.route().current("friendships.*")}])},"Friends",2)]),_:1},8,["href"]),o(l(i),{href:e.route("social.index"),class:"group inline-flex flex-col items-center justify-center px-5 hover:bg-gray-50 dark:hover:bg-gray-700"},{default:c(()=>[o(l(L),{class:u(["mb-1 h-6 w-6 text-gray-500 group-hover:text-blue-600 dark:text-gray-400 dark:group-hover:text-blue-500",{"text-blue-600 dark:text-blue-500":e.route().current("social.*")}])},null,8,["class"]),s("span",{class:u(["text-xs text-gray-500 group-hover:text-blue-600 dark:text-gray-400 dark:group-hover:text-blue-500",{"text-blue-600 dark:text-blue-500":e.route().current("social.*")}])},"Feed",2)]),_:1},8,["href"]),o(l(i),{href:e.route("profile.edit"),class:"group inline-flex flex-col items-center justify-center px-5 hover:bg-gray-50 dark:hover:bg-gray-700"},{default:c(()=>[o(l(z),{class:u(["mb-1 h-6 w-6 text-gray-500 group-hover:text-blue-600 dark:text-gray-400 dark:group-hover:text-blue-500",{"text-blue-600 dark:text-blue-500":e.route().current("profile.*")}])},null,8,["class"]),s("span",{class:u(["text-xs text-gray-500 dark:text-gray-400 group-hover:text-blue-600 dark:group-hover:text-blue-500",{"text-blue-600 dark:text-blue-500":e.route().current("profile.*")}])},"Profile",2)]),_:1},8,["href"])])])])]))}};export{G as _,h as c};
