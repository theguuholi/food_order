
export default {
    mounted() {
        this.handleEvent("create-session-id", map => {
            var {cartId: cartId} = map;
            sessionStorage.setItem("cart_id", cartId)
        })
    }
};