<template>
  <v-card>
    <div v-if="this.$store.getters['courier/isLoading']">
      <v-progress-linear :indeterminate="true" height="10"></v-progress-linear>
    </div>
    <v-data-table :headers="headers" :items="orders" v-bind:pagination.sync="pagination">
      <template v-slot:no-data>
        <v-flex class="text-xs-center">
          <v-alert type="info" outline :value="true">No open orders.</v-alert>
        </v-flex>
      </template>
      <template slot="items" slot-scope="props">
        <tr @click="toggleDialog(props.item)">
          <td>{{props.item.order_id}}</td>
          <td>{{props.item.first_name}}</td>
          <td>{{props.item.room_num}}</td>
          <td>{{props.item.time_created}}</td>
        </tr>
      </template>
    </v-data-table>
  </v-card>
</template>
    
<script>
export default {
  name: "CourierAvailableOrders",
  data() {
    return {
      activeDialog: false,
      pagination: { sortBy: "order_id", descending: true, rowsPerPage: 5 },
      headers: [
        { text: "Order #", align: "left", value: "order_id" },
        { text: "Name", align: "left", value: "first_name" },
        { text: "Room #", align: "left", value: "room_num" },
        { text: "Time Created", align: "left", value: "time_created" }
      ]
    };
  },
  props: {
    orders: Array
  },
  computed: {
    isDialog() {
      return this.activeDialog;
    }
  },
  methods: {
    toggleDialog(value) {
      this.$emit("toggleSummary", value);
    }
  }
};
</script>

<style scoped lang="css">
.v-datatable {
  margin-top: 200px !important;
}

.v-progress-linear {
  margin: auto !important;
}
</style>
