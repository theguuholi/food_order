export default class CartInfo {
    constructor(socket) {
        console.log("here!!")
        this.socket = socket;
    }

    createCart(cartId) {
        console.log("start!!")
        let channel = socket.channel(`cart:${cartId}`, {})
        channel.join()
            .receive("ok", resp => {
                document.querySelector("#cart-counter").innerHTML = resp.total_qty
            })
            .receive("error", resp => {
                console.log("Unable to join", resp)
            })
    }
}