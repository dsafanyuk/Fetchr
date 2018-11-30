<template>
<v-app>
    <LandingHeader></LandingHeader>
    <div class="checkout">
        <h3>Checkout</h3>
        <v-data-table 
            :headers="headers"
            :items="products">
            <template slot="items" slot-scope="props">
                <td>{{ props.item.product_name }}</td>
                <td class="text-xs-left">${{ props.item.price }}</td>
                <td class="text-xs-left">{{ props.item.quantity }}</td>
            </template>
        </v-data-table>
        <div class="submitOrderButton">
            <button
                class="btn btn-outline-dark my-2 my-sm-0" 
                type="submit"
                v-on:click="checkout">
                    Submit Order
            </button>
        </div>
    </div>
    <LandingFooter></LandingFooter>
</v-app>
</template>
    
    <script>
    import LandingHeader from './mini-components/LandingHeader.vue';
    import LandingFooter from './mini-components/LandingFooter.vue';
    import browserCookies from 'browser-cookies';
    import axios from 'axios';
    import State from './assets/js/shoppingCartState';
    
    export default {
    
      data () {
        name: 
        return {
            products: [],
            headers: [
                { text: 'Name', align: 'left', value:'product_name' },
                { text: 'Price', align: 'left', value:'price' },
                { text: 'Quantity', align: 'left', value:'quantity' },
            ],
            //This is the products recieved from cart
            productsReceived: [],
        };
      },
      mounted: function() {
        this.productsReceived = State.data.cart
        //setting prods in table
        this.products = this.productsReceived.map((product) => {
                    //put price in right format
                    product.price = product.price.toFixed(2)
                    //this is for the v-data-table
                    product.value = false
                    product.quantity = 1
                    return product
                })
      },
      methods:{
            checkout: function(event) {
                let router = this.$router

                let total = 0
                let productsWithQuantity = []
                this.productsReceived.map((product) => {
                    //get the total of the products for the order
                    total += parseFloat(product.price)
                    //put all the products into a json array
                    productsWithQuantity.push(
                        {
                            product_id: product.product_id,
                            quantity: product.quantity
                        }
                    )
                })
                axios.post('http://127.0.0.1:3000/api/orders/',
                    {
                        customer_id: browserCookies.get('userId'),
                        delivery_status: 'pending',
                        order_total: total,
                        productsWithQuantity: productsWithQuantity
                    }
                ).then(function(response) {
                    //go to the confirmation page and send it the order id
                    router.push('/confirmation?order=' + response.data.message);
                })
                .catch(function(response) {
                    console.log(response)
                })
          }
      },
      components: {
        LandingHeader: LandingHeader,
        LandingFooter: LandingFooter,
      },
    }
    
    </script>
    
    <style scoped lang="css" src='./custom_css/checkout.css'>
    </style>
    
