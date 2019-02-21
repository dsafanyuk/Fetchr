<template>
  <v-card>
    <v-data-table :headers="headers" :items="orders" v-bind:pagination.sync="pagination">
      <template slot="items" slot-scope="props">
        <td>{{props.item.order_id}}</td>
        <td>{{props.item.first_name}}</td>
        <td>{{props.item.room_num}}</td>
        <td>{{props.item.time_created}}</td>
        <td>{{props.item.delivery_status}}</td>
        <td>
          <CourierOrderSummary
            v-if="props.item.order_id != ''"
            :orderID="props.item.order_id"
            :deliver="true"
            v-on:delivered="delivered"
          ></CourierOrderSummary>
        </td>
      </template>
    </v-data-table>
  </v-card>
</template>
    <script>
import CourierOrderSummary from "../mini-components/Courier/CourierOrderSummary";
export default {
  name: "CourierAvailableOrders",
  data() {
    return {
      pagination: { sortBy: "order_id", descending: true, rowsPerPage: 5 },
      headers: [
        { text: "Order #", align: "left", value: "order_id" },
        { text: "Name", align: "left", value: "first_name" },
        { text: "Room #", align: "left", value: "room_num" },
        { text: "Time Created", align: "left", value: "time_created" }
      ],
      isNotDelivered: true
    };
  },
  props: {
    orders: Array
  },
  computed: {},
  components: {
    CourierOrderSummary: CourierOrderSummary
  },
  methods: {
    delivered() {
      this.$emit("delivered");
    }
  }
};
</script>
    
    <style scoped lang="css">
</style>
    