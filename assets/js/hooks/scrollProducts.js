const ScrollProducts = {
    mounted(){
        const selector = "#" + this.el.id
        this.observer = new IntersectionObserver(entries => {
            const entry = entries[0];
            if(entry.isIntersecting){
                console.log(entry)
                this.pushEventTo(selector, "load_products", {})
            }
        })
        this.observer.observe(this.el)
    },
    updated(){
        const pageNumber = this.el.dataset.pageNumber;
        console.log("updated", pageNumber)
    },
    destroyed(){
        this.observer.disconnect();
    }
}

export default ScrollProducts;