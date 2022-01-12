import Drag from "./hooks/dragHook";
import CartSession from "./hooks/cartSession"
import ScrollProducts from "./hooks/scrollProducts"
import  InitCheckout from "./hooks/initCheckout";


let Hooks = {
    Drag: Drag,
    CartSession: CartSession,
    InitCheckout: InitCheckout,
    ScrollProducts: ScrollProducts
};

export default Hooks;