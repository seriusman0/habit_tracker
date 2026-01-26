import { _ as c } from "./_plugin-vue_export-helper-DlAUqK2U.js";
import {
    g as r,
    o as a,
    b as t,
    a as s,
    w as n,
    d as l,
    l as _,
    r as d,
} from "./app-DH8Vg3NP.js";
const i = {},
    m = { src: "/img/logo.jpg", alt: "Logo" };
function f(o, e) {
    return (a(), r("img", m));
}
const u = c(i, [["render", f]]),
    p = {
        class: "flex min-h-screen flex-col items-center bg-gray-100 pt-6 sm:justify-center sm:pt-0 dark:bg-gray-900",
    },
    g = {
        class: "mt-6 w-full overflow-hidden bg-white px-6 py-4 shadow-md sm:max-w-md sm:rounded-lg dark:bg-gray-800",
    },
    y = {
        __name: "GuestLayout",
        setup(o) {
            return (e, h) => (
                a(),
                r("div", p, [
                    t("div", null, [
                        s(
                            l(_),
                            { href: "/" },
                            {
                                default: n(() => [
                                    s(u, {
                                        class: "h-20 w-20 fill-current text-gray-500",
                                    }),
                                ]),
                                _: 1,
                            },
                        ),
                    ]),
                    t("div", g, [d(e.$slots, "default")]),
                ])
            );
        },
    };
export { y as _ };
