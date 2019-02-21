<template>
  <v-card>
    <v-card-title>Available Orders
      <v-spacer></v-spacer>
      <v-text-field v-model="search" append-icon="search" label="Search" single-line hide-details></v-text-field>
    </v-card-title>
    <v-data-table
      :headers="headers"
      :items="orders"
      :search="search"
      v-bind:pagination.sync="pagination"
    >
      <template slot="items" slot-scope="props">
        <td>{{props.item.order_id}}</td>
        <td>{{props.item.first_name}}</td>
        <td>{{props.item.room_num}}</td>
        <td>{{props.item.time_created}}</td>
        <td>
          <CourierOrderSummary
            v-if="props.item.order_id != ''"
            :orderID="props.item.order_id"
            :accept="true"
            :deliver="false"
            v-on:accepted="accepted"
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
        { text: "Delivery Status", align: "left", value: "delivery_status" }
      ],
      search: ""
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
    accepted() {
      this.$emit("accepted");
    }
  }
};
</script>

<style scoped lang="css">
.v-datatable {
  margin-top: 200px !important;
}
</style>
