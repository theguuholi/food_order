import Sortable from "sortablejs";

export default {
    mounted() {
        let dragged;
        const hook = this;
        const selector = "#" + this.el.id

        console.log(selector)
        document.querySelectorAll('.dropzone').forEach(dropzone => {

            new Sortable(dropzone, {
                animation: 0,
                delay: 50,
                delayOnTouchOnly: true,
                group: 'shared',
                draggable: '.draggable',
                ghostClass: 'sortable-ghost',
                onEnd: function (evt) {
                    hook.pushEventTo(selector, 'dropped', {
                        orderId: evt.item.id,
                        orderStatus: evt.to.id,
                        orderOldStatus: evt.from.id,
                        draggableIndex: evt.newDraggableIndex
                    })
                }
            });

            console.log("here!!")
        });
    }
};