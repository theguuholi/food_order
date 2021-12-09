export default class CartInfo {
    constructor(socket){
        this.socket = socket;
    }

    createCart(cartId) {
        console.log("start!!")
        let channel = socket.channel(`cart:${cartId}`, {})
        channel.join()
          .receive("ok", resp => {
              console.log(resp)
          })
    }
}
