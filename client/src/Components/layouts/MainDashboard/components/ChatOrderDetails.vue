<template>
  <v-data-table :items="items" :total-items="items.length" hide-actions class="elevation-1">
    <template slot="items" slot-scope="props">
      <td align="center">
        <img height="100px" :src="props.item.product_url" class="checkout-img">
      </td>
      <td class="body-2">{{ props.item.product_name }}</td>
      <td class="text-xs-left">${{ (props.item.item_total).toFixed(2) }}</td>
      <td class="text-xs-left">{{ props.item.quantity }}</td>
    </template>
    <template slot="footer">
      <td class="text-xs-right" :colspan="2">
        <strong>Total</strong>
      </td>
      <td class="text-xs-left" :colspan="4">${{total.toFixed(2)}}</td>
    </template>
  </v-data-table>
</template>

<script>
import browserCookies from "browser-cookies";
import axios from "../../../../axios";

export default {
  data() {
      return {
}
},
computed: {

},
mounted: function() {
this.getOrderSummary();
},
props : {
  items : Array,
  total : Number,
},
methods: {

}
};
</script>
<style scoped lang="css">
</style>
