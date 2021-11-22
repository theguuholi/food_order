const ScrollProducts = {
    mounted(){
        console.log("here!!")
        console.log("mounted", this.el)
        this.observer = new IntersectionObserver(entries => {
            const entry = entries[0];
            console.log(entries)
            if(entry.isIntersecting){
                console.log(entry)
                this.pushEventTo(entry.target.id, "load_products", {})
            }
        })
        this.observer.observe(this.el)
    },
    updated(){
        const pageNumber = this.el.dataset.pageNumber;
        console.log("updated", pageNumber)
    },
    destroyed(){
        // this.observer.disconnect();
    }
}

export default ScrollProducts;